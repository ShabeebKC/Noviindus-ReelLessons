import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:reel_lessons/constants/app_configs.dart';
import 'package:reel_lessons/modules/dashboard/data/models/add_feed_response.dart';
import 'package:reel_lessons/modules/dashboard/data/models/home_response.dart';
import '../../../../constants/api_urls.dart';
import '../models/categories_reponse.dart';
import 'package:http_parser/http_parser.dart';

class DashboardDataSource {

  static Future<CategoriesResponse?> fetchCategories() async {
    final response = await http.get(
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
    final response = await http.get(
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
    }
    return null;
  }

  static Future<AddFeedResponse?> uploadFeed(File videoFile, File imageFile, String desc, List<int> categories) async {
    final request = http.MultipartRequest("POST", Uri.parse(ApiUrls.myFeedPost));
    request.headers.addAll({
      "Authorization": "Bearer ${AppConfigs.accessKey}",
      "Accept": "application/json",
    });

    request.fields['desc'] = desc;
    request.fields['category'] = jsonEncode(categories);
    request.files.add(await http.MultipartFile.fromPath(
      'video',
      videoFile.path,
      contentType: MediaType('video', 'mp4'),
    ));
    request.files.add(await http.MultipartFile.fromPath(
      'image',
      imageFile.path,
      contentType: MediaType('image', 'jpeg'),
    ));

    final response = await request.send();
    final responseBody = await response.stream.bytesToString();
    if (response.statusCode == 200 || response.statusCode == 202) {
      final jsonData = json.decode(responseBody);
      return AddFeedResponse.fromJson(jsonData);
    }
    return null;
  }

}