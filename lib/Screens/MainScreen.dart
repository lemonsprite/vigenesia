import "package:flutter/material.dart";
import 'package:vigenesia/screens/_bottom_sheet_post.dart';
import 'package:vigenesia/services/api_manager.dart';
import 'package:vigenesia/services/shared_prefs.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({Key key}) : super(key: key);

  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: SafeArea(
        child: Scaffold(
          appBar: AppBar(
            title: Text('Kelompok 5 | 12.5B.17'),
            centerTitle: true,
          ),
          floatingActionButton: FloatingActionButton(
            onPressed: () {
              showModalBottomSheet(
                isScrollControlled: true,
                context: context,
                builder: (context) => SingleChildScrollView(
                  child: Container(
                    padding: EdgeInsets.all(8),
                    child: BottomSheetPost(),
                  ),
                ),
              );
            },
            backgroundColor: Colors.green,
            child: const Icon(Icons.add),
            tooltip: "Tambah Data Motivasi",
          ),
          body: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              children: [
                SizedBox(height: 20),
                Text(
                  'Selamat Datang, ${SharedPrefs.keyFetch("namaUser")}!',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: 30,
                ),
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
                              future: API_Manager().getAllMotivasi(
                                  SharedPrefs.keyFetch("token")),
                              builder: (context, snapshot) {
                                if (!snapshot.hasData) {
                                  return Container(
                                      child: Center(
                                          child: Text("Tidak ada data")));
                                }
                                var x = snapshot.data.data;
                                // print(data);
                                return ListView.builder(
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
                              future: API_Manager().getMotivasiUser(
                                  SharedPrefs.keyFetch("token"),
                                  SharedPrefs.keyFetch("idUser")),
                              builder: (context, snapshot) {
                                if (!snapshot.hasData) {
                                  return Container(
                                      child: Center(
                                          child: Text("Tidak ada data")));
                                }
                                var x = snapshot.data.data[0];
                                print(x.nama);
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
                                                x.motivasi[index].isiMotivasi),
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
                // ElevatedButton(
                //     onPressed: () async {
                //       // await SharedPrefs.clearKey();
                //       // Navigator.pushReplacement(
                //       //     context,
                //       //     new MaterialPageRoute(
                //       //         builder: (BuildContext context) =>
                //       //             new Login()));
                //       var data = API_Manager().getMotivasiUser(
                //           SharedPrefs.keyFetch("token"),
                //           SharedPrefs.keyFetch("idUser"));
                //       print(data);
                //     },
                //     child: Text('Clear'))
              ],
            ),
          ),
        ),
      ),
    );
  }
}
