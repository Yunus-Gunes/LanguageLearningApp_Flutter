import 'dart:io';
import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:languagelearningapp/globals.dart' as globals;

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  //static var token = _LoginState.token;
  //static var userIdd = _LoginState.userIdd;

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  @override
  initState() {
    super.initState();
    rememberer();
  }

  void metot( String methodName, String url, Map<String, Object> requestBody) async {

    try {
      var response = await Dio().request(url,
          data: requestBody,
          options: Options(headers: {
            HttpHeaders.contentTypeHeader: "application/json",
          }, method: methodName));
      if (response.statusCode == 200) {
        globals.token = response.data["result"]["accessToken"];
        globals.userIdd = (response.data["result"]["userId"]).toString();

        //print(response);

        if (_isChecked) {
          setRemember();
        } else {
          setNotRemember();
        }
        // Ana sayfaya git
        Navigator.pushNamed(context, '/home');
      } else {
        // kullnıcaya hata mesajı göster
      }
    } catch (e) {
      print(e);
      _showDialog();
    }
  }

  //Yanlış girilince hata esajı
  void _showDialog() {
    // flutter defined function
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
          title: const Text("Try again"),
          content: const Text("The user name or password is incorrect."),
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

  bool _isChecked = true;
   final TextEditingController _emailController = TextEditingController();
   final TextEditingController _passwordController =  TextEditingController();

  setRemember() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString("RememberName", _emailController.text);
    await prefs.setString("RememberPassword", _passwordController.text);
  }

  setNotRemember() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString("RememberName", "");
    await prefs.setString("RememberPassword", "");
  }

  rememberer() async {
    final prefs = await SharedPreferences.getInstance();
    String RememberName = prefs.getString('RememberName') ?? '';
    String RememberPassword = prefs.getString('RememberPassword') ?? '';
    _emailController.text = RememberName;
    _passwordController.text = RememberPassword;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.blueAccent,
        title: const Text('Login'),
        centerTitle: true,
      ),
      body: Column(
        children: <Widget>[
          SizedBox(height: 40, child: Container()),
          Stack(
            children: <Widget>[
              // Stroked text as border.
              Text(
                "Login Form",
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
                "Login Form",
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
              height: 125,
              child: Column(
                children: <Widget>[
                  TextField(
                    controller: _emailController, //ismi burda alıyo
                    cursorColor: Colors.grey,
                    decoration: InputDecoration(
                      icon: const Icon(Icons.perm_identity_sharp), ////
                      fillColor: Colors.grey[100],
                      filled: true,
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide.none),
                      hintText: 'Username',
                      hintStyle:
                          const TextStyle(color: Colors.grey, fontSize: 18),
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.all(5),
                  ),
                  TextField(
                    controller: _passwordController, //ismi burda alıyo
                    cursorColor: Colors.grey,
                    obscureText: true,
                    enableSuggestions: false,
                    autocorrect: false,
                    decoration: InputDecoration(
                      icon: const Icon(Icons.password_sharp), //
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
                ],
              )),
          SizedBox(
              width: 300,
              child: Column(
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      const SizedBox(
                        width: 10,
                      ), //SizedBox
                      const Text(
                        'Remember me ',
                        style: TextStyle(fontSize: 17.0),
                      ), //Text
                      const SizedBox(width: 10), //SizedBox
                      /** Checkbox Widget **/
                      Checkbox(
                        value: _isChecked,
                        onChanged: (bool? newValue) {
                          setState(() {
                            _isChecked = newValue!;
                          });
                        },
                      ) //Checkbox
                    ], //<Widget>[]
                  ), //Row
                ],
              )),
          SizedBox(height: 10, child: Container()),
          ElevatedButton(
            onPressed: () {
              //GİRİŞ YAPMA FONKSİYONU ÇAĞIRIYOR
              metot("post",
                  "http://157.245.18.250:8000/api/TokenAuth/Authenticate", {
                "userNameOrEmailAddress": _emailController.text,
                "password": _passwordController.text,
                "rememberClient": _isChecked.toString(),
              });
            },
            style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue,
                padding:
                    const EdgeInsets.symmetric(horizontal: 100, vertical: 20),
                textStyle:
                    const TextStyle(fontSize: 30, fontWeight: FontWeight.bold)),
            child: const Text('Login'),
          ),
          SizedBox(height: 20, child: Container()),
          SizedBox(
              width: 330,
              child: Column(
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      const Text(
                        "Don't have an account?",
                        style: TextStyle(fontSize: 17.0),
                      ), //T
                      const SizedBox(
                        width: 10,
                      ),
                      ElevatedButton(
                        onPressed: () {
                          Navigator.pushNamed(context, '/register');
                        },
                        style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.blue,
                            padding: const EdgeInsets.symmetric(
                                horizontal: 30, vertical: 10),
                            textStyle: const TextStyle(
                                fontSize: 12, fontWeight: FontWeight.bold)),
                        child: const Text('Register Button'),
                      )
                    ], //<Widget>[]
                  ), //Row
                ],
              )),
        ],
      ),
    );
  }
}
