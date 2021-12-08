// ignore_for_file: camel_case_types

import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:vigenesia/constant/const.dart';
import 'package:vigenesia/models/_login_model.dart';

class API_Manager {

  

  Future<LoginModel> login(String email, String password) async {
    var client = http.Client();
    var loginModel;

    try {
      Map data = {
        'email': email,
        'password': password
      };
      var response = await client.post(
        Const.loginEndpoint,
        headers: <String, String>{'ContentType': 'application/json'},
        body: data,
      );
      
      if (response.statusCode == 200) {
        var jsonString = response.body;
        var jsonMap = json.decode(jsonString);
        loginModel = LoginModel.fromJson(jsonMap);
      }
    } catch (e) {
      return loginModel;
    }
    return loginModel;
  }
}
