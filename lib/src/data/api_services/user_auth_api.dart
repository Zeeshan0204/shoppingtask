import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:fluttertask/src/data/api_constants/api_urls.dart';
import 'package:fluttertask/src/data/api_services/api_interceptor.dart';
import 'package:fluttertask/src/domain/models/category_model.dart';
import 'package:fluttertask/src/domain/models/product_model.dart';
import 'package:http/http.dart';


class UserAuthApis {


  // Product API
  static Future<List<ProductModel>?> getProduct({required String category}) async {
    String? url = ApiUrls.baseUrl + ApiUrls.products+category;
    print("URL : ${url}");
    try {
      Response? response = await ApiInterceptor.getApi(url);

      if (response?.statusCode == 200) {

        String? jsonString = response!.body;


        List<dynamic> jsonList = jsonDecode(jsonString);
        List<ProductModel> products = [];
        for (var item in jsonList) {
          products.add(ProductModel.fromJson(item));
        }
        return products;
      }
    } catch (e) {
      debugPrint(e.toString());
      rethrow;
    }
    return null;
  }

  // Category API
  static Future<List<CategoryModel>?> getCategory() async {
    String? url = ApiUrls.baseUrl + ApiUrls.categories;
    try {
      Response? response = await ApiInterceptor.getApi(url);

      if (response?.statusCode == 200) {

        String? jsonString = response!.body;
        List<dynamic> jsonList = jsonDecode(jsonString);
        print("JSONLIst : ${jsonList.toString()}");
        List<CategoryModel> category = [];
        for (var item in jsonList) {
          category.add(CategoryModel(item));
        }
        return category;
      }
    } catch (e) {
      debugPrint(e.toString());
      rethrow;
    }
    return null;
  }

  static Future<String?> login({
    required String usename,
    required String password,
  }) async {
    String? url = ApiUrls.baseUrl + ApiUrls.login;

    try {
      Map<String, dynamic> body = {
        "username": usename,
        "password": password,
      };
      Response? response = await ApiInterceptor.postApi(url, body);
      Map<String, dynamic> responseJson = json.decode(response!.body);

      if (response.statusCode == 200) {
        debugPrint(responseJson.toString());
        String? jsonString = response.body;
        return responseJson["token"];
      }

    } catch (e) {
      debugPrint(e.toString());
      rethrow;
    }
    return null;
  }
}
