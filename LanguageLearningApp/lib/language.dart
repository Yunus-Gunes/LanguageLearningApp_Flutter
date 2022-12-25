import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
//import 'package:languagelearningapp/home.dart';
//import 'package:languagelearningapp/login.dart';
//import 'home.dart';
import 'package:languagelearningapp/globals.dart' as globals;
import 'package:languagelearningapp/lesson.dart';

String lesname = '';

class Language extends StatefulWidget {
  const Language({Key? key}) : super(key: key);

  @override
  State<Language> createState() => _LanguageState();
}

class _LanguageState extends State<Language> {
  @override
  void initState() {
    super.initState();
    take_Lesson();
  }

  List<String> lessons = [];
  List<String> lessonsID = [];
  List<bool> lessonspass = [];

  void take_Lesson() async {
    var response = await Dio().request(
        "http://157.245.18.250:8000/api/services/app/Lesson/GetAllLessonsByUserAndByLanguageWithPassAttribute?"
        "LanguageId=${globals.languageId}",
        //data: {globals.languageId},
        options: Options(headers: {
          HttpHeaders.contentTypeHeader: "application/json",
          //HttpHeaders.authorizationHeader: "Bearer $token",
          "Authorization": "Bearer ${globals.token}",
          "Accept": "*/*",
          "Connection": "keep-alive",
          "Acccept-Encoding": "gzip, deflate, br",
        }, method: "get"));

    print(response);
    //print(response.data["result"]["items"]);
    for (var i in response.data["result"]) {
      //print(i["name"]);
      lessons.add(i["lessonName"]);
      lessonsID.add(i["lessonId"].toString());
      lessonspass.add(i["isPass"]);
    }
    setState(() {});
  }

  take_Lesson_Color(bool status) {
  if(status){
    return Colors.green;
  }else{
    return Colors.red;
  }
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
              child: Text('Language Name'),
            ),
            ListTile(
              title: const Text('Languages'),
              onTap: () {
                Navigator.pushNamed(context, '/home');
              },
            ),
            ListTile(
              title: const Text('Log Out'),
              onTap: () {
                Navigator.pushNamed(context, '/login');
              },
            ),
          ]),
        ),
        body: SafeArea(
              child: SingleChildScrollView(
                  child: Column(
            //crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    SizedBox(height: 40, child: Container()),
                    const Divider(),
                    Text(
                      "Language Name : ${globals.languageName}",
                      style:
                      const TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
                    ),
                    SizedBox(height: 40, child: Container()),
                    const Text(
                      "Lesson Progress",
                      style: TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 25),
                    ),

                              const Divider(),
                              ListView.builder(
                                physics: const NeverScrollableScrollPhysics(),
                                shrinkWrap: true,
                                itemCount: lessons.length,
                                itemBuilder: (context, index) {
                                  return Column(
                                    children: [
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: <Widget> [
                                           SizedBox(
                                               height: 100,
                                                width: 500,

                                              child: ElevatedButton(
                                              onPressed: () {
                                              setState(() {
                                                globals.lessonId = lessonsID[index];
                                                LessonName = lessons[index];
                                              });
                                              Navigator.pushNamed(context, '/lesson');
                                              },
                                              style: ElevatedButton.styleFrom(
                                                backgroundColor: take_Lesson_Color(lessonspass[index]),

                                                textStyle:
                                                const TextStyle(fontSize: 40, fontWeight: FontWeight.bold)),
                                                child: Text("Take ${lessons[index]}"),
                                          )

                                            )

                                        ],
                                      ),
                                      SizedBox(height: 10, child: Container()),
                                    ],
                                  );

                                },

                              ),
                  ]
    ),
    ),
        ));
  }
}
