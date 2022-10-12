import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

import '../utils/api.dart';

class ApiServices {
  static var timeoutrespon = {"status": false, "message": "timeout"};
  static var successResp = {'status': true, "message": "response fetched"};
  static var falseResp = {"status": false, "message": "failed to get response"};
  Future loginUserVerifyApi(data) async {
    try {
      // Api for Login username or Password Verification
      var data1 = json.encode(data);
      Map<String, String> headers1 = {
        "Content-Type": "application/json",
      };
      var response = await http.post(Uri.parse(Api.fetchScheme),
          body: data1, headers: headers1);
      return response.body.toString();
    } catch (e) {
      return e.toString();
    }
  }

  Future signUpUser(data) {
    return postData(Uri.parse(Api.signUp), data);
  }

  static Future<dynamic> postData(url, body) async {
    if (kDebugMode) print(url);
    if (kDebugMode) print(body);
    try {
      var resp = await http.post(url, body: body);
      if (kDebugMode) print(resp.body);

      if (resp.statusCode == 200) {
        return successResp;
      } else if (resp.statusCode == 415) {
        return falseResp;
      } else if (resp.statusCode == 500) {
        return falseResp;
      } else {
        return falseResp;
      }
    } on TimeoutException catch (e) {
      if (kDebugMode) print(e);
      return timeoutrespon;
    } catch (e) {
      if (kDebugMode) print("error ---- $e");
    }
  }
}
