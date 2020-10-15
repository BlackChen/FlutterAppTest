import 'package:FlutterAppTest/HomePage.dart';
import 'package:FlutterAppTest/RandomWords/RandomWords.dart';
import 'package:flutter/material.dart';
import 'package:english_words/english_words.dart';



void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'Welcome to Flutter1',
      // theme: new ThemeData(
        // primaryColor: Colors.white,
      // ),
      home: new FlutterMenu(),
    );
  }
}