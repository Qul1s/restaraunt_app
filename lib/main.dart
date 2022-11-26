import 'package:flutter/material.dart';
import 'package:restaraunt_app/main_screen.dart';
import 'package:restaraunt_app/saved_address.dart';


void main() {


  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: MainScreen(),
    );
  }
}



