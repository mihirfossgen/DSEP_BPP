import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'package:dsep_bpp/models/scheme_provider_list_model.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

import '../utils/api.dart';

class ApiServices {
  static var timeoutrespon = {"status": false, "message": "timeout"};
  static var successResp = {'status': true, "message": "response fetched"};
  static var falseResp = {"status": false, "message": "failed to get response"};
  static String authroziation =
      "Bearer eyJhbGciOiJIUzI1NiJ9.eyJzdWIiOiJkc2VwX2JwcF90ZXN0XzAwMTAiLCJzY29wZXMiOiJST0xFX0FETUlOIiwiaWF0IjoxNjY2MTUyNzA2LCJleHAiOjE2NjYxNzA3MDZ9.uLrjWvQOlE8BlsCSJxs4plONmoPQEXskF01H6fv_G1I";
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

  Future createScheme(data) {
    return postData(Uri.parse(Api.createScheme), data);
  }

  Future updateScheme(data, schemeId) {
    String url =
        "https://proteanrc.centralindia.cloudapp.azure.com/dsep-bpp-1/api/scheme/update/$schemeId";
    return postData(Uri.parse(url), data);
  }

  Future listSchemeProviderList() async {
    try {
      Map<String, String> userheader = {
        "Content-Type": "application/json",
        "Authorization": authroziation
      };
      var resp = await http.get(Uri.parse(Api.listAllProviderScheme),
          headers: userheader);
      print(resp.statusCode);
      print(resp.body.toString());
      if (resp.statusCode == 200) {
        return resp.body;
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

  static Future<dynamic> postData(url, body) async {
    if (kDebugMode) print(url);
    if (kDebugMode) print(body);
    Map<String, String> userheader = {
      "Content-Type": "application/json",
      "Authorization": authroziation
    };
    try {
      var resp =
          await http.post(url, body: json.encode(body), headers: userheader);
      if (kDebugMode) print(resp.body);

      if (resp.statusCode == 201) {
        return json.decode(resp.body);
      } else if (resp.statusCode == 200) {
        if (resp.body.toString() == "true") {
          return successResp;
        } else {
          return json.decode(resp.body);
        }
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
