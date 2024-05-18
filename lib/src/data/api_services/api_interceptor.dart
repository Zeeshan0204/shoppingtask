import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;


class ApiInterceptor {
  ///****************** Get Api ******************///
  static Future<http.Response?> getApi(String? url) async {
    try {
      final response = await http.get(
        Uri.parse(url!),
      );
      return response;
    } catch (e) {
      debugPrint(e.toString());
      rethrow;
    }
  }

  ///****************** Post Api ******************///
  static Future<http.Response?> postApi(String? url, var body) async {
    try {
      final response = await http.post(
        Uri.parse(url!),
        body: body,
      );
      return response;
    } catch (e) {
      debugPrint(e.toString());
      rethrow;
    }
  }

}
