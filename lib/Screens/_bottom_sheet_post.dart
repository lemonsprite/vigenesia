import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

class BottomSheetPost extends StatefulWidget {
  const BottomSheetPost({Key key}) : super(key: key);

  @override
  _BottomSheetPostState createState() => _BottomSheetPostState();
}

class _BottomSheetPostState extends State<BottomSheetPost> {
  TextEditingController motivasiController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Container(
      child: FormBuilderTextField(
        name: "isi_motivasi",
        controller: motivasiController,
        decoration: InputDecoration(
          contentPadding: EdgeInsets.only(left: 10),
          border: OutlineInputBorder(),
        ),
      ),
    );
  }
}
