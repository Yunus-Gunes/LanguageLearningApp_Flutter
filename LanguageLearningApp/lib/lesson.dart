import 'package:flutter/material.dart';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:languagelearningapp/globals.dart' as globals;

String LessonName = "";

class Lesson extends StatefulWidget {
  const Lesson({Key? key}) : super(key: key);

  @override
  State<Lesson> createState() => _LessonState();
}

class _LessonState extends State<Lesson> {
  @override
  void initState() {
    super.initState();
    LessonFunc();
    take_Command();
  }

  List<String> grammerQuestionsSentence = [];
  List<String> grammerQuestionsOptionA = [];
  List<String> grammerQuestionsOptionB = [];
  List<String> grammerQuestionsOptionC = [];
  List<String> grammerQuestionsOptionD = [];
  List<String> grammerQuestionsCorrect = [];

  List<String> listeningEngSentence = [];

  List<String> vocabularyQuestionsWord = [];
  List<String> vocabularyQuestionsOptionA = [];
  List<String> vocabularyQuestionsOptionB = [];
  List<String> vocabularyQuestionsOptionC = [];
  List<String> vocabularyQuestionsOptionD = [];
  List<String> vocabularyQuestionsCorrect = [];

  List<String> writingQuestionsEngSentence = [];
  List<String> writingQuestionsTurkSentence = [];
  List<String> speakingEngSentence = [];

  TextEditingController comment = TextEditingController();
  TextEditingController rate = TextEditingController();

  List<String> command = [];
  List<int> commandRate = [];
  List<String> commandUser = [];

