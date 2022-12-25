import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:languagelearningapp/globals.dart' as globals;

class Profile extends StatefulWidget {
  const Profile({Key? key}) : super(key: key);

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  @override
  void initState() {
    super.initState();
    take_Person();
  }

  String name = "";
  String surName = "";
  String emailAddress = "";
  String roleName = "";
  void take_Person() async {
    var response = await Dio().request(
        "http://157.245.18.250:8000/api/services/app/User/Get?Id=${int.parse(globals.userIdd)}",
        data: {int.parse(globals.userIdd)},
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
    name = response.data["result"]["name"];
    surName = response.data["result"]["surname"];
    emailAddress = response.data["result"]["emailAddress"];
    roleName = response.data["result"]["roleName"];

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
      body: Column(
        children: <Widget>[
          SizedBox(height: 40, child: Container()),
          SizedBox(
              width: 600,
              height: 400,
              child: Column(
                children: <Widget>[
                  Row(
                    children: const <Widget>[
                      Icon(Icons.person),
                      Text(
                        "Profile",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 25),
                      ),
                    ],
                  ),
                  Text(
                    "Name : $name",
                    style: const TextStyle(
                        fontWeight: FontWeight.bold, fontSize: 25),
                  ),
                  SizedBox(height: 10, child: Container()),
                  Text(
                    "Surname : $surName",
                    style: const TextStyle(
                        fontWeight: FontWeight.bold, fontSize: 25),
                  ),
                  SizedBox(height: 10, child: Container()),
                  Text(
                    "Email Address : $emailAddress",
                    style: const TextStyle(
                        fontWeight: FontWeight.bold, fontSize: 25),
                  ),
                  SizedBox(height: 10, child: Container()),
                  Text(
                    "Role Name : $roleName",
                    style: const TextStyle(
                        fontWeight: FontWeight.bold, fontSize: 25),
                  ),
                  SizedBox(height: 10, child: Container()),
                  const Text(
                    'My Comments',
                    style: TextStyle(
                        fontWeight: FontWeight.bold, fontSize: 25),
                  ),

                  const Text('My Comments'),

                ],
              )),
        ],
      ),
    );
  }
}
