import 'dart:convert';
import 'dart:developer';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:reel_lessons/modules/dashboard/data/models/home_response.dart';
import '../../../../constants/api_urls.dart';
import '../models/categories_reponse.dart';

class DashboardDataSource {

  static Future<CategoriesResponse?> fetchCategories() async {
    var response = await http.get(
      Uri.parse(ApiUrls.categoryList),
    );
    debugPrint("Categories Response status code : ${response.statusCode}");
    log("Categories Response: ${response.body.toString()}");
    if (response.statusCode == 202 || response.statusCode == 200) {
      final responseJson = json.decode(response.body);
      return CategoriesResponse.fromJson(responseJson);
    }
    if (response.statusCode == 401) {
      log("Categories Response status code : ${response.statusCode}");
    } else {
      return null;
    }
    return null;
  }

  static Future<HomeResponse?> fetchHomeComponents() async {
    var response = await http.get(
      Uri.parse(ApiUrls.home),
    );
    debugPrint("Home Response status code : ${response.statusCode}");
    log("Home Response: ${response.body.toString()}");
    if (response.statusCode == 202 || response.statusCode == 200) {
      final responseJson = json.decode(response.body);
      return HomeResponse.fromJson(responseJson);
    }
    if (response.statusCode == 401) {
      log("Home Response status code : ${response.statusCode}");
    } else {
      return null;
    }
    return null;
  }

}