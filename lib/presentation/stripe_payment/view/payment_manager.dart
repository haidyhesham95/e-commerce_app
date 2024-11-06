import 'package:dio/dio.dart';
import 'package:flutter_stripe/flutter_stripe.dart';

import '../../../data/api/constance.dart';


abstract class PaymentManager {
  static Future<void> makePayment(int amount, String currency) async {
    try {
      String clientSecret = await _getClientSecret((amount * 100).toString(), currency);
      await _initializePaymentSheet(clientSecret);

      await Stripe.instance.presentPaymentSheet();
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  static Future<void> _initializePaymentSheet(String clientSecret) async {
    try {
      await Stripe.instance.initPaymentSheet(
        paymentSheetParameters: SetupPaymentSheetParameters(
          paymentIntentClientSecret: clientSecret,
          merchantDisplayName: 'Haidy',
        ),
      );
    } catch (e) {
      throw Exception("Failed to initialize payment sheet: ${e.toString()}");
    }
  }

  static Future<String> _getClientSecret(String amount, String currency) async {
    Dio dio = Dio();
    var response = await dio.post(
      'https://api.stripe.com/v1/payment_intents',
      options: Options(headers: {
        'Authorization': 'Bearer ${EndPoints.secretKey}',
        'Content-Type': 'application/x-www-form-urlencoded',
      }),
      data: {
        'amount': amount,
        'currency': currency,
      },
    );
    return response.data['client_secret'];
  }
}
