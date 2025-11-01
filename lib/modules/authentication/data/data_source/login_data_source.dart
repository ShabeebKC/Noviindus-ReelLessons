import 'dart:convert';
import 'dart:developer';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import '../../../../constants/api_urls.dart';
import '../models/login_response.dart';

class LoginDataSource{
  static Future<LoginResponse?> login(String phone) async {
    final Map<String, dynamic> body = {
      "country_code" : "+91",
      "phone" : phone
    };
    debugPrint("Login Request : $body");
    var response = await http.post(
      body: body,
      Uri.parse(ApiUrls.otpVerified),
    );
    debugPrint("Login Response status code : ${response.statusCode}");
    log("Login Response: ${response.body.toString()}");
    if (response.statusCode == 202 || response.statusCode == 200) {
      final responseJson = json.decode(response.body);
      return LoginResponse.fromJson(responseJson);
    }
    if (response.statusCode == 401) {
      log("Login Response status code : ${response.statusCode}");
    }else {
      return null;
    }
    return null;
  }
}