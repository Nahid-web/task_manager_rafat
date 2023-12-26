import 'dart:convert';
import 'dart:developer';

import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:task_manager_rafat/data/data.network_caller/network_response.dart';
import 'package:task_manager_rafat/ui/controller/auth_controller.dart';
import 'package:flutter/material.dart';

import '../../main.dart';
import '../../ui/screens/login_screen.dart';

class NetworkCaller {
  Future<NetworkResponse> postRequest(String url, {dynamic body, bool isLogin = false}) async {
    try {
      log(url.toString());
      log(body.toString());
      http.Response response = await http.post(
        Uri.parse(url),
        body: jsonEncode(body),
        headers: {
          'content-type': 'Application/json',
          'token': AuthController.token.toString(),
        },
      );

      log(response.headers.toString());
      log(response.statusCode.toString());
      log(response.body.toString());
      if (response.statusCode == 200) {
        return NetworkResponse(
          isSuccess: true,
          statusCode: 200,
          jsonResponse: jsonDecode(response.body),
        );
      } else if (response.statusCode == 401) {
        if(isLogin == false){
          backToLogin();
        }
        return NetworkResponse(
          isSuccess: false,
          statusCode: response.statusCode,
          jsonResponse: jsonDecode(response.body),
        );
      } else {
        return NetworkResponse(
          isSuccess: false,
          statusCode: response.statusCode,
          jsonResponse: jsonDecode(response.body),
        );
      }
    } catch (e) {
      return NetworkResponse(
        isSuccess: false,
        errorMessage: e.toString(),
      );
    }
  }
  Future<NetworkResponse> getRequest(String url) async {
    try {
      log(url.toString());
      http.Response response = await http.get(
        Uri.parse(url),
        headers: {
          'content-type': 'Application/json',
          'token': AuthController.token.toString(),
        },
      );

      log(response.headers.toString());
      log(response.statusCode.toString());
      log(response.body.toString());
      if (response.statusCode == 200) {
        return NetworkResponse(
          isSuccess: true,
          statusCode: 200,
          jsonResponse: jsonDecode(response.body),
        );
      } else if (response.statusCode == 401) {
          backToLogin();
        return NetworkResponse(
          isSuccess: false,
          statusCode: response.statusCode,
          jsonResponse: jsonDecode(response.body),
        );
      } else {
        return NetworkResponse(
          isSuccess: false,
          statusCode: response.statusCode,
          jsonResponse: jsonDecode(response.body),
        );
      }
    } catch (e) {
      return NetworkResponse(
        isSuccess: false,
        errorMessage: e.toString(),
      );
    }
  }

  Future<void> backToLogin() async {
    await Get.find<AuthController>().clearAuthData();
    Navigator.pushAndRemoveUntil(
        MyApp.navigationKey.currentContext!,
        MaterialPageRoute(
          builder: (context) => const LoginScreen(),
        ),
        (route) => false);
  }
}
