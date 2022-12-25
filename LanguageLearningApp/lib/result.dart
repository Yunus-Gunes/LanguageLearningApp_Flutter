import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:languagelearningapp/globals.dart' as globals;

class Results extends StatefulWidget {
  const Results({Key? key}) : super(key: key);

  @override
  State<Results> createState() => _ResultsState();
}

class _ResultsState extends State<Results> {

  List<String> TrueResult= [];
  List<String> FalseResult= [];

  @override
  void initState() {
    super.initState();


    Resultsss();

  }
  void metot(
      String methodName, String url, Map<String, Object> requestBody) async {
    try {
      var response = await Dio().request(url,
          data: requestBody,
          options: Options(headers: {
            HttpHeaders.contentTypeHeader: "application/json",
            "Authorization": "Bearer ${globals.token}",
            "Accept": "*/*",
            "Connection": "keep-alive",
            "Acccept-Encoding": "gzip, deflate, br",
          }, method: methodName));
      if (response.statusCode == 200) {
        print(response);

        if(TrueResult.length >5){
          pass();
        }else{
          fail();
        }

      } else {
        // kullnıcaya hata mesajı göster
      }
    } catch (e) {
      print(e);
    }
  }
  void Resultsss(){
    TrueResult =[];
      for(var i in globals.Result){
        if(i == "true"){
          TrueResult.add("true");
        }
        else
          {
            FalseResult.add("false");
          }
      }



      metot("post",
          "http://157.245.18.250:8000/api/services/app/Exam/CreateExamResultAndUpdateExamPassedValue", {
            "lessonId": int.parse(globals.lessonId),
            "grade": TrueResult.length*10,
          });

  }

  void pass() {
    // flutter defined function
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
          title: const Text("Congratulations"),
          content: const Text("Congratulations you passed the exam."),
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
  void fail() {
    // flutter defined function
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
          title: const Text("Sorry"),
          content: const Text("Sorry you failed the exam."),
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
        backgroundColor: Colors.blueAccent,
        title: const Text('Exam'),
    centerTitle: true,
    ),
    body: SafeArea(child: Column(
      children:<Widget>[
        ListView.builder(
          shrinkWrap: true,
          itemCount: globals.Result.length,
          itemBuilder: (context, index){
            return ListTile(title: Text("${index+1} : ${globals.Result[index]}"),);
          },
        ),
        Text("Result: ${TrueResult.length*10}" ),

        ElevatedButton(
            onPressed: () {
              Navigator.pushNamed(context, '/language');
            },
            child: const Text('Finish Exam'))
      ]

    ),),);
  }
}
