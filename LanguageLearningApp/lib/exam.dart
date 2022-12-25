import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'dart:io';
import 'package:languagelearningapp/globals.dart' as globals;
import 'package:flutter_tts/flutter_tts.dart';
//import 'package:speech_to_text/speech_to_text.dart' as stt;


class Exam extends StatefulWidget {
  const Exam({Key? key}) : super(key: key);

  @override
  State<Exam> createState() => _ExamState();
}

class _ExamState extends State<Exam> {



  @override
  void initState() {
    super.initState();

    ExamFunc();
  }

  List<String> ExamgrammerQuestionsSentence = [];
  List<String> ExamgrammerQuestionsOptionA = [];
  List<String> ExamgrammerQuestionsOptionB = [];
  List<String> ExamgrammerQuestionsOptionC = [];
  List<String> ExamgrammerQuestionsOptionD = [];
  List<String> ExamgrammerQuestionsCorrect = [];

  List<String> ExamlisteningEngSentence = [];

  List<String> ExamvocabularyQuestionsWord = [];
  List<String> ExamvocabularyQuestionsOptionA = [];
  List<String> ExamvocabularyQuestionsOptionB = [];
  List<String> ExamvocabularyQuestionsOptionC = [];
  List<String> ExamvocabularyQuestionsOptionD = [];
  List<String> ExamvocabularyQuestionsCorrect = [];

  List<String> ExamwritingQuestionsEngSentence = [];
  List<String> ExamwritingQuestionsTurkSentence = [];

  List<String> ExamspeakingEngSentence = [];

  void ExamFunc() async {

    globals.Result.clear();

    var response = await Dio().request(
        "http://157.245.18.250:8000/api/services/app/Exam/GetExamByLesson?"
            "LessonId=${globals.lessonId}",
        data: {globals.lessonId},
        options: Options(headers: {
          HttpHeaders.contentTypeHeader: "application/json",
          //HttpHeaders.authorizationHeader: "Bearer $token",
          "Authorization": "Bearer ${globals.token}",
          "Accept": "*/*",
          "Connection": "keep-alive",
          "Acccept-Encoding": "gzip, deflate, br",
        }, method: "get"));

    for (var i in response.data["result"]["gramerQuestions"]) {
      ExamgrammerQuestionsSentence.add(i["sentence"]);
      ExamgrammerQuestionsOptionA.add(i["optionA"]);
      ExamgrammerQuestionsOptionB.add(i["optionB"]);
      ExamgrammerQuestionsOptionC.add(i["optionC"]);
      ExamgrammerQuestionsOptionD.add(i["optionD"]);
      ExamgrammerQuestionsCorrect.add(i["correctOption"]);
    }
    for (var i in response.data["result"]["listeningQuestions"]) {
      ExamlisteningEngSentence.add(i["englishSentence"]);
    }
    for (var i in response.data["result"]["vocabularyQuestions"]) {
      ExamvocabularyQuestionsWord.add(i["word"]);
      ExamvocabularyQuestionsOptionA.add(i["optionA"]);
      ExamvocabularyQuestionsOptionB.add(i["optionB"]);
      ExamvocabularyQuestionsOptionC.add(i["optionC"]);
      ExamvocabularyQuestionsOptionD.add(i["optionD"]);
      ExamvocabularyQuestionsCorrect.add(i["correctOption"]);
    }
    for (var i in response.data["result"]["writingQuestions"]) {
      ExamwritingQuestionsTurkSentence.add(i["turkishSentence"]);
      ExamwritingQuestionsEngSentence.add(i["englishSentence"]);
    }
    for (var i in response.data["result"]["speakingQuestions"]) {
      ExamspeakingEngSentence.add(i["englishSentence"]);
    }

    setState(() {});
  }


  FlutterTts flutterTts = FlutterTts();

  final TextEditingController _listeningText =  TextEditingController();
  final TextEditingController _listeningText2 =  TextEditingController();
  final TextEditingController _writeText =  TextEditingController();
  final TextEditingController _writeText2 =  TextEditingController();



