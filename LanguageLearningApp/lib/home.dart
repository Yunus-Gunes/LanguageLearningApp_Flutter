import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:languagelearningapp/globals.dart' as globals;

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  //static var lessonId = _HomeState.lessonId;

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  void initState() {
    super.initState();
    take_Languges();
  }

  List<String> languagess = [];
  List<String> languagessID = [];

  //static var lessonId = "";

  void take_Languges() async {
    var response = await Dio()
        .request("http://157.245.18.250:8000/api/services/app/Language/GetAll",
            data: {},
            options: Options(headers: {
              HttpHeaders.contentTypeHeader: "application/json",
              //HttpHeaders.authorizationHeader: "Bearer $token",
              "Authorization": "Bearer ${globals.token}",
              "Accept": "*/*",
              "Connection": "keep-alive",
              "Acccept-Encoding": "gzip, deflate, br",
            }, method: "get"));

    //print(response);
    //print(response.data["result"]["items"]);
    for (var i in response.data["result"]["items"]) {
      //print(i["name"]);
      languagess.add(i["name"]);
      languagessID.add(i["id"].toString());
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.blueAccent,
          title: const Text('Language Learning'),
          centerTitle: true,
        ),
        drawer: Drawer(
          child: ListView(padding: EdgeInsets.zero, children: [
            const DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.blue,
              ),
              child: Text('Home'),
            ),
            ListTile(
              title: const Text('Profile'),
              onTap: () {
                Navigator.pushNamed(context, '/profile');
              },
            ),
            ListTile(
              title: const Text('Log Out'),
              onTap: () {
                Navigator.pushNamed(context, '/login');
              },
            ),
            ListTile(
              title: Text("Kullanıcı ID: ${globals.userIdd}"),
            ),
          ]),
        ),
        body: Column(children: <Widget>[
          const Expanded(
            flex: 1,
            child: SizedBox(
              height: 1.0,
            ),
          ),
          Expanded(
            flex: 100,
            child: languagess.length == 0
                ? const Center(child: CircularProgressIndicator())
                : ListView.builder(
                    itemCount: languagess.length,
                    itemBuilder: (context, index) {
                      return ElevatedButton(
                        onPressed: () {
                          globals.languageId = languagessID[index];

                          globals.languageName = languagess[index];
                          Navigator.pushNamed(context, '/language');
                        },
                        style: ButtonStyle(
                          backgroundColor:
                              MaterialStateProperty.all(Colors.white),
                        ),
                        child: Card(
                          child: Row(
                            //mainAxisAlignment: MainAxisAlignment.start,
                            children: <Widget>[
                              const Padding(
                                padding: EdgeInsets.all(
                                    5), //apply padding to all four sides
                              ),
                              Image.asset("/Languages/${languagess[index]}.png"),
                              const Padding(
                                padding: EdgeInsets.all(
                                    5), //apply padding to all four sides
                              ),
                              Text(
                                languagess[index],
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 42),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
          ),
          const Expanded(
            flex: 1,
            child: SizedBox(
              height: 1.0,
            ),
          ),
        ]));
  }
}
