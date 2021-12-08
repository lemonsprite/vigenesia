// ignore_for_file: camel_case_types

import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/material.dart';

class Widget_Manager {
  Flushbar<dynamic> flushbarInit(String pesan, Duration durasi, Color background, FlushbarPosition posisi) {
    return Flushbar(
      message: pesan,
      duration: durasi,
      backgroundColor: background,
      flushbarPosition: posisi,
    );
  }
}
