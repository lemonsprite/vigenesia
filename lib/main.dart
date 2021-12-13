import 'package:flutter/material.dart';
import 'package:vigenesia/screens/Login.dart';
import 'package:vigenesia/screens/MainScreen.dart';
import 'package:vigenesia/services/shared_prefs.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await SharedPrefs.init();
  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      home: (SharedPrefs.containKey("token")) ? MainScreen() : Login(),
    ),
  );
}
