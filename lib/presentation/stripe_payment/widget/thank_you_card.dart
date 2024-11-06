
import 'package:ecommerce_app/core/utils/style/font_size.dart';
import 'package:ecommerce_app/presentation/stripe_payment/widget/payment_item_info.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'card_info_widget.dart';
import 'cart_total_price.dart';

class ThankYouCard extends StatelessWidget {
  final int total;
  const ThankYouCard({
    super.key,
    required this.total,
  });

  @override
  Widget build(BuildContext context) {
    DateTime now = DateTime.now();

    String formattedDate = DateFormat('MM/dd/yyyy').format(now);
    String formattedTime = DateFormat('hh:mm a').format(now);
    return Container(
      width: double.infinity,
      decoration: ShapeDecoration(
          color: Colors.grey.withOpacity(0.2),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          )),
      child: Padding(
        padding: const EdgeInsets.only(top: 50+16,left: 22,right: 22),
        child: Column(
          children: [
            Text(
              "Thank You!",
            textAlign: TextAlign.center,
              style:AppStyles.styleRegular23(context) ,
            ),
            Text(
              "Your transaction was successful",
              textAlign: TextAlign.center,
              style:AppStyles.styleRegular20(context) .copyWith(fontWeight: FontWeight.w300,color: Colors.black,fontSize: 16),
            ),
            SizedBox(height: 42,),
            PaymentItemInfo(title: "Date", value: formattedDate),
            SizedBox(height: 20),
            PaymentItemInfo(title: "Time", value: formattedTime),
            SizedBox(height: 20,),
            PaymentItemInfo(title:"To" ,value:"Haidy hesham" ,),
            Divider(thickness: 2,height: 60,),
            TotalPrice(title: "Total", value: r"$""${total}"),
            SizedBox(height: 30,),
            CardInfoWidget(),
            Spacer(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Icon(Icons.done,size: 64,),
                Container(
                  width: 113,
                  height: 58,
                  decoration: ShapeDecoration(
                      shape: RoundedRectangleBorder(
                        side: BorderSide(
                          width: 1.50,
                          color: Colors.greenAccent,
                          
                        ),borderRadius: BorderRadius.circular(15),
                      )),
                  child: Center(child: Text("PAID",style: AppStyles.styleRegular23(context).copyWith(color: Color(0XFF34A853)),)),

                ),
              ],
            ),
            SizedBox(
                height: ((MediaQuery.sizeOf(context).height *.2 + 20)  / 2) -29 ,)

          ],
        ),
      ),
    );
  }
}

