// ignore_for_file: must_be_immutable

import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:vigenesia/services/api_manager.dart';
import 'package:vigenesia/services/shared_prefs.dart';
import 'package:vigenesia/widget/flushbar_widget.dart';

class BottomSheetEdit extends StatefulWidget {
  var isiMotivasi;
  var idMotivasi;
  BottomSheetEdit({Key key, this.isiMotivasi, this.idMotivasi})
      : super(key: key);

  @override
  _BottomSheetEditState createState() => _BottomSheetEditState();
}

class _BottomSheetEditState extends State<BottomSheetEdit> {
  @override
  Widget build(BuildContext context) {
    TextEditingController motivasiController = TextEditingController();

    var screen = MediaQuery.of(context);

    return Container(
      padding: EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20), topRight: Radius.circular(20)),
      ),
      child: Padding(
        padding: EdgeInsets.only(bottom: screen.viewInsets.bottom),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              widget.isiMotivasi,
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 30),
            FormBuilderTextField(
              name: "isi_motivasi",
              controller: motivasiController,
              decoration: InputDecoration(
                contentPadding: EdgeInsets.only(left: 10),
                border: OutlineInputBorder(),
                hintText: "Parameter Baru",
              ),
            ),
            SizedBox(height: 30),
            ElevatedButton(
              onPressed: () async {
                var data = motivasiController.text.toString();
                
                Navigator.pop(context);
                await API_Manager().putMotivasi(SharedPrefs.keyFetch("token"),
                    widget.idMotivasi, (data == "") ? widget.isiMotivasi : data).then((value) => {
                      Navigator.pop(context),
                      Widget_Manager().flushbarInit(
                                  "Data Berhasil Disimpan",
                                  Duration(seconds: 4),
                                  Colors.greenAccent,
                                  FlushbarPosition.TOP).show(context)

                    });
              },
              child: Text("Simpan"),
            ),
          ],
        ),
      ),
    );
  }
}
