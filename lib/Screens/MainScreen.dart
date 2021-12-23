import 'package:another_flushbar/flushbar.dart';
import "package:flutter/material.dart";
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:vigenesia/Screens/Login.dart';
import 'package:vigenesia/screens/_bottom_sheet_edit.dart';
import 'package:vigenesia/services/api_manager.dart';
import 'package:vigenesia/services/shared_prefs.dart';
import 'package:vigenesia/widget/flushbar_widget.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({Key key}) : super(key: key);

  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  Future motivasiAllUser;
  Future motivasiUser;

  _updateData() {
    motivasiAllUser = _getMotivasiAllUser();
    motivasiUser = _getMotivasiUser();
  }

  @override
  void initState() {
    super.initState();
    _updateData();
  }

  _getMotivasiUser() async {
    return await API_Manager().getMotivasiUser(
        SharedPrefs.keyFetch("token"), SharedPrefs.keyFetch("idUser"));
  }

  _getMotivasiAllUser() async {
    return await API_Manager().getAllMotivasi(SharedPrefs.keyFetch("token"));
  }

  @override
  Widget build(BuildContext context) {
    TextEditingController motivasiController = TextEditingController();

    return DefaultTabController(
      length: 2,
      child: SafeArea(
        child: Scaffold(
          resizeToAvoidBottomInset: false,
          
          appBar: AppBar(
            title: Text('Kelompok 5 | 12.5B.17'),
            centerTitle: true,
            actions: [
              IconButton(onPressed: () {
                setState(() {
                  _updateData();
                });
                Widget_Manager().flushbarInit("Data berhasil direfresh.", Duration(seconds: 3), Colors.greenAccent, FlushbarPosition.TOP).show(context);
              }, icon: Icon(Icons.refresh))
            ],
          ),
          floatingActionButton: FloatingActionButton(
              backgroundColor: Colors.redAccent,
              onPressed: () {
                API_Manager()
                    .logout(SharedPrefs.keyFetch("token"))
                    .then((value) => {
                          Widget_Manager()
                              .flushbarInit(
                                  "Anda berhasil Logout",
                                  Duration(seconds: 3),
                                  Colors.greenAccent,
                                  FlushbarPosition.TOP)
                              .show(context),
                          SharedPrefs.clearKey(),
                          Navigator.pushReplacement(
                            context,
                            new MaterialPageRoute(
                              builder: (BuildContext context) => new Login(),
                            ),
                          ),
                          Widget_Manager()
                              .flushbarInit(
                                  "Anda berhasil Logout",
                                  Duration(seconds: 3),
                                  Colors.greenAccent,
                                  FlushbarPosition.TOP)
                              .show(context)
                        });
              },
              child: Icon(Icons.logout)),
          body: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              children: [
                SizedBox(height: 10),
                Text(
                  'Selamat Datang, ${SharedPrefs.keyFetch("namaUser")}!',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  "Tambah Motivasi",
                  style: TextStyle(fontSize: 18),
                ),
                SizedBox(height: 10),
                FormBuilderTextField(
                  name: "isi_motivasi",
                  controller: motivasiController,
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.only(left: 10),
                    border: OutlineInputBorder(),
                    hintText: "Isi Motivasi",
                  ),
                ),
                SizedBox(height: 10),
                ElevatedButton(
                  onPressed: () {
                    if (motivasiController.text == "" ||
                        motivasiController.text == null) {
                      Widget_Manager()
                          .flushbarInit(
                              "Data tidak boleh kosong!",
                              Duration(seconds: 4),
                              Colors.redAccent,
                              FlushbarPosition.TOP)
                          .show(context);
                    } else {
                      API_Manager()
                          .postMotivasi(
                              motivasiController.text.toString(),
                              SharedPrefs.keyFetch("idUser"),
                              SharedPrefs.keyFetch("token"))
                          .then((val) => {
                                setState(() {
                                  _updateData();
                                }),
                                Widget_Manager()
                                    .flushbarInit(
                                        "Data Berhasil Disimpan",
                                        Duration(seconds: 4),
                                        Colors.greenAccent,
                                        FlushbarPosition.TOP)
                                    .show(context)
                              });
                    }
                  },
                  child: Text("Simpan"),
                ),
                SizedBox(height: 20),
                Container(
                  height: 40,
                  decoration: BoxDecoration(
                    color: Colors.blue,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(5),
                    child: TabBar(
                      indicator: BoxDecoration(
                        color: Colors.lightBlue,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      tabs: [
                        Text('Semua Motivasi'),
                        Text('Motivasi User'),
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TabBarView(
                        children: [
                          Container(
                            child: FutureBuilder(
                              future: motivasiAllUser,
                              builder: (context, snapshot) {
                                if (!snapshot.hasData) {
                                  return Container(
                                      child: Center(
                                          child: Text("Tidak ada data")));
                                }
                                var x = snapshot.data.data;
                                return ListView.builder(
                                  // reverse: true,

                                  itemCount: x.length,
                                  itemBuilder: (context, index) {
                                    return Card(
                                      child: Column(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          ListTile(
                                            leading: CircleAvatar(
                                                child: Icon(Icons.person)),
                                            title: Text(
                                              x[index].isiMotivasi,
                                              style: TextStyle(fontSize: 14),
                                            ),
                                            subtitle: Text(
                                              x[index].user.nama,
                                              style: TextStyle(
                                                fontSize: 12,
                                                fontWeight: FontWeight.bold,
                                                color: Colors.grey,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    );
                                  },
                                );
                              },
                            ),
                          ),
                          Container(
                            child: FutureBuilder(
                              future: motivasiUser,
                              builder: (context, snapshot) {
                                if (!snapshot.hasData) {
                                  return Container(
                                      child: Center(
                                          child: Text("Tidak ada data")));
                                }
                                var x = snapshot.data.data[0];

                                return ListView.builder(
                                  itemCount: x.motivasi.length,
                                  itemBuilder: (context, index) {
                                    var id = index + 1;
                                    return Card(
                                      child: Column(
                                        mainAxisSize: MainAxisSize.min,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          ListTile(
                                            leading: CircleAvatar(
                                              child: Text(id.toString()),
                                            ),
                                            title: Text(
                                              x.motivasi[index].isiMotivasi,
                                              style: TextStyle(fontSize: 14),
                                            ),
                                            trailing: Wrap(
                                              children: [
                                                IconButton(
                                                  padding: EdgeInsets.all(4),
                                                  icon: Icon(Icons.edit),
                                                  onPressed: () async {
                                                    var res = await showModalBottomSheet(
                                                        context: context,
                                                        builder: (context) {
                                                          return BottomSheetEdit(
                                                              isiMotivasi: x
                                                                  .motivasi[
                                                                      index]
                                                                  .isiMotivasi,
                                                              idMotivasi: x
                                                                  .motivasi[
                                                                      index]
                                                                  .id);
                                                        });
                                                        if(res != null)
                                                        {
                                                          setState(() {
                                                            _updateData();
                                                          });
                                                        }
                                                  },
                                                ),
                                                IconButton(
                                                  padding: EdgeInsets.all(4),
                                                  icon: Icon(
                                                    Icons.delete,
                                                    color: Colors.redAccent,
                                                  ),
                                                  onPressed: () async {
                                                    await API_Manager()
                                                        .deleteMotivasi(
                                                            SharedPrefs
                                                                .keyFetch(
                                                                    "token"),
                                                            x.motivasi[index]
                                                                .id)
                                                        .then((value) => {
                                                              setState(() {
                                                                _updateData();
                                                              }),
                                                              Widget_Manager()
                                                                  .flushbarInit(
                                                                      "Data Berhasil Dihapus!",
                                                                      Duration(
                                                                          seconds:
                                                                              4),
                                                                      Colors
                                                                          .redAccent,
                                                                      FlushbarPosition
                                                                          .TOP)
                                                                  .show(context)
                                                            });
                                                  },
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    );
                                  },
                                );
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
