import 'package:flutter/material.dart';
import 'package:languagelearningapp/home.dart';
import 'package:languagelearningapp/login.dart';
import 'package:languagelearningapp/lesson.dart';
import 'package:languagelearningapp/exam.dart';
import 'package:languagelearningapp/register.dart';
import 'package:languagelearningapp/language.dart';
import 'package:languagelearningapp/profile.dart';
import 'package:languagelearningapp/result.dart';


void main() => {
      runApp(MaterialApp(
        initialRoute: '/login',
        routes: {
          '/login': (context) => const Login(),
          '/register': (context) => const Register(),
          '/home': (context) => const Home(),
          '/profile': (context) => const Profile(),
          '/language': (context) => const Language(),
          '/lesson': (context) => const Lesson(),
          '/exam': (context) => const Exam(),
          '/result': (context) => const Results(),
        },
      )),
    };
