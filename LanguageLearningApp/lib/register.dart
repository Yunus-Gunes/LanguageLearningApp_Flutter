import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class Register extends StatefulWidget {
  const Register({Key? key}) : super(key: key);

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  void metot(
      String methodName, String url, Map<String, Object> requestBody) async {
    try {
      var response = await Dio().request(url,
          data: requestBody,
          options: Options(headers: {
            HttpHeaders.contentTypeHeader: "application/json",
          }, method: methodName));

      if (response.statusCode == 200) {
        //print(response);

        //Logine götürüyor
        Navigator.pushNamed(context, '/login');
      } else {
        // kullnıcaya hata mesajı göster
      }
    } catch (e) {
      print(e);
      _showDialog2();
    }
  }

  void _showDialog() {
    // flutter defined function
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
          title: const Text("Try again"),
          content: const Text("Passwords are not the same"),
          actions: <Widget>[
            // usually buttons at the bottom of the dialog
            ElevatedButton(
              child: const Text("Close"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
  void _showDialog2() {
    // flutter defined function
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
          title: const Text("Try again"),
          content: const Text("This information is not valid."),
          actions: <Widget>[
            // usually buttons at the bottom of the dialog
            ElevatedButton(
              child: const Text("Close"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
  void _showDialog3() {
    // flutter defined function
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
          title: const Text("Error"),
          content: const Text("Please fill out all filed."),
          actions: <Widget>[
            // usually buttons at the bottom of the dialog
            ElevatedButton(
              child: const Text("Close"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  String nameReg = "";
  String surnameReg = "";
  String passwordReg = "";
  String REpasswordReg = "";
  String email = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.blueAccent,
        title: const Text('Register'),
        centerTitle: true,
      ),
      body: Column(
        children: <Widget>[
          SizedBox(height: 40, child: Container()),
          Stack(
            children: <Widget>[
              // Stroked text as border.
              Text(
                "Register Form",
                style: TextStyle(
                  fontSize: 60,
                  foreground: Paint()
                    ..style = PaintingStyle.stroke
                    ..strokeWidth = 6
                    ..color = Colors.blue[700]!,
                ),
              ),
              // Solid text as fill.
              Text(
                "Register Form",
                style: TextStyle(
                  fontSize: 60,
                  color: Colors.grey[300],
                ),
              ),
            ],
          ),
          SizedBox(height: 40, child: Container()),
          SizedBox(
            width: 400,
            height: 310,
            child: Column(
              children: <Widget>[
                TextField(
                  onChanged: (text) {
                    nameReg = text;
                  },
                  cursorColor: Colors.grey,
                  decoration: InputDecoration(
                    icon: const Icon(Icons.perm_identity_sharp), ////
                    fillColor: Colors.grey[100],
                    filled: true,
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide.none),
                    hintText: 'Name',
                    hintStyle:
                        const TextStyle(color: Colors.grey, fontSize: 18),
                  ),
                ),
                SizedBox(height: 10, child: Container()),
                TextField(
                  onChanged: (text) {
                    surnameReg = text;
                  },
                  cursorColor: Colors.grey,
                  decoration: InputDecoration(
                    icon: const Icon(Icons.drive_file_rename_outline_sharp),
                    fillColor: Colors.grey[100],
                    filled: true,
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide.none),
                    hintText: 'Surname',
                    hintStyle:
                        const TextStyle(color: Colors.grey, fontSize: 18),
                  ),
                ),
                SizedBox(height: 10, child: Container()),
                TextField(
                  onChanged: (text) {
                    passwordReg = text;
                  },
                  obscureText: true,
                  enableSuggestions: false,
                  autocorrect: false,
                  cursorColor: Colors.grey,
                  decoration: InputDecoration(
                    icon: const Icon(Icons.password_sharp), ////
                    fillColor: Colors.grey[100],
                    filled: true,
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide.none),
                    hintText: 'Password',
                    hintStyle:
                        const TextStyle(color: Colors.grey, fontSize: 18),
                  ),
                ),
                SizedBox(height: 10, child: Container()),
                TextField(
                  onChanged: (text) {
                    REpasswordReg = text;
                  },
                  obscureText: true,
                  enableSuggestions: false,
                  autocorrect: false,
                  cursorColor: Colors.grey,
                  decoration: InputDecoration(
                    icon: const Icon(Icons.password_sharp), ////
                    fillColor: Colors.grey[100],
                    filled: true,
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide.none),
                    hintText: 'Password Confirm',
                    hintStyle:
                        const TextStyle(color: Colors.grey, fontSize: 18),
                  ),
                ),
                SizedBox(height: 10, child: Container()),
                TextField(
                  onChanged: (text) {
                    email = text;
                  },
                  cursorColor: Colors.grey,
                  decoration: InputDecoration(
                    icon: const Icon(Icons.mark_email_unread_outlined),
                    fillColor: Colors.grey[100],
                    filled: true,
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide.none),
                    hintText: 'Email',
                    hintStyle:
                        const TextStyle(color: Colors.grey, fontSize: 18),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 10, child: Container()),
          ElevatedButton(
            onPressed: () {
              //print(nameReg +" "+passwordReg+" "+REpasswordReg+" "+email);

              if (email == "" ||
                  nameReg == "" ||
                  surnameReg == "" ||
                  REpasswordReg == "" ||
                  passwordReg == "") {
                _showDialog3();
              } else if (passwordReg == REpasswordReg) {
                metot("post",
                    "http://157.245.18.250:8000/api/services/app/User/Create", {
                  "userName": email,
                  "name": nameReg,
                  "surname": surnameReg,
                  "emailAddress": email,
                  "password": passwordReg
                });
              } else {
                _showDialog();
              }
            },
            style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue,
                padding:
                    const EdgeInsets.symmetric(horizontal: 148, vertical: 20),
                textStyle:
                    const TextStyle(fontSize: 30, fontWeight: FontWeight.bold)),
            child: const Text('Confirm'),
          )
        ],
      ),
    );
  }
}