  @override
  Widget build(BuildContext context) {
    speak(String text) async {
          await flutterTts.setLanguage("en-US");
          await flutterTts.speak(text);
    }

    globals.Result.clear();

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.blueAccent,
        title: const Text('Exam'),
        centerTitle: true,
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
                itemCount: ExamgrammerQuestionsSentence.length,
                itemBuilder: (context, index) {
                  return Card(
                    child: Column(
                      children: <Widget>[

                        Text(
                          ExamgrammerQuestionsSentence[index],
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
                            ElevatedButton(
                              onPressed: () {
                                if (ExamgrammerQuestionsCorrect[index] == "A") {
                                  globals.Result.add("true");
                                } else {
                                  globals.Result.add("false");
                                }
                              },
                              child: Text("A )${ExamgrammerQuestionsOptionA[index]}"),
                            ),
                            ElevatedButton(
                              onPressed: () {
                                if (ExamgrammerQuestionsCorrect[index] == "B") {
                                  globals.Result.add("true");
                                } else {
                                  globals.Result.add("false");
                                }
                              },
                              child: Text("B )${ExamgrammerQuestionsOptionB[index]}"),
                            ),
                            ElevatedButton(
                              onPressed: () {
                                if (ExamgrammerQuestionsCorrect[index] == "C") {
                                  globals.Result.add("true");
                                } else {
                                  globals.Result.add("false");
                                }
                              },
                              child: Text("C )${ExamgrammerQuestionsOptionC[index]}"),
                            ),
                            ElevatedButton(
                              onPressed: () {
                                if (ExamgrammerQuestionsCorrect[index] == "D") {
                                  globals.Result.add("true");
                                } else {
                                  globals.Result.add("false");
                                }
                              },
                              child: Text("D )${ExamgrammerQuestionsOptionD[index]}"),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                      ],
                    ),
                  );
                },
              ),
              const SizedBox(height: 5,),
              const Divider(),
              Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            const Padding(
                              padding: EdgeInsets.all(5),
                            ),
                              Flexible(
                                child: TextField(
                                  controller: _listeningText, //ismi burda alıyo
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
                                onPressed: () => speak(ExamlisteningEngSentence[0]),
                                child: const Text("Listen")),

                            const SizedBox(
                              height: 5,
                            ),
                          ],
                    ),
              const SizedBox(
                height: 5,
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  const Padding(
                    padding: EdgeInsets.all(5),
                  ),
                  Flexible(

                    child: TextField(
                      controller: _listeningText2, //ismi burda alıyo
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
                      onPressed: () => speak(ExamlisteningEngSentence[1]),
                      child: const Text("Listen")),

                  const SizedBox(
                    height: 5,
                  ),
                ],
              ),


              const Divider(),
              ListView.builder(
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: ExamvocabularyQuestionsWord.length,
                itemBuilder: (context, index) {
                  return Card(
                    child: Column(
                      children: <Widget>[
                        Text(
                          ExamvocabularyQuestionsWord[index],
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
                            ElevatedButton(
                              onPressed: () {
                                if (ExamvocabularyQuestionsCorrect[index] == "A") {
                                  globals.Result.add("true");
                                } else {
                                  globals.Result.add("false");
                                }
                              },
                              child:
                              Text("A ) ${ExamvocabularyQuestionsOptionA[index]}"),
                            ),
                            ElevatedButton(
                              onPressed: () {
                                if (ExamvocabularyQuestionsCorrect[index] == "B") {
                                  globals.Result.add("true");
                                } else {
                                  globals.Result.add("false");
                                }
                              },
                              child:
                              Text("B ) ${ExamvocabularyQuestionsOptionB[index]}"),
                            ),
                            ElevatedButton(
                              onPressed: () {
                                if (ExamvocabularyQuestionsCorrect[index] == "C") {
                                  globals.Result.add("true");
                                } else {
                                  globals.Result.add("false");
                                }
                              },
                              child:
                              Text("C ) ${ExamvocabularyQuestionsOptionC[index]}"),
                            ),
                            ElevatedButton(
                              onPressed: () {
                                if (ExamvocabularyQuestionsCorrect[index] == "D") {
                                  globals.Result.add("true");
                                } else {
                                  globals.Result.add("false");
                                }
                              },
                              child:
                              Text("D ) ${ExamvocabularyQuestionsOptionD[index]}"),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                      ],
                    ),
                  );
                },
              ),
              const Divider(),
              ListView.builder(
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: ExamwritingQuestionsTurkSentence.length,
                itemBuilder: (context, index) {
                  return Card(
                    child: Column(
                      children: <Widget>[
                        const SizedBox(
                          height: 5,
                        ),
                        Text(
                          ExamwritingQuestionsTurkSentence[index],
                          style: const TextStyle(
                            fontSize: 20,
                          ),
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        TextField(
                          cursorColor: Colors.grey,
                          decoration: InputDecoration(
                            fillColor: Colors.grey[100],
                            filled: true,
                            hintText: 'Your Answer',
                            hintStyle:
                            const TextStyle(color: Colors.grey, fontSize: 10),
                          ),
                        ),
                        const Padding(
                          padding: EdgeInsets.all(5),
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                      ],
                    ),
                  );
                },
              ),



              const Divider(),
              ListView.builder(
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: ExamspeakingEngSentence.length,
                itemBuilder: (context, index) {
                  return Card(
                    child: Column(
                      children: <Widget>[
                        const SizedBox(
                          height: 5,
                        ),
                        ElevatedButton(
                            onPressed: () {
                              globals.Result.add("true");
                            },
                            child: const Text("Speking soruları dahil edilmemiştir")),
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

                    //LİSTENİNG SORULARI
                    if (_listeningText.text.toLowerCase()
                        == ExamlisteningEngSentence[0].toLowerCase()){
                      globals.Result.add("true");
                    }else{
                      globals.Result.add("false");
                    }
                    if (_listeningText2.text.toLowerCase()
                        == ExamlisteningEngSentence[1].toLowerCase()){
                      globals.Result.add("true");
                    }else{
                      globals.Result.add("false");
                    }

                    //WRİTEİNG SORULARI
                    if (_writeText.text.toLowerCase()
                        == ExamwritingQuestionsEngSentence[0].toLowerCase()){
                      globals.Result.add("true");
                    }else{
                      globals.Result.add("false");
                    }
                    if (_writeText2.text.toLowerCase()
                        == ExamwritingQuestionsEngSentence[1].toLowerCase()){
                      globals.Result.add("true");
                    }else{
                      globals.Result.add("false");
                    }


                    Navigator.pushNamed(context, '/result');
                  },
                  child: const Text('Finish Exam'))
            ],
          ),
        ),
      ),
    );
  }
}
