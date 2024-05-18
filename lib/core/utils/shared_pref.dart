import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

class CommonSharedPreference{
  static setPreferences(String key, String value) async {
    var prefs = await SharedPreferences.getInstance();
    prefs.setString(key, value);
  }

  static Future<dynamic> getPreferences(String key) async {
    var prefs = await SharedPreferences.getInstance();
    String stringValue = prefs.getString(key).toString();
    return stringValue;
  }


  static setBoolValues(String key, bool value) async {
    SharedPreferences sharedPrefs = await SharedPreferences.getInstance();
    sharedPrefs.setBool(key, value);
  }

  static getBoolValues(String key) async {
    SharedPreferences sharedPrefs = await SharedPreferences.getInstance();
    return sharedPrefs.getBool(key);
  }

  //save key value to sp
  static save(String key, value) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString(key,value);
  }
}