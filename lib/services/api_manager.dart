// ignore_for_file: camel_case_types, non_constant_identifier_names

import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:vigenesia/Models/_auth_callback.dart';
import 'package:vigenesia/Models/_get_motivasi.dart';
import 'package:vigenesia/Models/_get_motivasi_byUser.dart';
import 'package:vigenesia/Models/_res_callback.dart';
import 'package:vigenesia/constant/const.dart';

class API_Manager {
  var client = http.Client();
  var callback;

  Future<AuthCallback> login(String email, String password) async {
    

    try {
      Map data = {'email': email, 'password': password};
      var res = await client.post(
        Const.loginEndpoint,
        headers: <String, String>{'ContentType': 'application/json'},
        body: data,
      );

      if (res.statusCode == 200) {
        var jsonString = res.body;
        var jsonMap = json.decode(jsonString);
        callback = AuthCallback.fromJson(jsonMap);
      }
    } catch (e) {
      return callback;
    }
    return callback;
  }

  Future<AuthCallback> register(String nama, String email, String password, String password_confirmation) async {
    

    try {
      Map data = {'nama':nama, 'email': email, 'password': password, 'password_confirmation': password_confirmation};
      var res = await client.post(
        Const.loginEndpoint,
        headers: <String, String>{'ContentType': 'application/json'},
        body: data,
      );

      if (res.statusCode == 200) {
        var jsonString = res.body;
        var jsonMap = json.decode(jsonString);
        callback = AuthCallback.fromJson(jsonMap);
      }
    } catch (e) {
      return callback;
    }
    return callback;
  }

  Future<GetMotivasi> getAllMotivasi(var token) async {

    try {
      var res = await client.get(
        Const.motivasiEndpoint,
        headers: <String, String>{
          'ContentType': 'application/json',
          'Authorization': 'Bearer $token'
        },
      );

      if(res.statusCode == 200) {
        var jsonString = res.body;
        var jsonMap = json.decode(jsonString);
        callback = GetMotivasi.fromJson(jsonMap);
      }
      
    } catch (e) {
      throw callback;
    }
    return callback;
  }

  Future<GetMotivasiByUser> getMotivasiUser(var token, var id) async {

    try {
      var res = await client.get(
        Const.motivasiByUser(id),
        headers: <String, String>{
          'ContentType': 'application/json',
          'Authorization': 'Bearer $token'
        },
      );

      if(res.statusCode == 200) {
        var jsonString = res.body;
        var jsonMap = json.decode(jsonString);
        callback = GetMotivasiByUser.fromJson(jsonMap);
      }
      
    } catch (e) {
      throw callback;
    }
    return callback;
  }

  Future<ResCallback> deleteMotivasi(var token, var id) async {

    
    try {
      var res = await client.delete(
        Const.motivasiByUser(id),
        headers: <String, String>{
          'ContentType': 'application/json',
          'Authorization': 'Bearer $token'
        },
      );

      if(res.statusCode == 200) {
        var jsonString = res.body;
        var jsonMap = json.decode(jsonString);
        callback = ResCallback.fromJson(jsonMap);
      }
      
    } catch (e) {
      throw callback;
    }
    return callback;
  }

  Future<http.Response> postMotivasi(var isi, var idUser) {
    client.post('url');
    return null;
  }

}
