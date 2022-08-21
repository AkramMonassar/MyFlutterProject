import 'package:flutter/material.dart';
import 'home_screen.dart';

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    theme: ThemeData(
      brightness: Brightness.light,
      primaryColor: Colors.blueAccent,
      primarySwatch: Colors.lightBlue,
    ),
    home: Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor:Colors.blueAccent ,
        title: const Text("Age Calculator",style: TextStyle(color: Colors.white),),
        actions: const <Widget>[
          // overflow menu
        ],
      ),
      body: HomeScreen(),
    ),
  ));
}
