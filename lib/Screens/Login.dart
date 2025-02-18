// ignore_for_file: missing_return

import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter/gestures.dart';

// Import class
import 'package:vigenesia/screens/MainScreen.dart';
import 'package:vigenesia/services/api_manager.dart';
import 'package:vigenesia/services/shared_prefs.dart';
import 'package:vigenesia/Screens/Register.dart';
import 'package:vigenesia/widget/flushbar_widget.dart';

class Login extends StatefulWidget {
  const Login({Key key}) : super(key: key);

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  String nama;
  int idUser;

  final GlobalKey<FormBuilderState> _fbKey = GlobalKey<FormBuilderState>();

  // Future<LoginModel> postLogin(String email, String password) async {
  //   var dio = Dio();
  //   String baseurl = url;

  //   Map<String, dynamic> data = {"email": email, "password": password};

  //   try {
  //     final response = await dio.post("$baseurl/api/login/",
  //         data: data,
  //         options: Options(headers: {'Content-type': 'application/json'}));
  //     print("Respon -> ${response.data} + ${response.statusCode}");
  //     if (response.statusCode == 200) {
  //       final loginModel = LoginModel.fromJson(response.data);
  //       return loginModel;
  //     }
  //   } catch (e) {
  //     print("Failed To Load $e");
  //   }
  // }

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  // bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        // <-- Berfungsi Untuk  Bisa Scroll
        child: SafeArea(
          // < -- Biar Gak Keluar Area Screen HP
          child: Container(
            height: MediaQuery.of(context).size.height,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Login Area",
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.w500),
                ),
                SizedBox(height: 50), // <-- Kasih Jarak Tinggi : 50px
                Center(
                  child: Form(
                    key: _fbKey,
                    child: Container(
                      width: MediaQuery.of(context).size.width / 1.3,
                      child: Column(
                        children: [
                          FormBuilderTextField(
                            name: "email",
                            controller: emailController,
                            decoration: InputDecoration(
                                contentPadding: EdgeInsets.only(left: 10),
                                border: OutlineInputBorder(),
                                labelText: "Email"),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          FormBuilderTextField(
                            obscureText:
                                true, // <-- Buat bikin setiap inputan jadi bintang " * "
                            name: "password",
                            controller: passwordController,

                            decoration: InputDecoration(
                                contentPadding: EdgeInsets.only(left: 10),
                                border: OutlineInputBorder(),
                                labelText: "Password"),
                          ),
                          SizedBox(
                            height: 30,
                          ),
                          Text.rich(
                            TextSpan(
                              children: [
                                TextSpan(
                                  text: 'Dont Have Account ? ',
                                  style: TextStyle(color: Colors.black54),
                                ),
                                TextSpan(
                                    text: 'Sign Up',
                                    recognizer: TapGestureRecognizer()
                                      ..onTap = () {
                                        Navigator.push(
                                            context,
                                            new MaterialPageRoute(
                                                builder:
                                                    (BuildContext context) =>
                                                        new Register()));
                                      },
                                    style: TextStyle(
                                      fontWeight: FontWeight.w600,
                                      color: Colors.blueAccent,
                                    )),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 40,
                          ),
                          Container(
                            width: MediaQuery.of(context).size.width,
                            child: ElevatedButton(
                                onPressed: () {
                                  API_Manager()
                                      .login(emailController.text,
                                          passwordController.text)
                                      .then((value) => {
                                            if (value != null)
                                              {
                                                setState(() {
                                                  SharedPrefs.keyInitString(
                                                      'token', value.token);
                                                  SharedPrefs.keyInitString(
                                                      'idUser',
                                                      value.user.id.toString());
                                                  SharedPrefs.keyInitString(
                                                      'namaUser',
                                                      value.user.nama);
                                                  SharedPrefs.keyInitString(
                                                      'email',
                                                      value.user.email);
                                                  // var token =
                                                  //     SharedPrefs.keyFetch(
                                                  //         'token');

                                                  // print(
                                                  //     "Ini Data Id ---> $token");
                                                  Navigator.pushReplacement(
                                                    context,
                                                    new MaterialPageRoute(
                                                      builder: (BuildContext
                                                              context) =>
                                                          new MainScreen(),
                                                    ),
                                                  );
                                                  Widget_Manager()
                                                      .flushbarInit(
                                                          "Berhasil Login!",
                                                          Duration(seconds: 3),
                                                          Colors.greenAccent,
                                                          FlushbarPosition.TOP)
                                                      .show(context);
                                                })
                                              }
                                            else if (value == null)
                                              {
                                                Flushbar(
                                                  message:
                                                      "Check Your Email / Password",
                                                  duration:
                                                      Duration(seconds: 5),
                                                  backgroundColor:
                                                      Colors.redAccent,
                                                  flushbarPosition:
                                                      FlushbarPosition.TOP,
                                                ).show(context)
                                              }
                                          });
                                },
                                child: Text("Sign In")),
                          ),
                        ],
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
