import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconsax/iconsax.dart';
import 'order.dart';

 // ignore: must_be_immutable
 class OrderDetailsPage extends StatefulWidget {
    ReadyOrder readyOrder;
     OrderDetailsPage({Key? key, 
      required this.readyOrder
    }) : super(key: key);

    @override
    // ignore: no_logic_in_create_state
    State<OrderDetailsPage> createState() => _OrderDetailsPageState(readyOrder: readyOrder);
  }

  class _OrderDetailsPageState extends State<OrderDetailsPage> {

    _OrderDetailsPageState({
      required this.readyOrder
    });
       
    Color additionalColor = const Color.fromRGBO(248, 248, 248, 1);
    Color textColor = const Color.fromRGBO(68, 68,68, 1);
    ReadyOrder readyOrder;

    @override
    void initState(){
      super.initState();
    }

       
    @override
    Widget build(BuildContext context) {
      switch(readyOrder.statufOfProcessing){
        case 0:
        case 1:
        case 2:
        case 3: 
        case 4: return Scaffold(
          backgroundColor: additionalColor,
          body: Center(child: Container(
               padding: EdgeInsets.only(left: MediaQuery.of(context).size.width*0.05,
                                                            right: MediaQuery.of(context).size.width*0.07,
                                                            top: MediaQuery.of(context).size.height*0.01,
                                                            bottom: MediaQuery.of(context).size.height*0.015),
              decoration: BoxDecoration(borderRadius: BorderRadius.circular(15), 
                                        color: const Color.fromRGBO(255, 255, 255, 1)),
              width: MediaQuery.of(context).size.width*0.9,
              height: MediaQuery.of(context).size.height*0.4,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                    Container(
                      width: MediaQuery.of(context).size.width*0.09,
                      height: MediaQuery.of(context).size.width*0.09,
                      decoration: BoxDecoration(borderRadius: BorderRadius.circular(100), 
                                      color: const Color.fromRGBO(222, 222, 222, 1)),
                      child: const Icon(Icons.check, size: 25)),
                        Container(
                          width: MediaQuery.of(context).size.width*0.49,
                          margin: EdgeInsets.only(left:  MediaQuery.of(context).size.width*0.05),
                          child: Text("Виконано", style: GoogleFonts.poiretOne(
                                                                            textStyle: TextStyle(
                                                                            color: textColor,
                                                                            fontSize: 18,
                                                                            decoration: TextDecoration.none,
                                                                            fontWeight: FontWeight.w800)))),                                                 
                  ],),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                    Container(
                      width: MediaQuery.of(context).size.width*0.09,
                      height: MediaQuery.of(context).size.width*0.09,
                      decoration: BoxDecoration(borderRadius: BorderRadius.circular(100), 
                                      color: const Color.fromRGBO(254, 182, 102, 1)),
                      child: const Icon(Icons.delivery_dining_outlined, size: 25)),
                        Container(
                          width: MediaQuery.of(context).size.width*0.49,
                          margin: EdgeInsets.only(left:  MediaQuery.of(context).size.width*0.05),
                          child: Text("У дорозі", style: GoogleFonts.poiretOne(
                                                                            textStyle: TextStyle(
                                                                            color: textColor,
                                                                            fontSize: 18,
                                                                            decoration: TextDecoration.none,
                                                                            fontWeight: FontWeight.w800)))),                                                 
                        Container(
                                alignment: Alignment.centerRight,
                                width: MediaQuery.of(context).size.width*0.15,
                                child: Text("21:40", style: GoogleFonts.poiretOne(
                                                                                  textStyle: const TextStyle(
                                                                                  color: Color.fromRGBO(254, 182, 102, 1),
                                                                                  fontSize: 14,
                                                                                  decoration: TextDecoration.none,
                                                                                  fontWeight: FontWeight.w800)))), 
                  ],),
                  Container(
                    alignment: Alignment.centerLeft,
                    decoration: BoxDecoration(borderRadius: BorderRadius.circular(15), 
                                                color: const Color.fromRGBO(240, 240, 240, 1)),
                    width: MediaQuery.of(context).size.width*0.64,
                    height: MediaQuery.of(context).size.height*0.1,
                    child: Row(
                                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                              crossAxisAlignment: CrossAxisAlignment.center,
                                              children: [
                                                Container(
                                                  width: MediaQuery.of(context).size.width* 0.12,
                                                  height: MediaQuery.of(context).size.width* 0.12,
                                                  alignment: Alignment.center,
                                                  child: ClipRRect(
                                                        borderRadius: const BorderRadius.all(Radius.circular(100)),
                                                        child:Image.asset(
                                                          width: MediaQuery.of(context).size.width* 0.12,
                                                          height: MediaQuery.of(context).size.width* 0.12,
                                                          "images/courier.png",
                                                          fit: BoxFit.fill))),
                                                Column(
                                                        mainAxisAlignment: MainAxisAlignment.center,
                                                        crossAxisAlignment: CrossAxisAlignment.start,
                                                        children: [
                                                          Text("Ваш кур'єр",
                                                              style: GoogleFonts.poiretOne(
                                                                          textStyle: TextStyle(
                                                                          color: textColor,
                                                                          fontSize: 16,
                                                                          fontWeight: FontWeight.w700))),
                                                          Text("Антон",
                                                              style: GoogleFonts.rubik(
                                                                          textStyle: TextStyle(
                                                                          color: textColor  ,
                                                                          fontSize: 18,
                                                                          fontWeight: FontWeight.w500))),   
                                                        ],),
                                                Container(
                                                  decoration: const BoxDecoration(color: Color.fromRGBO(254, 182, 102, 1),
                                                    borderRadius: BorderRadius.all(Radius.circular(15)),),
                                                  width: MediaQuery.of(context).size.width* 0.13,
                                                  height: MediaQuery.of(context).size.width* 0.11,
                                                  alignment: Alignment.center,
                                                  child: const Icon(Icons.phone, size: 25)),
                                            ])
                  )
                  
                  ]),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                    Container(
                      width: MediaQuery.of(context).size.width*0.09,
                      height: MediaQuery.of(context).size.width*0.09,
                      decoration: BoxDecoration(borderRadius: BorderRadius.circular(100), 
                                      color: const Color.fromRGBO(254, 182, 102, 1)),
                      child: const Icon(Icons.shopping_bag, size: 25)),
                        Container(
                          width: MediaQuery.of(context).size.width*0.49,
                          margin: EdgeInsets.only(left:  MediaQuery.of(context).size.width*0.05),
                          child: Text("Пакується", style: GoogleFonts.poiretOne(
                                                                            textStyle: TextStyle(
                                                                            color: textColor,
                                                                            fontSize: 18,
                                                                            decoration: TextDecoration.none,
                                                                            fontWeight: FontWeight.w800)))),                                                 
                        Container(
                                alignment: Alignment.centerRight,
                                width: MediaQuery.of(context).size.width*0.15,
                                child: Text("21:25", style: GoogleFonts.poiretOne(
                                                                                  textStyle: const TextStyle(
                                                                                  color: Color.fromRGBO(254, 182, 102, 1),
                                                                                  fontSize: 14,
                                                                                  decoration: TextDecoration.none,
                                                                                  fontWeight: FontWeight.w800)))), 
                  ],),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                    Container(
                      width: MediaQuery.of(context).size.width*0.09,
                      height: MediaQuery.of(context).size.width*0.09,
                      decoration: BoxDecoration(borderRadius: BorderRadius.circular(100), 
                                      color: const Color.fromRGBO(254, 182, 102, 1)),
                      child: const Icon(Icons.restaurant_rounded, size: 25)),
                        Container(
                          width: MediaQuery.of(context).size.width*0.49,
                          margin: EdgeInsets.only(left:  MediaQuery.of(context).size.width*0.05),
                          child: Text("Готується", style: GoogleFonts.poiretOne(
                                                                            textStyle: TextStyle(
                                                                            color: textColor,
                                                                            fontSize: 18,
                                                                            decoration: TextDecoration.none,
                                                                            fontWeight: FontWeight.w800)))),                                                 
                        Container(
                                alignment: Alignment.centerRight,
                                width: MediaQuery.of(context).size.width*0.15,
                                child: Text("20:40", style: GoogleFonts.poiretOne(
                                                                                  textStyle: const TextStyle(
                                                                                  color: Color.fromRGBO(254, 182, 102, 1),
                                                                                  fontSize: 14,
                                                                                  decoration: TextDecoration.none,
                                                                                  fontWeight: FontWeight.w800)))), 
                  ],),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                    Container(
                      width: MediaQuery.of(context).size.width*0.09,
                      height: MediaQuery.of(context).size.width*0.09,
                      decoration: BoxDecoration(borderRadius: BorderRadius.circular(100), 
                                      color: const Color.fromRGBO(254, 182, 102, 1)),
                      child: const Icon(Icons.timer, size: 25)),
                        Container(
                          width: MediaQuery.of(context).size.width*0.49,
                          margin: EdgeInsets.only(left:  MediaQuery.of(context).size.width*0.05),
                          child: Text("В обробці", style: GoogleFonts.poiretOne(
                                                                            textStyle: TextStyle(
                                                                            color: textColor,
                                                                            fontSize: 18,
                                                                            decoration: TextDecoration.none,
                                                                            fontWeight: FontWeight.w800)))),                                                 
                        Container(
                                alignment: Alignment.centerRight,
                                width: MediaQuery.of(context).size.width*0.15,
                                child: Text("20:20", style: GoogleFonts.poiretOne(
                                                                                  textStyle: const TextStyle(
                                                                                  color: Color.fromRGBO(254, 182, 102, 1),
                                                                                  fontSize: 14,
                                                                                  decoration: TextDecoration.none,
                                                                                  fontWeight: FontWeight.w800)))), 
                  ],),
                ])
            ))
          );
        case 5: return Scaffold(
          backgroundColor: additionalColor,
          body: Center(child: Container(
               padding: EdgeInsets.only(left: MediaQuery.of(context).size.width*0.05,
                                                            right: MediaQuery.of(context).size.width*0.07,
                                                            top: MediaQuery.of(context).size.height*0.01,
                                                            bottom: MediaQuery.of(context).size.height*0.015),
              decoration: BoxDecoration(borderRadius: BorderRadius.circular(15), 
                                        color: const Color.fromRGBO(255, 255, 255, 1)),
              width: MediaQuery.of(context).size.width*0.9,
              height: MediaQuery.of(context).size.height*0.4,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                    Container(
                      width: MediaQuery.of(context).size.width*0.09,
                      height: MediaQuery.of(context).size.width*0.09,
                      decoration: BoxDecoration(borderRadius: BorderRadius.circular(100), 
                                      color: const Color.fromRGBO(222, 222, 222, 1)),
                      child: const Icon(Icons.check, size: 25)),
                        Container(
                          width: MediaQuery.of(context).size.width*0.49,
                          margin: EdgeInsets.only(left:  MediaQuery.of(context).size.width*0.05),
                          child: Text("Виконано", style: GoogleFonts.poiretOne(
                                                                            textStyle: TextStyle(
                                                                            color: textColor,
                                                                            fontSize: 18,
                                                                            decoration: TextDecoration.none,
                                                                            fontWeight: FontWeight.w800)))),                                                 
                  ],),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                    Container(
                      width: MediaQuery.of(context).size.width*0.09,
                      height: MediaQuery.of(context).size.width*0.09,
                      decoration: BoxDecoration(borderRadius: BorderRadius.circular(100), 
                                      color: const Color.fromRGBO(254, 182, 102, 1)),
                      child: const Icon(Icons.delivery_dining_outlined, size: 25)),
                        Container(
                          width: MediaQuery.of(context).size.width*0.49,
                          margin: EdgeInsets.only(left:  MediaQuery.of(context).size.width*0.05),
                          child: Text("У дорозі", style: GoogleFonts.poiretOne(
                                                                            textStyle: TextStyle(
                                                                            color: textColor,
                                                                            fontSize: 18,
                                                                            decoration: TextDecoration.none,
                                                                            fontWeight: FontWeight.w800)))),                                                 
                        Container(
                                alignment: Alignment.centerRight,
                                width: MediaQuery.of(context).size.width*0.15,
                                child: Text("21:40", style: GoogleFonts.poiretOne(
                                                                                  textStyle: const TextStyle(
                                                                                  color: Color.fromRGBO(254, 182, 102, 1),
                                                                                  fontSize: 14,
                                                                                  decoration: TextDecoration.none,
                                                                                  fontWeight: FontWeight.w800)))), 
                  ],),
                  Container(
                    alignment: Alignment.centerLeft,
                    decoration: BoxDecoration(borderRadius: BorderRadius.circular(15), 
                                                color: const Color.fromRGBO(240, 240, 240, 1)),
                    width: MediaQuery.of(context).size.width*0.64,
                    height: MediaQuery.of(context).size.height*0.1,
                    child: Row(
                                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                              crossAxisAlignment: CrossAxisAlignment.center,
                                              children: [
                                                Container(
                                                  width: MediaQuery.of(context).size.width* 0.12,
                                                  height: MediaQuery.of(context).size.width* 0.12,
                                                  alignment: Alignment.center,
                                                  child: ClipRRect(
                                                        borderRadius: const BorderRadius.all(Radius.circular(100)),
                                                        child:Image.asset(
                                                          width: MediaQuery.of(context).size.width* 0.12,
                                                          height: MediaQuery.of(context).size.width* 0.12,
                                                          "images/courier.png",
                                                          fit: BoxFit.fill))),
                                                Column(
                                                        mainAxisAlignment: MainAxisAlignment.center,
                                                        crossAxisAlignment: CrossAxisAlignment.start,
                                                        children: [
                                                          Text("Ваш кур'єр",
                                                              style: GoogleFonts.poiretOne(
                                                                          textStyle: TextStyle(
                                                                          color: textColor,
                                                                          fontSize: 16,
                                                                          fontWeight: FontWeight.w700))),
                                                          Text("Антон",
                                                              style: GoogleFonts.rubik(
                                                                          textStyle: TextStyle(
                                                                          color: textColor  ,
                                                                          fontSize: 18,
                                                                          fontWeight: FontWeight.w500))),   
                                                        ],),
                                                Container(
                                                  decoration: const BoxDecoration(color: Color.fromRGBO(254, 182, 102, 1),
                                                    borderRadius: BorderRadius.all(Radius.circular(15)),),
                                                  width: MediaQuery.of(context).size.width* 0.13,
                                                  height: MediaQuery.of(context).size.width* 0.11,
                                                  alignment: Alignment.center,
                                                  child: const Icon(Icons.phone, size: 25)),
                                            ])
                  )
                  
                  ]),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                    Container(
                      width: MediaQuery.of(context).size.width*0.09,
                      height: MediaQuery.of(context).size.width*0.09,
                      decoration: BoxDecoration(borderRadius: BorderRadius.circular(100), 
                                      color: const Color.fromRGBO(254, 182, 102, 1)),
                      child: const Icon(Icons.shopping_bag, size: 25)),
                        Container(
                          width: MediaQuery.of(context).size.width*0.49,
                          margin: EdgeInsets.only(left:  MediaQuery.of(context).size.width*0.05),
                          child: Text("Пакується", style: GoogleFonts.poiretOne(
                                                                            textStyle: TextStyle(
                                                                            color: textColor,
                                                                            fontSize: 18,
                                                                            decoration: TextDecoration.none,
                                                                            fontWeight: FontWeight.w800)))),                                                 
                        Container(
                                alignment: Alignment.centerRight,
                                width: MediaQuery.of(context).size.width*0.15,
                                child: Text("21:25", style: GoogleFonts.poiretOne(
                                                                                  textStyle: const TextStyle(
                                                                                  color: Color.fromRGBO(254, 182, 102, 1),
                                                                                  fontSize: 14,
                                                                                  decoration: TextDecoration.none,
                                                                                  fontWeight: FontWeight.w800)))), 
                  ],),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                    Container(
                      width: MediaQuery.of(context).size.width*0.09,
                      height: MediaQuery.of(context).size.width*0.09,
                      decoration: BoxDecoration(borderRadius: BorderRadius.circular(100), 
                                      color: const Color.fromRGBO(254, 182, 102, 1)),
                      child: const Icon(Icons.restaurant_rounded, size: 25)),
                        Container(
                          width: MediaQuery.of(context).size.width*0.49,
                          margin: EdgeInsets.only(left:  MediaQuery.of(context).size.width*0.05),
                          child: Text("Готується", style: GoogleFonts.poiretOne(
                                                                            textStyle: TextStyle(
                                                                            color: textColor,
                                                                            fontSize: 18,
                                                                            decoration: TextDecoration.none,
                                                                            fontWeight: FontWeight.w800)))),                                                 
                        Container(
                                alignment: Alignment.centerRight,
                                width: MediaQuery.of(context).size.width*0.15,
                                child: Text("20:40", style: GoogleFonts.poiretOne(
                                                                                  textStyle: const TextStyle(
                                                                                  color: Color.fromRGBO(254, 182, 102, 1),
                                                                                  fontSize: 14,
                                                                                  decoration: TextDecoration.none,
                                                                                  fontWeight: FontWeight.w800)))), 
                  ],),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                    Container(
                      width: MediaQuery.of(context).size.width*0.09,
                      height: MediaQuery.of(context).size.width*0.09,
                      decoration: BoxDecoration(borderRadius: BorderRadius.circular(100), 
                                      color: const Color.fromRGBO(254, 182, 102, 1)),
                      child: const Icon(Icons.timer, size: 25)),
                        Container(
                          width: MediaQuery.of(context).size.width*0.49,
                          margin: EdgeInsets.only(left:  MediaQuery.of(context).size.width*0.05),
                          child: Text("В обробці", style: GoogleFonts.poiretOne(
                                                                            textStyle: TextStyle(
                                                                            color: textColor,
                                                                            fontSize: 18,
                                                                            decoration: TextDecoration.none,
                                                                            fontWeight: FontWeight.w800)))),                                                 
                        Container(
                                alignment: Alignment.centerRight,
                                width: MediaQuery.of(context).size.width*0.15,
                                child: Text("20:20", style: GoogleFonts.poiretOne(
                                                                                  textStyle: const TextStyle(
                                                                                  color: Color.fromRGBO(254, 182, 102, 1),
                                                                                  fontSize: 14,
                                                                                  decoration: TextDecoration.none,
                                                                                  fontWeight: FontWeight.w800)))), 
                  ],),
                ])
            ))
          );
        default: return Scaffold(
          backgroundColor: additionalColor,
          body: Center(child: Container(
               padding: EdgeInsets.only(left: MediaQuery.of(context).size.width*0.05,
                                                            right: MediaQuery.of(context).size.width*0.07,
                                                            top: MediaQuery.of(context).size.height*0.01,
                                                            bottom: MediaQuery.of(context).size.height*0.015),
              decoration: BoxDecoration(borderRadius: BorderRadius.circular(15), 
                                        color: const Color.fromRGBO(255, 255, 255, 1)),
              width: MediaQuery.of(context).size.width*0.9,
              height: MediaQuery.of(context).size.height*0.4,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                    Container(
                      width: MediaQuery.of(context).size.width*0.09,
                      height: MediaQuery.of(context).size.width*0.09,
                      decoration: BoxDecoration(borderRadius: BorderRadius.circular(100), 
                                      color: const Color.fromRGBO(222, 222, 222, 1)),
                      child: const Icon(Icons.check, size: 25)),
                        Container(
                          width: MediaQuery.of(context).size.width*0.49,
                          margin: EdgeInsets.only(left:  MediaQuery.of(context).size.width*0.05),
                          child: Text("Виконано", style: GoogleFonts.poiretOne(
                                                                            textStyle: TextStyle(
                                                                            color: textColor,
                                                                            fontSize: 18,
                                                                            decoration: TextDecoration.none,
                                                                            fontWeight: FontWeight.w800)))),                                                 
                  ],),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                    Container(
                      width: MediaQuery.of(context).size.width*0.09,
                      height: MediaQuery.of(context).size.width*0.09,
                      decoration: BoxDecoration(borderRadius: BorderRadius.circular(100), 
                                      color: const Color.fromRGBO(254, 182, 102, 1)),
                      child: const Icon(Icons.delivery_dining_outlined, size: 25)),
                        Container(
                          width: MediaQuery.of(context).size.width*0.49,
                          margin: EdgeInsets.only(left:  MediaQuery.of(context).size.width*0.05),
                          child: Text("У дорозі", style: GoogleFonts.poiretOne(
                                                                            textStyle: TextStyle(
                                                                            color: textColor,
                                                                            fontSize: 18,
                                                                            decoration: TextDecoration.none,
                                                                            fontWeight: FontWeight.w800)))),                                                 
                        Container(
                                alignment: Alignment.centerRight,
                                width: MediaQuery.of(context).size.width*0.15,
                                child: Text("21:40", style: GoogleFonts.poiretOne(
                                                                                  textStyle: const TextStyle(
                                                                                  color: Color.fromRGBO(254, 182, 102, 1),
                                                                                  fontSize: 14,
                                                                                  decoration: TextDecoration.none,
                                                                                  fontWeight: FontWeight.w800)))), 
                  ],),
                  Container(
                    alignment: Alignment.centerLeft,
                    decoration: BoxDecoration(borderRadius: BorderRadius.circular(15), 
                                                color: const Color.fromRGBO(240, 240, 240, 1)),
                    width: MediaQuery.of(context).size.width*0.64,
                    height: MediaQuery.of(context).size.height*0.1,
                    child: Row(
                                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                              crossAxisAlignment: CrossAxisAlignment.center,
                                              children: [
                                                Container(
                                                  width: MediaQuery.of(context).size.width* 0.12,
                                                  height: MediaQuery.of(context).size.width* 0.12,
                                                  alignment: Alignment.center,
                                                  child: ClipRRect(
                                                        borderRadius: const BorderRadius.all(Radius.circular(100)),
                                                        child:Image.asset(
                                                          width: MediaQuery.of(context).size.width* 0.12,
                                                          height: MediaQuery.of(context).size.width* 0.12,
                                                          "images/courier.png",
                                                          fit: BoxFit.fill))),
                                                Column(
                                                        mainAxisAlignment: MainAxisAlignment.center,
                                                        crossAxisAlignment: CrossAxisAlignment.start,
                                                        children: [
                                                          Text("Ваш кур'єр",
                                                              style: GoogleFonts.poiretOne(
                                                                          textStyle: TextStyle(
                                                                          color: textColor,
                                                                          fontSize: 16,
                                                                          fontWeight: FontWeight.w700))),
                                                          Text("Антон",
                                                              style: GoogleFonts.rubik(
                                                                          textStyle: TextStyle(
                                                                          color: textColor  ,
                                                                          fontSize: 18,
                                                                          fontWeight: FontWeight.w500))),   
                                                        ],),
                                                Container(
                                                  decoration: const BoxDecoration(color: Color.fromRGBO(254, 182, 102, 1),
                                                    borderRadius: BorderRadius.all(Radius.circular(15)),),
                                                  width: MediaQuery.of(context).size.width* 0.13,
                                                  height: MediaQuery.of(context).size.width* 0.11,
                                                  alignment: Alignment.center,
                                                  child: const Icon(Icons.phone, size: 25)),
                                            ])
                  )
                  
                  ]),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                    Container(
                      width: MediaQuery.of(context).size.width*0.09,
                      height: MediaQuery.of(context).size.width*0.09,
                      decoration: BoxDecoration(borderRadius: BorderRadius.circular(100), 
                                      color: const Color.fromRGBO(254, 182, 102, 1)),
                      child: const Icon(Icons.shopping_bag, size: 25)),
                        Container(
                          width: MediaQuery.of(context).size.width*0.49,
                          margin: EdgeInsets.only(left:  MediaQuery.of(context).size.width*0.05),
                          child: Text("Пакується", style: GoogleFonts.poiretOne(
                                                                            textStyle: TextStyle(
                                                                            color: textColor,
                                                                            fontSize: 18,
                                                                            decoration: TextDecoration.none,
                                                                            fontWeight: FontWeight.w800)))),                                                 
                        Container(
                                alignment: Alignment.centerRight,
                                width: MediaQuery.of(context).size.width*0.15,
                                child: Text("21:25", style: GoogleFonts.poiretOne(
                                                                                  textStyle: const TextStyle(
                                                                                  color: Color.fromRGBO(254, 182, 102, 1),
                                                                                  fontSize: 14,
                                                                                  decoration: TextDecoration.none,
                                                                                  fontWeight: FontWeight.w800)))), 
                  ],),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                    Container(
                      width: MediaQuery.of(context).size.width*0.09,
                      height: MediaQuery.of(context).size.width*0.09,
                      decoration: BoxDecoration(borderRadius: BorderRadius.circular(100), 
                                      color: const Color.fromRGBO(254, 182, 102, 1)),
                      child: const Icon(Icons.restaurant_rounded, size: 25)),
                        Container(
                          width: MediaQuery.of(context).size.width*0.49,
                          margin: EdgeInsets.only(left:  MediaQuery.of(context).size.width*0.05),
                          child: Text("Готується", style: GoogleFonts.poiretOne(
                                                                            textStyle: TextStyle(
                                                                            color: textColor,
                                                                            fontSize: 18,
                                                                            decoration: TextDecoration.none,
                                                                            fontWeight: FontWeight.w800)))),                                                 
                        Container(
                                alignment: Alignment.centerRight,
                                width: MediaQuery.of(context).size.width*0.15,
                                child: Text("20:40", style: GoogleFonts.poiretOne(
                                                                                  textStyle: const TextStyle(
                                                                                  color: Color.fromRGBO(254, 182, 102, 1),
                                                                                  fontSize: 14,
                                                                                  decoration: TextDecoration.none,
                                                                                  fontWeight: FontWeight.w800)))), 
                  ],),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                    Container(
                      width: MediaQuery.of(context).size.width*0.09,
                      height: MediaQuery.of(context).size.width*0.09,
                      decoration: BoxDecoration(borderRadius: BorderRadius.circular(100), 
                                      color: const Color.fromRGBO(254, 182, 102, 1)),
                      child: const Icon(Icons.timer, size: 25)),
                        Container(
                          width: MediaQuery.of(context).size.width*0.49,
                          margin: EdgeInsets.only(left:  MediaQuery.of(context).size.width*0.05),
                          child: Text("В обробці", style: GoogleFonts.poiretOne(
                                                                            textStyle: TextStyle(
                                                                            color: textColor,
                                                                            fontSize: 18,
                                                                            decoration: TextDecoration.none,
                                                                            fontWeight: FontWeight.w800)))),                                                 
                        Container(
                                alignment: Alignment.centerRight,
                                width: MediaQuery.of(context).size.width*0.15,
                                child: Text("20:20", style: GoogleFonts.poiretOne(
                                                                                  textStyle: const TextStyle(
                                                                                  color: Color.fromRGBO(254, 182, 102, 1),
                                                                                  fontSize: 14,
                                                                                  decoration: TextDecoration.none,
                                                                                  fontWeight: FontWeight.w800)))), 
                  ],),
                ])
            ))
          );
      }
      
    }
  }