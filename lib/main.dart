import 'package:flutter/material.dart';
import 'package:restaraunt_app/main_screen.dart';
import 'package:restaraunt_app/order.dart';
import "order_details.dart";


void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: OrderDetailsPage(readyOrder: ReadyOrderList.readyOrder[3]),
    );
  }
}