  void send_Command(String methodName, String url, Map<String, Object> requestBody) async {

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
        //print(response);
        _showDialog();
      } else {
        // kullnıcaya hata mesajı göster
      }
    } catch (e) {
      print(e);
    }
  }
  void _showDialog() {
    comment.text="";
    rate.text="";
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
          title: const Text("OK"),
          content: const Text("Comment has been written"),
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

  void take_Command() async {
    var response = await Dio().request(
        "http://157.245.18.250:8000/api/services/app/Comment/GetAllByLesson?lessonId="
            "${globals.lessonId}",

        options: Options(headers: {
          HttpHeaders.contentTypeHeader: "application/json",
          //HttpHeaders.authorizationHeader: "Bearer $token",
          "Authorization": "Bearer ${globals.token}",
          "Accept": "*/*",
          "Connection": "keep-alive",
          "Acccept-Encoding": "gzip, deflate, br",
        }, method: "get"));

    print(response);

    for (var i in response.data["result"]) {
      command.add(i["content"]);
      commandUser.add(i["user"]["fullName"]);
      commandRate.add(i["rate"]);
    }
    setState(() {});
  }


  FlutterTts flutterTts = FlutterTts();


  void LessonFunc() async {
    var response = await Dio().request(
        "http://157.245.18.250:8000/api/services/app/Lesson/Get?"
        "Id=${globals.lessonId}",
        //data: {globals.lessonId},
        options: Options(headers: {
          HttpHeaders.contentTypeHeader: "application/json",
          //HttpHeaders.authorizationHeader: "Bearer $token",
          "Authorization": "Bearer ${globals.token}",
          "Accept": "*/*",
          "Connection": "keep-alive",
          "Acccept-Encoding": "gzip, deflate, br",
        }, method: "get"));

    for (var i in response.data["result"]["gramerQuestions"]) {
      grammerQuestionsSentence.add(i["sentence"]);
      grammerQuestionsOptionA.add(i["optionA"]);
      grammerQuestionsOptionB.add(i["optionB"]);
      grammerQuestionsOptionC.add(i["optionC"]);
      grammerQuestionsOptionD.add(i["optionD"]);
      grammerQuestionsCorrect.add(i["correctOption"]);
    }
    for (var i in response.data["result"]["listeningQuestions"]) {
      listeningEngSentence.add(i["englishSentence"]);
    }
    for (var i in response.data["result"]["vocabularyQuestions"]) {
      vocabularyQuestionsWord.add(i["word"]);
      vocabularyQuestionsOptionA.add(i["optionA"]);
      vocabularyQuestionsOptionB.add(i["optionB"]);
      vocabularyQuestionsOptionC.add(i["optionC"]);
      vocabularyQuestionsOptionD.add(i["optionD"]);
      vocabularyQuestionsCorrect.add(i["correctOption"]);
    }
    for (var i in response.data["result"]["writingQuestions"]) {
      writingQuestionsTurkSentence.add(i["turkishSentence"]);
      writingQuestionsEngSentence.add(i["englishSentence"]);
    }
    for (var i in response.data["result"]["speakingQuestions"]) {
      speakingEngSentence.add(i["englishSentence"]);
    }

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    speak(String text) async {
      await flutterTts.setLanguage("en-US");
      await flutterTts.speak(text);
    }
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
            title: const Text('Profile'),
            onTap: () {
              Navigator.pushNamed(context, '/profile');
            },
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
            children: <Widget>[
              const SizedBox(
                height: 5,
              ),
              const Text('EXAMPLE QUESTIONS'),
              const Divider(),
              ListView.builder(
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: grammerQuestionsSentence.length,
                itemBuilder: (context, index) {
                  return Card(
                    child: Column(
                      children: <Widget>[
                        Text(
                            grammerQuestionsSentence[index],
                          style: const TextStyle(
                            fontSize: 20,
                          ),
                        ),
                        const SizedBox(height: 10,),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: <Widget>[
                            Text("A) ${grammerQuestionsOptionA[index]}"),
                            Text("B) ${grammerQuestionsOptionB[index]}"),
                            Text("C) ${grammerQuestionsOptionC[index]}"),
                            Text("D) ${grammerQuestionsOptionD[index]}"),
                          ],
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        ElevatedButton(
                            onPressed: () {
                              showDialog(
                                  context: context,
                                  builder: (context) {
                                    return AlertDialog(
                                      title: const Text("Correct Answer"),
                                      content:
                                          Text(grammerQuestionsCorrect[index]),
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
                                  });
                            },
                            child: const Text("Show Correct Answer")),
                        const SizedBox(
                          height: 5,
                        ),
                      ],
                    ),
                  );
                },
              ),
              SizedBox(width: 10),
              const Divider(),

              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  const Padding(
                    padding: EdgeInsets.all(5),
                  ),
                  Flexible(
                    child: TextField(
                      cursorColor: Colors.grey,
                      decoration: InputDecoration(
                        fillColor: Colors.grey[100],
                        filled: true,
                        hintText: 'Your Answer',
                        hintStyle:
                        const TextStyle(color: Colors.grey, fontSize: 10),
                      ),
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.all(5),
                  ),
                  ElevatedButton(
                      onPressed: () => speak(listeningEngSentence[0]),
                      child: const Text("Listen")
                  ),
                  const Padding(
                    padding: EdgeInsets.all(5),
                  ),
                  ElevatedButton(
                      onPressed: () {
                        showDialog(context: context, builder: (context){
                          return AlertDialog(
                            title: const Text("Listening Answer"),
                            content: Text(listeningEngSentence[0]),
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
                        });
                      },
                      child: const Text("Show Correct Answer")),
                ],
              ),
              const SizedBox(height: 5,),
              const Padding(padding: EdgeInsets.all(5),),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  const Padding(
                    padding: EdgeInsets.all(5),
                  ),
                  Flexible(

                    child: TextField(
                      cursorColor: Colors.grey,
                      decoration: InputDecoration(
                        fillColor: Colors.grey[100],
                        filled: true,
                        hintText: 'Your Answer',
                        hintStyle:
                        const TextStyle(color: Colors.grey, fontSize: 10),
                      ),
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.all(5),
                  ),

                  ElevatedButton(
                      onPressed: () => speak(listeningEngSentence[1]),
                      child: const Text("Listen")
                  ),

                  const Padding(
                    padding: EdgeInsets.all(5),
                  ),
                  ElevatedButton(
                      onPressed: () {
                        showDialog(context: context, builder: (context){
                          return AlertDialog(
                            title: const Text("Listening Answer"),
                            content: Text(listeningEngSentence[1]),
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
                        });
                      },
                      child: const Text("Show Correct Answer")),
                ],
              ),
              SizedBox(width: 10),
              const Divider(),
              ListView.builder(
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: vocabularyQuestionsWord.length,
                itemBuilder: (context, index) {
                  return Card(
                    child: Column(
                      children: <Widget>[
                        const SizedBox(
                          height: 5,
                        ),
                        Text(
                          vocabularyQuestionsWord[index],
                          style: const TextStyle(
                            fontSize: 20,
                          ),
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: <Widget>[
                            Text( "A${vocabularyQuestionsOptionA[index]}"),
                            Text( "B${vocabularyQuestionsOptionB[index]}"),
                            Text( "C${vocabularyQuestionsOptionC[index]}"),
                            Text( "D${vocabularyQuestionsOptionD[index]}"),
                          ],
                        ),
                        const Padding(
                          padding: EdgeInsets.all(5),
                        ),
                        ElevatedButton(
                            onPressed: () {
                              showDialog(context: context, builder: (context){return AlertDialog(
                                title: const Text("Correct Answer"),
                                content:
                                Text(vocabularyQuestionsCorrect[index]),
                                actions: <Widget>[
                                  // usually buttons at the bottom of the dialog
                                  ElevatedButton(
                                    child: const Text("Close"),
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                    },
                                  ),
                                ],
                              );});
                            },
                            child: const Text("Show Correct Answer")),
                        const SizedBox(
                          height: 5,
                        ),
                      ],
                    ),
                  );
                },
              ),
              SizedBox(width: 10),
              const Divider(),
              SizedBox(width: 10),
              ListView.builder(
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: writingQuestionsTurkSentence.length,
                itemBuilder: (context, index) {
                  return Card(
                    child: Column(
                      children: <Widget>[
                        const SizedBox(
                          height: 5,
                        ),
                        Text(
                          writingQuestionsTurkSentence[index],
                          style: const TextStyle(
                            fontSize: 20,
                          ),
                        ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          const Padding(
                            padding: EdgeInsets.all(5),
                          ),
                          Flexible(
                            child: TextField(
                              cursorColor: Colors.grey,
                              decoration: InputDecoration(
                                fillColor: Colors.grey[100],
                                filled: true,
                                hintText: 'Your Answer',
                                hintStyle:
                                const TextStyle(color: Colors.grey, fontSize: 10),
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          const Padding(
                            padding: EdgeInsets.all(5),
                          ),
                          ElevatedButton(
                              onPressed: () {
                                showDialog(context: context, builder: (context){return AlertDialog(
                                  title: const Text("Correct Answer"),
                                  content:
                                  Text(writingQuestionsEngSentence[index]),
                                  actions: <Widget>[
                                    // usually buttons at the bottom of the dialog
                                    ElevatedButton(
                                      child: const Text("Close"),
                                      onPressed: () {
                                        Navigator.of(context).pop();
                                      },
                                    ),
                                  ],
                                );});
                              },
                              child: const Text("Show Correct Answer")),
                          const SizedBox(
                            height: 5,
                          ),
                        ],
                      ),

                      ],

                    ),
                  );
                },


              ),
              SizedBox(width: 10),
              const Divider(),
              SizedBox(width: 10),
              ListView.builder(
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: speakingEngSentence.length,
                itemBuilder: (context, index) {
                  return Card(
                    child: Column(
                      children: <Widget>[
                        const SizedBox(
                          height: 5,
                        ),
                        ElevatedButton(
                            onPressed: () {
                              showDialog(context: context, builder: (context){return AlertDialog(
                                title: const Text("Speaking Answer"),
                                content: Text(speakingEngSentence[index]),
                                actions: <Widget>[
                                  // usually buttons at the bottom of the dialog
                                  ElevatedButton(
                                    child: const Text("Close"),
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                    },
                                  ),
                                ],
                              );});
                            },
                            child: const Text("Show Correct Answer")),
                        const SizedBox(
                          height: 5,
                        ),
                      ],
                    ),
                  );
                },
              ),
              const Divider(),
              ElevatedButton(
                  onPressed: () {
                    Navigator.pushNamed(context, '/exam');
                  },

                  style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                  padding:
                  const EdgeInsets.symmetric(horizontal: 60, vertical: 15),
                  textStyle:
                  const TextStyle(fontSize: 35, fontWeight: FontWeight.bold)),
                  child: const Text('Take Exam'),
              ),
              const SizedBox(
                height: 5,
              ),
              const Divider(),
              const SizedBox(
                height: 5,
              ),
              SizedBox(
                  width: 500,
                  height: 150,
                  child: Column(
                    children: <Widget>[
                      const Text(
                        "COMMENTS",
                        style: TextStyle(
                          fontSize: 60,
                        ),
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: TextField(
                              controller: comment, //ismi burda alıyo
                              cursorColor: Colors.grey,
                              decoration: InputDecoration(
                                fillColor: Colors.grey[100],
                                filled: true,
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                    borderSide: BorderSide.none),
                                hintText: 'Your Command',
                                hintStyle:
                                const TextStyle(color: Colors.grey, fontSize: 18),
                              ),
                            ),
                          ),
                          SizedBox(width: 8), // Add some spacing between the TextFields
                          Expanded(
                            child: TextField(
                              controller: rate, //ismi burda alıyo
                              cursorColor: Colors.grey,
                              keyboardType: TextInputType.number,
                              decoration: InputDecoration(
                                fillColor: Colors.grey[100],
                                filled: true,
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                    borderSide: BorderSide.none),
                                hintText: 'Your Rate',
                                hintStyle:
                                const TextStyle(color: Colors.grey, fontSize: 18),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  )),

              ElevatedButton(
                onPressed: () {
                  send_Command("post",
                      "http://157.245.18.250:8000/api/services/app/Comment/Create", {
                        "content": comment.text,
                        "rate": int.parse(rate.text),
                        "lessonId": int.parse(globals.lessonId),
                      });
                },
                style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue,
                    padding:
                    const EdgeInsets.symmetric(horizontal: 60, vertical: 15),
                    textStyle:
                    const TextStyle(fontSize: 30, fontWeight: FontWeight.bold)),
                child: const Text('Send Comment'),
              ),

              const Divider(),
              ListView.builder(
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: command.length,
                itemBuilder: (context, index) {
                  return Card(
                    child: Column(
                      children: <Widget>[
                        Text( "$commandUser  ${commandRate[index]} STAR : ${command[index]}" ),

                        const SizedBox(
                          height: 5,
                        ),
                      ],
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
