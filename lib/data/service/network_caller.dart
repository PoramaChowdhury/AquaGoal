import 'dart:convert';
import 'package:aquagoal/app.dart';
import 'package:aquagoal/data/models/network_response.dart';
import 'package:aquagoal/ui/controllers/auth_controller.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:aquagoal/ui/screens/sign_in_screen.dart';

class NetworkCaller {
  static Future<NetworkResponse> getRequest({required String url}) async {
    try {
      Uri uri = Uri.parse(url);
      Map<String, String> headers = {
        'token': AuthController.accessToken.toString(),
      };
      printRequest(url, null, headers);
      final Response response = await get(uri,headers: headers);
      printResponse(url, response);
      if (response.statusCode == 200) {
        final decodedData = jsonDecode(response.body);

        return NetworkResponse(
          isSuccess: true,
          statusCode: response.statusCode,
          responseData: decodedData,
        );
      }
      else if (response.statusCode == 401) {
        _moveToLogin();
        return NetworkResponse(
          isSuccess: false,
          statusCode: response.statusCode,
          errorMessage: 'Unauthenticated!',
        );
      }
      else {
        return NetworkResponse(
          isSuccess: false,
          statusCode: response.statusCode,
        );
      }
    } catch (e) {
      return NetworkResponse(
        isSuccess: false,
        statusCode: -1,
        errorMessage: e.toString(),
      );
    }
  }

  static Future<NetworkResponse> postRequest(
      {required String url, Map<String, dynamic>? body}) async {
    try {
      Uri uri = Uri.parse(url);
      Map<String, String> headers = {
        'Content-Type': 'application/json',
        'token': AuthController.accessToken.toString(),
      };
      printRequest(url, body, headers);
      final Response response = await post(
        uri,
        headers: headers,
        body: jsonEncode(body),
      );

      printResponse(url, response);

      if (response.statusCode == 200) {
        final decodedData = jsonDecode(response.body);

        if (decodedData['status'] == 'fail') {
          return NetworkResponse(
            isSuccess: false,
            statusCode: response.statusCode,
            errorMessage: decodedData['data'],
          );
        }
        return NetworkResponse(
          isSuccess: true,
          statusCode: response.statusCode,
          responseData: decodedData,
        );
      } else if (response.statusCode == 401) {
        _moveToLogin();
        return NetworkResponse(
          isSuccess: false,
          statusCode: response.statusCode,
          errorMessage: 'Unauthenticated!',
        );
      } else {
        return NetworkResponse(
          isSuccess: false,
          statusCode: response.statusCode,
        );
      }
    } catch (e) {
      return NetworkResponse(
        isSuccess: false,
        statusCode: -1,
        errorMessage: e.toString(),
      );
    }
  }

  static void printRequest(
      String url, Map<String, dynamic>? body, Map<String, dynamic>? headers) {
    debugPrint(
      'REQUEST:\nURL: $url\nBODY: $body\nHEADERS: $headers',
    );
  }

  static void printResponse(String url, Response response) {
    debugPrint(
      'URL: $url\nResponse Code: ${response.statusCode}\nBody: ${response.body}',
    );
  }

  static void _moveToLogin() async {
    await AuthController.clearUserData();
    Navigator.pushAndRemoveUntil(
      MyApp.navigatorKey.currentContext!,
      MaterialPageRoute(builder: (context) => const SignInScreen()),
      (p) => false,
    );
  }
}