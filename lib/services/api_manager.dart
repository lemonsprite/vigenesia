// ignore_for_file: camel_case_types, non_constant_identifier_names, missing_return

import 'dart:convert';

import 'package:dio/dio.dart';
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
        headers: {
          'Accept': 'application/json',
          'ContentType': 'application/json'
        },
        body: data,
      );

      if (res.statusCode == 201) {
        var jsonString = res.body;
        var jsonMap = json.decode(jsonString);
        callback = AuthCallback.fromJson(jsonMap);
        return callback;
      }
    } catch (e) {
      return callback;
    }
  }

  Future<AuthCallback> register(String nama, String email, String password, String password_confirmation) async {
    try {
      Map data = {
        'nama': nama,
        'email': email,
        'password': password,
        'password_confirmation': password_confirmation
      };
      var res = await client.post(
        Const.registerEndpoint,
        headers: <String, String>{'Accept': 'application/json'},
        body: data,
      );

      if (res.statusCode == 200) {
        var jsonString = res.body;
        var jsonMap = json.decode(jsonString);
        callback = AuthCallback.fromJson(jsonMap);
        return callback;
      }
    } catch (e) {
      return callback;
    }
  }

  Future<GetMotivasi> getAllMotivasi(var token) async {
    var res = await client.get(
      Const.motivasiEndpoint,
      headers: <String, String>{
        'ContentType': 'application/json',
        'Authorization': 'Bearer $token'
      },
    );

    var jsonString = res.body;
    // print(res.body);
    var jsonMap = json.decode(jsonString);
    // print(jsonMap);
    callback = GetMotivasi.fromJson(jsonMap);
    // print(callback.data[1].isiMotivasi);
    return callback;
  }

  Future<GetMotivasiByUser> getMotivasiUser(var token, var id) async {
    var res = await client.get(
      Const.motivasiByUser(id),
      headers: <String, String>{
        'ContentType': 'application/json',
        'Authorization': 'Bearer $token'
      },
    );

    var jsonString = res.body;
    var jsonMap = json.decode(jsonString);
    callback = GetMotivasiByUser.fromJson(jsonMap);
    // print(callback.data[0].motivasi[1].isiMotivasi);
    return callback;
  }

  Future<ResCallback> deleteMotivasi(var token, var id) async {
    try {
      var res = await client.delete(
        Const.motivasiID(id),
        headers: <String, String>{
          'ContentType': 'application/json',
          'Authorization': 'Bearer $token'
        },
      );

      if (res.statusCode == 200) {
        var jsonString = res.body;
        var jsonMap = json.decode(jsonString);
        callback = ResCallback.fromJson(jsonMap);
        return callback;
      }
    } catch (e) {
      throw callback;
    }
  }

  Future<http.Response> postMotivasi(var isi, var idUser, var token) async {
    Map data = {'isi_motivasi': isi, 'id_user': idUser};
    try {
      var res = await client.post(
        Const.motivasiEndpoint,
        headers: {
          'Accept': 'application/json',
          'Authorization': 'Bearer $token',
          'Content-Type': Headers.formUrlEncodedContentType,
        },
        body: data,
      );

      if (res.body != null) {
        var jsonString = res.body;
        var jsonMap = json.decode(jsonString);
        callback = ResCallback.fromJson(jsonMap);
        return callback;
      }
    } catch (e) {
      return null;
    }
  }

  Future<http.Response> putMotivasi(var token, var id, var isi) async {
    Map data = {'isi_motivasi': isi};
    try {
      var res = await client.put(
        Const.motivasiID(id),
        headers: <String, String>{
          'ContentType': Headers.formUrlEncodedContentType,
          'Authorization': 'Bearer $token',
        },
        body: data,
      );

      if (res.statusCode == 200) {
        var jsonString = res.body;
        var jsonMap = json.decode(jsonString);
        callback = ResCallback.fromJson(jsonMap);
        return callback;
      }
    } catch (e) {
      throw callback;
    }
  }
  Future<http.Response> logout(token) async {
    var res = await client.put(
        Const.logoutEndpoint,
        headers: <String, String>{
          'ContentType': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );

    return res;
  }
}
