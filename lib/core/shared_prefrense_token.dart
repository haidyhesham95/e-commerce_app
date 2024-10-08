import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../data/models/auth_model/auth_model.dart';

abstract class SharedPreferenceToken {
  static Future<void> saveUser(User user) async {
    try {
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setString('currentUser', jsonEncode(user.toJson()));
      print('User saved successfully.');
    } catch (e) {
      print('Error saving user: $e');
    }
  }

  static Future<User?> getUser() async {
    try {
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      final user = prefs.getString('currentUser');
      if (user != null) {
        return User.fromJson(jsonDecode(user));
      } else {
        print('No user data found.');
      }
    } catch (e) {
      print('Error retrieving user: $e');
    }
    return null;
  }

  static Future<void> saveToken(String token) async {
    try {
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setString('token', token);
      print('Token saved successfully.');
    } catch (e) {
      print('Error saving token: $e');
    }
  }

  static Future<String?> getToken() async {
    try {
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      final token = prefs.getString('token');
      if (token != null) {
        return token;
      } else {
        print('No token found.');
      }
    } catch (e) {
      print('Error retrieving token: $e');
    }
    return null;
  }

  static Future<void> clearAll() async {
    try {
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.remove('currentUser');
      await prefs.remove('token');
      print('All data cleared successfully.');
    } catch (e) {
      print('Error clearing data: $e');
    }
  }

  static Future<void> removeUser() async {
    try {
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.remove('currentUser');
      print('User removed successfully.');
    } catch (e) {
      print('Error removing user: $e');
    }
  }

  static Future<void> removeToken() async {
    try {
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.remove('token');
      print('Token removed successfully.');
    } catch (e) {
      print('Error removing token: $e');
    }
  }
}
