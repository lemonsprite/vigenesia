// ignore_for_file: unused_local_variable, non_constant_identifier_names

import 'dart:convert';

import 'package:vigenesia/Models/Motivasi_Model.dart';
import 'package:vigenesia/Screens/EditPage.dart';
import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:vigenesia/services/api_manager.dart';
import 'package:vigenesia/services/shared_prefs.dart';
import 'package:vigenesia/widget/flushbar_widget.dart';
import 'Login.dart';
import 'package:another_flushbar/flushbar.dart';

class MainScreens extends StatefulWidget {
  // final int idUser;
  // final String nama;
  // final String token;
  const MainScreens({Key key}) : super(key: key);

  @override
  _MainScreensState createState() => _MainScreensState();
}

class _MainScreensState extends State<MainScreens> {
  
  

  TextEditingController isiController = TextEditingController();

  @override
  void initState() {
    super.initState();

  }

  String trigger;
  String triggeruser;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        // <-- Berfungsi Untuk  Bisa Scroll
        child: SafeArea(
          // < -- Biar Gak Keluar Area Screen HP
          child: Container(
            child: Padding(
              padding: const EdgeInsets.only(left: 30.0, right: 30.0),
              child: Column(
                  mainAxisAlignment: MainAxisAlignment
                      .center, // <-- Berfungsi untuk  atur nilai X jadi tengah
                  children: [
                    SizedBox(
                      height: 40,
                    ),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('sdas'),
                        TextButton(
                            child: Icon(Icons.logout),
                            onPressed: () {
                              Navigator.pop(context);
                              Navigator.push(
                                  context,
                                  new MaterialPageRoute(
                                      builder: (BuildContext context) =>
                                          new Login()));
                            })
                      ],
                    ),

                    SizedBox(height: 20), // <-- Kasih Jarak Tinggi : 50px
                    FormBuilderTextField(
                      controller: isiController,
                      name: "isi_motivasi",
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        contentPadding: EdgeInsets.only(left: 10),
                      ),
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width,
                      child: ElevatedButton(
                          onPressed: () {},
                          child: Text("Submit")),
                    ),

                    TextButton(
                      child: Icon(Icons.refresh),
                      onPressed: () {},
                    ),
                    FormBuilderRadioGroup(
                        // onChanged: () {},
                        name: "_",
                        options: ["Motivasi By All", "Motivasi By User"]
                            .map((e) => FormBuilderFieldOption(
                                value: e, child: Text("$e")))
                            .toList()),

                    if (trigger == "Motivasi By All") FutureBuilder(
                            future: null,
                            builder: (BuildContext context, AsyncSnapshot<List<MotivasiModel>> snapshot) {
                              if (snapshot.hasData) {
                                
                                return Container(
                                  child: Column(
                                    children: [
                                      for (var item in snapshot.data)
                                        
                                        
                                          
                                        
                                        Card(
                                          child: Column(
                                            mainAxisSize: MainAxisSize.min,
                                            children: [
                                              ListTile(
                                                leading: Icon(Icons.person),
                                                title: Text(item.isiMotivasi),
                                                subtitle: Text(''),
                                              ),
                                            ],
                                          ),
                                        ),
                                        // Container(
                                        //   width:
                                        //       MediaQuery.of(context).size.width,
                                        //   child: ListView(
                                        //     shrinkWrap: true,
                                        //     children: [
                                        //       Container(
                                        //           child:
                                        //               Text(item.isiMotivasi)),
                                        //     ],
                                        //   ),
                                        // ),
                                    ],
                                  ),
                                );
                              } else if (snapshot.hasData &&
                                  snapshot.data.isEmpty) {
                                return Text("No Data");
                              } else {
                                return CircularProgressIndicator();
                              }
                            }) else Container(),
                    trigger == "Motivasi By User"
                        ? FutureBuilder(
                            future:null,
                            builder: (BuildContext context,
                                AsyncSnapshot<List<MotivasiModel>> snapshot) {
                              if (snapshot.hasData) {
                                return Column(
                                  children: [
                                    for (var item in snapshot.data)
                                      Container(
                                        width:
                                            MediaQuery.of(context).size.width,
                                        child: ListView(
                                          shrinkWrap: true,
                                          physics: ScrollPhysics(),
                                          children: [
                                            Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Expanded(
                                                      child: Text(
                                                          item.isiMotivasi)),
                                                  Row(children: [
                                                    TextButton(
                                                      child:
                                                          Icon(Icons.settings),
                                                      onPressed: () {
                                                        String id;
                                                        String isi_motivasi;
                                                        Navigator.push(
                                                            context,
                                                            MaterialPageRoute(
                                                              builder: (BuildContext
                                                                      context) =>
                                                                  EditPage(
                                                                      id: item
                                                                          .id,
                                                                      isi_motivasi:
                                                                          item.isiMotivasi),
                                                            ));
                                                      },
                                                    ),
                                                    TextButton(
                                                      child: Icon(Icons.delete),
                                                      onPressed: () {},
                                                    )
                                                  ]),
                                                ]),
                                          ],
                                        ),
                                      ),
                                  ],
                                );
                              } else if (snapshot.hasError) {
                                return Text("${snapshot.hasError}");
                              } else {
                                return Text("No Data");
                              }
                            })
                        : Container(),
                  ]),
            ),
          ),
        ),
      ),
    );
  }
}
