import 'dart:convert';
import 'dart:developer';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:reel_lessons/constants/app_configs.dart';
import '../../../../constants/api_urls.dart';
import '../models/my_feed_response.dart';

class ProfileDataSource {

  static Future<MyFeedResponse?> fetchMyFeeds(int page) async {
    var response = await http.get(
        Uri.parse(ApiUrls.myFeed(page)),
        headers: {
          "Content-Type": "application/json",
          'Authorization': 'Bearer ${AppConfigs.accessKey}',
        }
    );
    debugPrint("MyFeed Response status code : ${response.statusCode}");
    log("MyFeed Response: ${response.body.toString()}");
    if (response.statusCode == 202 || response.statusCode == 200) {
      final responseJson = json.decode(response.body);
      return MyFeedResponse.fromJson(responseJson);
    }
    if (response.statusCode == 401) {
      log("MyFeed Response status code : ${response.statusCode}");
    } else {
      return null;
    }
    return null;
  }

}