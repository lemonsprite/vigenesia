import "package:flutter/material.dart";
import 'package:vigenesia/Screens/Login.dart';
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
          body: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              children: [
                Text(SharedPrefs.keyFetch("namaUser")),
                SizedBox(
                  height: 10,
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
                              future: API_Manager().getAllMotivasi(SharedPrefs.keyFetch("token")),
                              builder: (context, snapshot) {
                                if(snapshot.hasData == null) {
                                  return Container();
                                }
                                List data = snapshot.data;
                                print(data);
                                return ListView.builder(
                                  itemCount: snapshot.data,
                                  itemBuilder: (context, index) {
                                   return Text("Builder"); 
                                  });
                              },
                            ),
                          ),
                          Text("Motivasi User"),
                        ],
                      ),
                    ),
                  ),
                ),
                ElevatedButton(
                    onPressed: () async {
                      // await SharedPrefs.clearKey();
                      // Navigator.pushReplacement(
                      //     context,
                      //     new MaterialPageRoute(
                      //         builder: (BuildContext context) =>
                      //             new Login()));
                      var data = API_Manager().getAllMotivasi(SharedPrefs.keyFetch("token"));
                      print(data);
                    },
                    child: Text('Clear'))
              ],
            ),
          ),
        ),
      ),
    );
  }
}
