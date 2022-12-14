import 'dart:convert';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:blur/blur.dart';
import 'package:dotted_decoration/dotted_decoration.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutterfire_ui/database.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:url_launcher/url_launcher.dart';

 // ignore: must_be_immutable
 class OrderDetailsPage extends StatefulWidget {
    String index;
     OrderDetailsPage({Key? key, 
      required this.index
    }) : super(key: key);

    @override
    // ignore: no_logic_in_create_state
    State<OrderDetailsPage> createState() => _OrderDetailsPageState(index: index);
  }

  class _OrderDetailsPageState extends State<OrderDetailsPage> {

    _OrderDetailsPageState({
      required this.index
    });
       
    Color additionalColor = const Color.fromRGBO(248, 248, 248, 1);
    Color textColor = const Color.fromRGBO(68, 68,68, 1);
    String index;

    ScrollController _controller = ScrollController();

    dynamic order ='';
    dynamic dishesQuery;
    dynamic phoneNumber = '';
    @override
    void initState(){
      getData();
      super.initState();    
  }

  void getData() async{
      final ref = FirebaseDatabase.instance.ref('Orders/$index');

      Stream<DatabaseEvent> stream = ref.onValue;
      stream.listen((DatabaseEvent event) {
        setState(() {
          order = jsonDecode(jsonEncode(event.snapshot.value)) as Map<String, dynamic>;
        });
      });
      setState(() {
        dishesQuery = FirebaseDatabase.instance.ref('Orders/$index/dishes');
    });

    final secondRef = FirebaseDatabase.instance.ref('About');

      Stream<DatabaseEvent> secondStream = secondRef.onValue;
      secondStream.listen((DatabaseEvent event) {
        setState(() {
          phoneNumber = jsonDecode(jsonEncode(event.snapshot.value)) as Map<String, dynamic>;
        });
      });
  }

       
    @override
    Widget build(BuildContext context) {
      return Scaffold(
                  backgroundColor: additionalColor,
                  body: Column(
        children: [
          Container(
                    height: MediaQuery.of(context).size.height* 0.65,
                    width: MediaQuery.of(context).size.width,
                    decoration: const BoxDecoration(
                      color: Color.fromRGBO(245, 245, 245, 1),
                      borderRadius: BorderRadius.all(Radius.circular(30)),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                          Container(
                            alignment: Alignment.center,
                            margin: EdgeInsets.only(left: MediaQuery.of(context).size.width* 0.23,
                                                    top: MediaQuery.of(context).size.height* 0.02),
                            width: MediaQuery.of(context).size.width* 0.5,
                            height: MediaQuery.of(context).size.height* 0.04,
                            child: AutoSizeText("Замовлення №${order["number"]}", 
                              stepGranularity: 1,
                              minFontSize: 12,
                              style: GoogleFonts.montserrat(
                                    textStyle: const TextStyle(
                                    color: Color.fromRGBO(31, 31, 47, 1),
                                    fontSize: 16,
                                    fontWeight: FontWeight.w500)))
                                    ),
                          GestureDetector(
                            onTap:() {
                              Navigator.pop(context);
                            },
                            child: Container(
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                color: const Color.fromRGBO(252, 252, 252, 1),
                                borderRadius: const BorderRadius.all(Radius.circular(10)),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey.withOpacity(0.5),
                                    spreadRadius: 1,
                                    blurRadius: 5,
                                    offset: const Offset(0, 5), 
                                  ),
                                ],
                              ),
                              margin: EdgeInsets.only(left: MediaQuery.of(context).size.width* 0.09,
                                                      top: MediaQuery.of(context).size.height* 0.02),
                              width: MediaQuery.of(context).size.width* 0.1,
                              height: MediaQuery.of(context).size.width* 0.1,
                              child: const Icon(Icons.close_rounded, size: 30, color: Color.fromRGBO(31, 31, 47, 1),)
                        ))
                        ],),
                          SizedBox(
                              height: MediaQuery.of(context).size.height*0.43,
                              width: MediaQuery.of(context).size.width* 0.9,
                              child: FirebaseDatabaseQueryBuilder(
                                  query: dishesQuery,
                                  builder: (context, snapshot, _) { 
                                  return ListView.separated(
                                      shrinkWrap: false,
                                      itemCount: snapshot.docs.length,
                                      separatorBuilder: (BuildContext context, int secondIndex) => SizedBox(height: MediaQuery.of(context).size.height* 0.015),
                                      itemBuilder: (BuildContext context, int secondIndex){
                                          if (snapshot.hasMore && secondIndex + 1 == snapshot.docs.length) {
                                                 snapshot.fetchMore();
                                                } 
                                          final dishes = jsonDecode(jsonEncode(snapshot.docs[secondIndex].value)) as Map<String, dynamic>;
                                          return  Container(
                                            height: MediaQuery.of(context).size.height* 0.12,
                                            decoration: const BoxDecoration(
                                              color: Color.fromRGBO(255, 255, 255, 1),
                                              borderRadius: BorderRadius.all(Radius.circular(25)),
                                            ),
                                            child: Row(
                                              mainAxisAlignment: MainAxisAlignment.start,
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                Container(
                                                  padding: EdgeInsets.all(MediaQuery.of(context).size.width* 0.03),
                                                  width: MediaQuery.of(context).size.height* 0.12,
                                                  height: MediaQuery.of(context).size.height* 0.12,
                                                  alignment: Alignment.center,
                                                  child: Image.asset(
                                                          dishes["image"],
                                                          width: MediaQuery.of(context).size.height* 0.12,
                                                          height: MediaQuery.of(context).size.height* 0.12,
                                                          fit: BoxFit.fill)
                                                          ),
                                                Column(
                                                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                                        crossAxisAlignment: CrossAxisAlignment.start,
                                                        children: [
                                                          Text(dishes["name"],
                                                              style: GoogleFonts.poiretOne(
                                                                          textStyle: const TextStyle(
                                                                          color: Color.fromRGBO(31, 31, 47, 1),
                                                                          fontSize: 20,
                                                                          fontWeight: FontWeight.w800))),
                                                          Row(
                                                            children: [
                                                              Container(
                                                              width: MediaQuery.of(context).size.width* 0.6,
                                                              margin: EdgeInsets.only(right: MediaQuery.of(context).size.width* 0.03),
                                                              child: Row(
                                                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                                crossAxisAlignment: CrossAxisAlignment.center,
                                                                children: [
                                                                  RichText(
                                                                  text: TextSpan(
                                                                  children: <TextSpan>[
                                                                      const TextSpan(text: "₴ ",                                                                 
                                                                      style: TextStyle(
                                                                        color: Color.fromRGBO(254, 182, 102, 1),
                                                                        fontSize: 18,
                                                                        fontWeight: FontWeight.w700)),
                                                                      TextSpan(text: " ${dishes["price"]*dishes["count"]}",                                                                  
                                                                          style: GoogleFonts.nunito(
                                                                            textStyle: const TextStyle(
                                                                            color: Color.fromRGBO(31, 31, 47, 1),
                                                                            fontSize: 20,
                                                                            fontWeight: FontWeight.w600))),
                                                                    ],)),
                                                                Text("x${dishes["count"]}",
                                                                  style: GoogleFonts.nunito(
                                                                              textStyle: const TextStyle(
                                                                              color: Color.fromRGBO(31, 31, 47, 1),
                                                                              fontSize: 20,
                                                                              fontWeight: FontWeight.w600))),
                                                          ],))
                                                          ]),
                                                        ],),
                                            ]),
                                          );
                                },
                              );})
                        ),
                        Container( 
                          padding: EdgeInsets.only(top: MediaQuery.of(context).size.height*0.01,
                                                    bottom: MediaQuery.of(context).size.height*0.01),
                          alignment: Alignment.center,
                          height: MediaQuery.of(context).size.height*0.15,
                          width: MediaQuery.of(context).size.width*0.9,
                          child:
                            Container(
                              padding: EdgeInsets.only(
                                                  left: MediaQuery.of(context).size.width*0.04,
                                                    right: MediaQuery.of(context).size.width*0.04),
                              height: MediaQuery.of(context).size.height*0.13,
                              decoration: DottedDecoration(shape: Shape.box,
                                                        borderRadius: BorderRadius.circular(25),),
                              child:Column(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Text("Сума:", 
                                        textAlign: TextAlign.center,
                                        style: GoogleFonts.montserrat(
                                          textStyle: const TextStyle(
                                          color: Color.fromRGBO(31, 31, 47, 1),
                                          fontSize: 18,
                                          fontWeight: FontWeight.w700))),     
                                    Text("${order["price"]}₴", 
                                        textAlign: TextAlign.center,
                                        style: GoogleFonts.montserrat(
                                          textStyle: const TextStyle(
                                          color: Color.fromRGBO(31, 31, 47, 1),
                                          fontSize: 14,
                                          fontWeight: FontWeight.w600))),
                                          ],),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Text("Адреса:", 
                                        textAlign: TextAlign.center,
                                        style: GoogleFonts.montserrat(
                                          textStyle: const TextStyle(
                                          color: Color.fromRGBO(31, 31, 47, 1),
                                          fontSize: 18,
                                          fontWeight: FontWeight.w700))),     
                                    Text("${order["address"]["street"]}, ${order["address"]["building"]}", 
                                        textAlign: TextAlign.center,
                                        style: GoogleFonts.montserrat(
                                          textStyle: const TextStyle(
                                          color: Color.fromRGBO(31, 31, 47, 1),
                                          fontSize: 14,
                                          fontWeight: FontWeight.w600))),
                                          ],),
                                  Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Text("Дата:", 
                                        textAlign: TextAlign.center,
                                        style: GoogleFonts.montserrat(
                                          textStyle: const TextStyle(
                                          color: Color.fromRGBO(31, 31, 47, 1),
                                          fontSize: 18,
                                          fontWeight: FontWeight.w700))),     
                                    Text(order["date"], 
                                        textAlign: TextAlign.center,
                                        style: GoogleFonts.montserrat(
                                          textStyle: const TextStyle(
                                          color: Color.fromRGBO(31, 31, 47, 1),
                                          fontSize: 14,
                                          fontWeight: FontWeight.w600))),
                                          ],),
                              ],
                            ))),    
                        ],)), 
                        statusOfProcessing(),             
        ]));
    }

    Widget statusOfProcessing(){
      if(order["status"] == "В процесі" || order["status"] == "Виконаний"){
      switch(order["statusOfProcessing"]){
        case 1:       _controller = ScrollController();
        WidgetsBinding.instance.addPostFrameCallback((_) {
          _controller.animateTo(
            _controller.position.maxScrollExtent,
            duration: const Duration(seconds: 1),
            curve: Curves.fastOutSlowIn,
          );
      });
      return  Container( 
              decoration: const BoxDecoration(color: Colors.red,
                borderRadius: BorderRadius.only(topLeft: Radius.circular(30),
                                                                            topRight: Radius.circular(30))), 
              height: MediaQuery.of(context).size.height*0.35,
              child: SingleChildScrollView(
                controller: _controller,
                child: 
                  Container(
                  padding: EdgeInsets.only(left: MediaQuery.of(context).size.width*0.03,
                                                                right: MediaQuery.of(context).size.width*0.01),
                  decoration: const BoxDecoration(borderRadius: BorderRadius.only(topLeft: Radius.circular(30),
                                                                            topRight: Radius.circular(30)), 
                                            color: Color.fromRGBO(255, 255, 255, 1)),
                  width: MediaQuery.of(context).size.width*0.9,
                  height: MediaQuery.of(context).size.height*0.53,
                  child: 
              Row(
                children: [
                Stack(
                  alignment: Alignment.topCenter,
                  children: [
                    Container(
                      margin: EdgeInsets.only(top: MediaQuery.of(context).size.height*0.01),
                      color: Colors.black,
                      height: MediaQuery.of(context).size.height*0.4,
                      width: MediaQuery.of(context).size.width*0.0025,
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                          margin: EdgeInsets.only(top: MediaQuery.of(context).size.height*0.01),
                              width: MediaQuery.of(context).size.width*0.13,
                              height: MediaQuery.of(context).size.height*0.06,
                              decoration: BoxDecoration(borderRadius: BorderRadius.circular(100), 
                                              color: const Color.fromRGBO(222, 222, 222, 1)),
                              child: const Icon(Icons.check, size: 28)),
                          Container(
                              margin: EdgeInsets.only(top: MediaQuery.of(context).size.height*0.03),
                              width: MediaQuery.of(context).size.width*0.13,
                              height: MediaQuery.of(context).size.height*0.06,
                              decoration: BoxDecoration(borderRadius: BorderRadius.circular(100), 
                                              color: const Color.fromRGBO(222, 222, 222, 1)),
                              child: const Icon(Icons.delivery_dining_outlined, size: 28)),
                         Container(
                          margin: EdgeInsets.only(top: MediaQuery.of(context).size.height*0.03),
                          width: MediaQuery.of(context).size.width*0.13,
                          height: MediaQuery.of(context).size.height*0.06,
                          decoration: BoxDecoration(borderRadius: BorderRadius.circular(100), 
                                          color: const Color.fromRGBO(222, 222, 222, 1)),
                          child: const Icon(Icons.shopping_bag, size: 25)),
                         Container(
                          margin: EdgeInsets.only(top: MediaQuery.of(context).size.height*0.03),
                          width: MediaQuery.of(context).size.width*0.13,
                          height: MediaQuery.of(context).size.height*0.06,
                          decoration: BoxDecoration(borderRadius: BorderRadius.circular(100), 
                                          color: const Color.fromRGBO(222, 222, 222, 1)),
                          child: const Icon(Icons.restaurant_rounded, size: 25)),
                         Container(
                          margin: EdgeInsets.only(top: MediaQuery.of(context).size.height*0.03),
                          width: MediaQuery.of(context).size.width*0.15,
                          height: MediaQuery.of(context).size.height*0.07,
                          decoration: BoxDecoration(borderRadius: BorderRadius.circular(100), 
                                          boxShadow: const [
                                                BoxShadow(
                                                  color: Color.fromRGBO(254, 182, 102, 0.7),
                                                  spreadRadius: 7,
                                                  blurRadius: 0,
                                                  offset: Offset(0, 0), 
                                                ),
                                              ],
                                          color: const Color.fromRGBO(254, 182, 102, 1)),
                          child: const Icon(Icons.timer, size: 28)),
                      ],
                    )
                  ],
                ),
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container( 
                    margin: EdgeInsets.only(top: MediaQuery.of(context).size.height*0.01),
                    height: MediaQuery.of(context).size.height*0.06,
                    child:Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [ 
                        Container(
                          width: MediaQuery.of(context).size.width*0.49,
                          margin: EdgeInsets.only(left:  MediaQuery.of(context).size.width*0.05),
                          child: Text("Виконано", style: GoogleFonts.poiretOne(
                                                                            textStyle: TextStyle(
                                                                            color: textColor,
                                                                            fontSize: 18,
                                                                            decoration: TextDecoration.none,
                                                                            fontWeight: FontWeight.w800)))),                                                 
                  ],)),
                  Container(
                    margin: EdgeInsets.only(top: MediaQuery.of(context).size.height*0.03),
                    height: MediaQuery.of(context).size.height*0.06,
                    child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                        Container(
                          width: MediaQuery.of(context).size.width*0.49,
                          margin: EdgeInsets.only(left:  MediaQuery.of(context).size.width*0.05),
                          child: Text("У дорозі", style: GoogleFonts.poiretOne(
                                                                            textStyle: TextStyle(
                                                                            color: textColor,
                                                                            fontSize: 18,
                                                                            decoration: TextDecoration.none,
                                                                            fontWeight: FontWeight.w800)))),                                                  
                  ],)),
                  Container(
                    margin: EdgeInsets.only(top: MediaQuery.of(context).size.height*0.03),
                    height: MediaQuery.of(context).size.height*0.06,
                    child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                        Container(
                          width: MediaQuery.of(context).size.width*0.49,
                          margin: EdgeInsets.only(left:  MediaQuery.of(context).size.width*0.05),
                          child: Text("Пакується", style: GoogleFonts.poiretOne(
                                                                            textStyle: TextStyle(
                                                                            color: textColor,
                                                                            fontSize: 18,
                                                                            decoration: TextDecoration.none,
                                                                            fontWeight: FontWeight.w800)))),                                                 
                  ],)),
                  Container(
                    margin: EdgeInsets.only(top: MediaQuery.of(context).size.height*0.03), 
                    height: MediaQuery.of(context).size.height*0.06,
                    child:Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                        Container(
                          width: MediaQuery.of(context).size.width*0.49,
                          margin: EdgeInsets.only(left:  MediaQuery.of(context).size.width*0.05),
                          child: Text("Готується", style: GoogleFonts.poiretOne(
                                                                            textStyle: TextStyle(
                                                                            color: textColor,
                                                                            fontSize: 18,
                                                                            decoration: TextDecoration.none,
                                                                            fontWeight: FontWeight.w800)))),                                                  
                  ],)),
                  Container(
                    margin: EdgeInsets.only(top: MediaQuery.of(context).size.height*0.03),
                    alignment: Alignment.bottomCenter,
                    height: MediaQuery.of(context).size.height*0.16,
                    child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                        Container(
                          width: MediaQuery.of(context).size.width*0.49,
                          margin: EdgeInsets.only(top: MediaQuery.of(context).size.height*0.018, left:  MediaQuery.of(context).size.width*0.05),
                          child: Text("Оброблюється", style: GoogleFonts.poiretOne(
                                                                            textStyle: TextStyle(
                                                                            color: textColor,
                                                                            fontSize: 18,
                                                                            decoration: TextDecoration.none,
                                                                            fontWeight: FontWeight.w800)))),                                                 
                        Container(
                                alignment: Alignment.centerRight,
                                width: MediaQuery.of(context).size.width*0.15,
                                child: Text(order["timeOfFirstProcess"], style: GoogleFonts.poiretOne(
                                                                                  textStyle: const TextStyle(
                                                                                  color: Color.fromRGBO(254, 182, 102, 1),
                                                                                  fontSize: 14,
                                                                                  decoration: TextDecoration.none,
                                                                                  fontWeight: FontWeight.w800)))), 
                  ],),
                  Container(
                    margin: EdgeInsets.only(top: MediaQuery.of(context).size.height*0.01),
                    alignment: Alignment.centerLeft,
                    decoration: BoxDecoration(borderRadius: BorderRadius.circular(15), 
                                                color: const Color.fromRGBO(240, 240, 240, 1)),
                    width: MediaQuery.of(context).size.width*0.64,
                    height: MediaQuery.of(context).size.height*0.08,
                    child: Row(
                                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                              crossAxisAlignment: CrossAxisAlignment.center,
                                              children: [
                                                Column(
                                                        mainAxisAlignment: MainAxisAlignment.center,
                                                        crossAxisAlignment: CrossAxisAlignment.start,
                                                        children: [
                                                          Text("Зателефонувати",
                                                              style: GoogleFonts.poiretOne(
                                                                          textStyle: TextStyle(
                                                                          color: textColor,
                                                                          fontSize: 16,
                                                                          fontWeight: FontWeight.w700))),
                                                          Text("Адміністратору",
                                                              style: GoogleFonts.rubik(
                                                                          textStyle: TextStyle(
                                                                          color: textColor  ,
                                                                          fontSize: 18,
                                                                          fontWeight: FontWeight.w500))),   
                                                        ],),
                                                GestureDetector( 
                                                  onTap: () {
                                                    _makePhoneCall("+${phoneNumber["number"]}");
                                                  },
                                                  child: Container(
                                                    decoration: const BoxDecoration(color: Color.fromRGBO(254, 182, 102, 1),
                                                    borderRadius: BorderRadius.all(Radius.circular(15)),),
                                                    width: MediaQuery.of(context).size.width* 0.13,
                                                    height: MediaQuery.of(context).size.width* 0.11,
                                                    alignment: Alignment.center,
                                                    child: const Icon(Icons.phone, size: 25))),
                                            ])
                  )
                  
                  ])),
                ])])
            )));
        case 2:    _controller = ScrollController();
        WidgetsBinding.instance.addPostFrameCallback((_) {
          _controller.animateTo(
            _controller.position.maxScrollExtent,
            duration: const Duration(seconds: 1),
            curve: Curves.fastOutSlowIn,
          );
      });
      return 
              SizedBox( 
              height: MediaQuery.of(context).size.height*0.35,
              child: SingleChildScrollView(
                controller: _controller,
                child: 
                  Container(
                  padding: EdgeInsets.only(left: MediaQuery.of(context).size.width*0.05,
                                                                right: MediaQuery.of(context).size.width*0.07),
                  decoration: BoxDecoration(borderRadius: BorderRadius.circular(30), 
                                            color: const Color.fromRGBO(255, 255, 255, 1)),
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height*0.45,
                  child: 
              Row(children: [
                Stack(
                  alignment: Alignment.topCenter,
                  children: [
                    Container(
                      margin: EdgeInsets.only(top: MediaQuery.of(context).size.height*0.01),
                      color: Colors.black,
                      height: MediaQuery.of(context).size.height*0.4,
                      width: MediaQuery.of(context).size.width*0.0025,
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                          margin: EdgeInsets.only(top: MediaQuery.of(context).size.height*0.01),
                              width: MediaQuery.of(context).size.width*0.13,
                              height: MediaQuery.of(context).size.height*0.06,
                              decoration: BoxDecoration(borderRadius: BorderRadius.circular(100), 
                                              color: const Color.fromRGBO(222, 222, 222, 1)),
                              child: const Icon(Icons.check, size: 28)),
                          Container(
                              margin: EdgeInsets.only(top: MediaQuery.of(context).size.height*0.03),
                              width: MediaQuery.of(context).size.width*0.13,
                              height: MediaQuery.of(context).size.height*0.06,
                              decoration: BoxDecoration(borderRadius: BorderRadius.circular(100), 
                                              color: const Color.fromRGBO(222, 222, 222, 1)),
                              child: const Icon(Icons.delivery_dining_outlined, size: 28)),
                         Container(
                          margin: EdgeInsets.only(top: MediaQuery.of(context).size.height*0.03),
                          width: MediaQuery.of(context).size.width*0.13,
                          height: MediaQuery.of(context).size.height*0.06,
                          decoration: BoxDecoration(borderRadius: BorderRadius.circular(100), 
                                          color: const Color.fromRGBO(222, 222, 222, 1)),
                          child: const Icon(Icons.restaurant_rounded, size: 25)),
                         Container(
                          margin: EdgeInsets.only(top: MediaQuery.of(context).size.height*0.03),
                          width: MediaQuery.of(context).size.width*0.15,
                          height: MediaQuery.of(context).size.height*0.07,
                          decoration: BoxDecoration(borderRadius: BorderRadius.circular(100), 
                                          boxShadow: const [
                                                BoxShadow(
                                                  color: Color.fromRGBO(254, 182, 102, 0.7),
                                                  spreadRadius: 7,
                                                  blurRadius: 0,
                                                  offset: Offset(0, 0), 
                                                ),
                                              ],
                                          color: const Color.fromRGBO(254, 182, 102, 1)),
                          child: const Icon(Icons.shopping_bag, size: 28)),
                         Container(
                          margin: EdgeInsets.only(top: MediaQuery.of(context).size.height*0.03),
                          width: MediaQuery.of(context).size.width*0.13,
                          height: MediaQuery.of(context).size.height*0.06,
                          decoration: BoxDecoration(borderRadius: BorderRadius.circular(100), 
                                          color: const Color.fromRGBO(222, 222, 222, 1)),
                          child: const Icon(Icons.timer, size: 25)),
                      ],
                    )
                  ],
                ),
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container( 
                    margin: EdgeInsets.only(top: MediaQuery.of(context).size.height*0.01),
                    height: MediaQuery.of(context).size.height*0.06,
                    child:Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [ 
                        Container(
                          width: MediaQuery.of(context).size.width*0.49,
                          margin: EdgeInsets.only(left:  MediaQuery.of(context).size.width*0.05),
                          child: Text("Виконано", style: GoogleFonts.poiretOne(
                                                                            textStyle: TextStyle(
                                                                            color: textColor,
                                                                            fontSize: 18,
                                                                            decoration: TextDecoration.none,
                                                                            fontWeight: FontWeight.w800)))),                                                 
                  ],)),
                  Container(
                    margin: EdgeInsets.only(top: MediaQuery.of(context).size.height*0.03),
                    height: MediaQuery.of(context).size.height*0.06,
                    child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                        Container(
                          width: MediaQuery.of(context).size.width*0.49,
                          margin: EdgeInsets.only(left:  MediaQuery.of(context).size.width*0.05),
                          child: Text("У дорозі", style: GoogleFonts.poiretOne(
                                                                            textStyle: TextStyle(
                                                                            color: textColor,
                                                                            fontSize: 18,
                                                                            decoration: TextDecoration.none,
                                                                            fontWeight: FontWeight.w800)))),                                                  
                  ],)),
                  Container(
                    margin: EdgeInsets.only(top: MediaQuery.of(context).size.height*0.03),
                    height: MediaQuery.of(context).size.height*0.06,
                    child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                        Container(
                          width: MediaQuery.of(context).size.width*0.49,
                          margin: EdgeInsets.only(left:  MediaQuery.of(context).size.width*0.05),
                          child: Text("Пакується", style: GoogleFonts.poiretOne(
                                                                            textStyle: TextStyle(
                                                                            color: textColor,
                                                                            fontSize: 18,
                                                                            decoration: TextDecoration.none,
                                                                            fontWeight: FontWeight.w800)))),                                                 
                  ],)),
                  Container(
                    margin: EdgeInsets.only(top: MediaQuery.of(context).size.height*0.035), 
                    height: MediaQuery.of(context).size.height*0.06,
                    child:Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
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
                                child: Text(order["timeOfSecondProcess"], style: GoogleFonts.poiretOne(
                                                                                  textStyle: const TextStyle(
                                                                                  color: Color.fromRGBO(254, 182, 102, 1),
                                                                                  fontSize: 14,
                                                                                  decoration: TextDecoration.none,
                                                                                  fontWeight: FontWeight.w800)))), 
                  ],)),
                  Container(
                    margin: EdgeInsets.only(top: MediaQuery.of(context).size.height*0.035),
                    height: MediaQuery.of(context).size.height*0.06,
                    child:Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
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
                                child: Text(order["timeOfFirstProcess"], style: GoogleFonts.poiretOne(
                                                                                  textStyle: const TextStyle(
                                                                                  color: Color.fromRGBO(254, 182, 102, 1),
                                                                                  fontSize: 14,
                                                                                  decoration: TextDecoration.none,
                                                                                  fontWeight: FontWeight.w800)))), 
                  ],)),
                ])])
            )));
        case 3:   return SizedBox( 
              height: MediaQuery.of(context).size.height*0.35,
              child: SingleChildScrollView(
                child: 
                  Container(
                  padding: EdgeInsets.only(left: MediaQuery.of(context).size.width*0.05,
                                                                right: MediaQuery.of(context).size.width*0.07),
                  decoration: BoxDecoration(borderRadius: BorderRadius.circular(30), 
                                            color: const Color.fromRGBO(255, 255, 255, 1)),
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height*0.45,
                  child: 
              Row(children: [
                Stack(
                  alignment: Alignment.topCenter,
                  children: [
                    Container(
                      margin: EdgeInsets.only(top: MediaQuery.of(context).size.height*0.01),
                      color: Colors.black,
                      height: MediaQuery.of(context).size.height*0.4,
                      width: MediaQuery.of(context).size.width*0.0025,
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                          margin: EdgeInsets.only(top: MediaQuery.of(context).size.height*0.01),
                              width: MediaQuery.of(context).size.width*0.13,
                              height: MediaQuery.of(context).size.height*0.06,
                              decoration: BoxDecoration(borderRadius: BorderRadius.circular(100), 
                                              color: const Color.fromRGBO(222, 222, 222, 1)),
                              child: const Icon(Icons.check, size: 28)),
                          Container(
                              margin: EdgeInsets.only(top: MediaQuery.of(context).size.height*0.03),
                              width: MediaQuery.of(context).size.width*0.13,
                              height: MediaQuery.of(context).size.height*0.06,
                              decoration: BoxDecoration(borderRadius: BorderRadius.circular(100), 
                                              color: const Color.fromRGBO(222, 222, 222, 1)),
                              child: const Icon(Icons.delivery_dining_outlined, size: 28)),
                         Container(
                          margin: EdgeInsets.only(top: MediaQuery.of(context).size.height*0.03),
                          width: MediaQuery.of(context).size.width*0.15,
                          height: MediaQuery.of(context).size.height*0.07,
                          decoration: BoxDecoration(borderRadius: BorderRadius.circular(100), 
                                          boxShadow: const [
                                                BoxShadow(
                                                  color: Color.fromRGBO(254, 182, 102, 0.7),
                                                  spreadRadius: 7,
                                                  blurRadius: 0,
                                                  offset: Offset(0, 0), 
                                                ),
                                              ],
                                          color: const Color.fromRGBO(254, 182, 102, 1)),
                          child: const Icon(Icons.shopping_bag, size: 28)),
                         Container(
                          margin: EdgeInsets.only(top: MediaQuery.of(context).size.height*0.03),
                          width: MediaQuery.of(context).size.width*0.13,
                          height: MediaQuery.of(context).size.height*0.06,
                          decoration: BoxDecoration(borderRadius: BorderRadius.circular(100), 
                                          color: const Color.fromRGBO(222, 222, 222, 1)),
                          child: const Icon(Icons.restaurant_rounded, size: 24)),
                         Container(
                          margin: EdgeInsets.only(top: MediaQuery.of(context).size.height*0.03),
                          width: MediaQuery.of(context).size.width*0.13,
                          height: MediaQuery.of(context).size.height*0.06,
                          decoration: BoxDecoration(borderRadius: BorderRadius.circular(100), 
                                          color: const Color.fromRGBO(222, 222, 222, 1)),
                          child: const Icon(Icons.timer, size: 25)),
                      ],
                    )
                  ],
                ),
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container( 
                    margin: EdgeInsets.only(top: MediaQuery.of(context).size.height*0.01),
                    height: MediaQuery.of(context).size.height*0.06,
                    child:Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [ 
                        Container(
                          width: MediaQuery.of(context).size.width*0.49,
                          margin: EdgeInsets.only(left:  MediaQuery.of(context).size.width*0.05),
                          child: Text("Виконано", style: GoogleFonts.poiretOne(
                                                                            textStyle: TextStyle(
                                                                            color: textColor,
                                                                            fontSize: 18,
                                                                            decoration: TextDecoration.none,
                                                                            fontWeight: FontWeight.w800)))),                                                 
                  ],)),
                  Container(
                    margin: EdgeInsets.only(top: MediaQuery.of(context).size.height*0.03),
                    height: MediaQuery.of(context).size.height*0.06,
                    child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                        Container(
                          width: MediaQuery.of(context).size.width*0.49,
                          margin: EdgeInsets.only(left:  MediaQuery.of(context).size.width*0.05),
                          child: Text("У дорозі", style: GoogleFonts.poiretOne(
                                                                            textStyle: TextStyle(
                                                                            color: textColor,
                                                                            fontSize: 18,
                                                                            decoration: TextDecoration.none,
                                                                            fontWeight: FontWeight.w800)))),                                                  
                  ],)),
                  Container(
                    margin: EdgeInsets.only(top: MediaQuery.of(context).size.height*0.03),
                    height: MediaQuery.of(context).size.height*0.06,
                    child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
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
                                child: Text(order["timeOfThirdProcess"], style: GoogleFonts.poiretOne(
                                                                                  textStyle: const TextStyle(
                                                                                  color: Color.fromRGBO(254, 182, 102, 1),
                                                                                  fontSize: 14,
                                                                                  decoration: TextDecoration.none,
                                                                                  fontWeight: FontWeight.w800)))), 
                  ],)),
                  Container(
                    margin: EdgeInsets.only(top: MediaQuery.of(context).size.height*0.03), 
                    height: MediaQuery.of(context).size.height*0.06,
                    child:Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
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
                                child: Text(order["timeOfSecondProcess"], style: GoogleFonts.poiretOne(
                                                                                  textStyle: const TextStyle(
                                                                                  color: Color.fromRGBO(254, 182, 102, 1),
                                                                                  fontSize: 14,
                                                                                  decoration: TextDecoration.none,
                                                                                  fontWeight: FontWeight.w800)))), 
                  ],)),
                  Container(
                    margin: EdgeInsets.only(top: MediaQuery.of(context).size.height*0.035),
                    height: MediaQuery.of(context).size.height*0.06,
                    child:Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
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
                                child: Text(order["timeOfFirstProcess"], style: GoogleFonts.poiretOne(
                                                                                  textStyle: const TextStyle(
                                                                                  color: Color.fromRGBO(254, 182, 102, 1),
                                                                                  fontSize: 14,
                                                                                  decoration: TextDecoration.none,
                                                                                  fontWeight: FontWeight.w800)))), 
                  ],)),
                ])])
            )));
        case 4: return 
              SizedBox( 
              height: MediaQuery.of(context).size.height*0.35,
              child: SingleChildScrollView(
                child: 
                  Container(
                  padding: EdgeInsets.only(left: MediaQuery.of(context).size.width*0.05,
                                                                right: MediaQuery.of(context).size.width*0.07),
                  decoration: BoxDecoration(borderRadius: BorderRadius.circular(30), 
                                            color: const Color.fromRGBO(255, 255, 255, 1)),
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height*0.53,
                  child: 
              Row(children: [
                Stack(
                  alignment: Alignment.center,
                  children: [
                    Container(
                      color: Colors.black,
                      height: MediaQuery.of(context).size.height*0.45,
                      width: MediaQuery.of(context).size.width*0.0025,
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                          margin: EdgeInsets.only(top: MediaQuery.of(context).size.height*0.01),
                          width: MediaQuery.of(context).size.width*0.13,
                          height: MediaQuery.of(context).size.height*0.06,
                          decoration: BoxDecoration(borderRadius: BorderRadius.circular(100), 
                                          color: const Color.fromRGBO(222, 222, 222, 1)),
                          child: const Icon(Icons.check, size: 25)),
                          Container(
                              margin: EdgeInsets.only(top: MediaQuery.of(context).size.height*0.03),
                              width: MediaQuery.of(context).size.width*0.15,
                              height: MediaQuery.of(context).size.height*0.07,
                              decoration: BoxDecoration(borderRadius: BorderRadius.circular(100), 
                                              boxShadow: const [
                                                BoxShadow(
                                                  color: Color.fromRGBO(254, 182, 102, 0.7),
                                                  spreadRadius: 7,
                                                  blurRadius: 0,
                                                  offset: Offset(0, 0), 
                                                ),
                                              ],
                                              color: const Color.fromRGBO(254, 182, 102, 1)),
                              child: const Icon(Icons.delivery_dining_outlined, size: 28)),
                         Container(
                          margin: EdgeInsets.only(top: MediaQuery.of(context).size.height*0.11),
                          width: MediaQuery.of(context).size.width*0.13,
                          height: MediaQuery.of(context).size.height*0.06,
                          decoration: BoxDecoration(borderRadius: BorderRadius.circular(100), 
                                          color: const Color.fromRGBO(254, 182, 102, 1)),
                          child: const Icon(Icons.shopping_bag, size: 25)),
                         Container(
                          margin: EdgeInsets.only(top: MediaQuery.of(context).size.height*0.03),
                          width: MediaQuery.of(context).size.width*0.13,
                          height: MediaQuery.of(context).size.height*0.06,
                          decoration: BoxDecoration(borderRadius: BorderRadius.circular(100), 
                                          color: const Color.fromRGBO(254, 182, 102, 1)),
                          child: const Icon(Icons.restaurant_rounded, size: 24)),
                         Container(
                          margin: EdgeInsets.only(top: MediaQuery.of(context).size.height*0.03),
                          width: MediaQuery.of(context).size.width*0.13,
                          height: MediaQuery.of(context).size.height*0.06,
                          decoration: BoxDecoration(borderRadius: BorderRadius.circular(100), 
                                          color: const Color.fromRGBO(254, 182, 102, 1)),
                          child: const Icon(Icons.timer, size: 25)),
                      ],
                    )
                  ],
                ),
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container( 
                    margin: EdgeInsets.only(top: MediaQuery.of(context).size.height*0.01),
                    height: MediaQuery.of(context).size.height*0.06,
                    child:Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [ 
                        Container(
                          width: MediaQuery.of(context).size.width*0.49,
                          margin: EdgeInsets.only(left:  MediaQuery.of(context).size.width*0.05),
                          child: Text("Виконано", style: GoogleFonts.poiretOne(
                                                                            textStyle: TextStyle(
                                                                            color: textColor,
                                                                            fontSize: 18,
                                                                            decoration: TextDecoration.none,
                                                                            fontWeight: FontWeight.w800)))),                                                 
                  ],)),
                  Container(
                    margin: EdgeInsets.only(top: MediaQuery.of(context).size.height*0.03),
                    alignment: Alignment.bottomCenter,
                    height: MediaQuery.of(context).size.height*0.18,
                    child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                        Container(
                          width: MediaQuery.of(context).size.width*0.49,
                          margin: EdgeInsets.only(top: MediaQuery.of(context).size.height*0.018, left:  MediaQuery.of(context).size.width*0.05),
                          child: Text("У дорозі", style: GoogleFonts.poiretOne(
                                                                            textStyle: TextStyle(
                                                                            color: textColor,
                                                                            fontSize: 18,
                                                                            decoration: TextDecoration.none,
                                                                            fontWeight: FontWeight.w800)))),                                                 
                        Container(
                                alignment: Alignment.centerRight,
                                width: MediaQuery.of(context).size.width*0.15,
                                child: Text(order["timeOfFourthProcess"], style: GoogleFonts.poiretOne(
                                                                                  textStyle: const TextStyle(
                                                                                  color: Color.fromRGBO(254, 182, 102, 1),
                                                                                  fontSize: 14,
                                                                                  decoration: TextDecoration.none,
                                                                                  fontWeight: FontWeight.w800)))), 
                  ],),
                  Container(
                    margin: EdgeInsets.only(top: MediaQuery.of(context).size.height*0.03),
                    alignment: Alignment.centerLeft,
                    decoration: BoxDecoration(borderRadius: BorderRadius.circular(15), 
                                                color: const Color.fromRGBO(240, 240, 240, 1)),
                    width: MediaQuery.of(context).size.width*0.64,
                    height: MediaQuery.of(context).size.height*0.08,
                    child: Row(
                                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                              crossAxisAlignment: CrossAxisAlignment.center,
                                              children: [
                                                Container(
                                                  width: MediaQuery.of(context).size.width* 0.1,
                                                  height: MediaQuery.of(context).size.width* 0.1,
                                                  alignment: Alignment.center,
                                                  child: ClipRRect(
                                                        borderRadius: const BorderRadius.all(Radius.circular(100)),
                                                        child:Image.asset(
                                                          width: MediaQuery.of(context).size.width* 0.1,
                                                          height: MediaQuery.of(context).size.width* 0.1,
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
                                                          Text(order["courier"]["name"],
                                                              style: GoogleFonts.rubik(
                                                                          textStyle: TextStyle(
                                                                          color: textColor  ,
                                                                          fontSize: 18,
                                                                          fontWeight: FontWeight.w500))),   
                                                        ],),
                                                GestureDetector( 
                                                  onTap: () {
                                                    _makePhoneCall("+${order["courier"]["number"]}");
                                                  },
                                                  child: Container(
                                                  decoration: const BoxDecoration(color: Color.fromRGBO(254, 182, 102, 1),
                                                    borderRadius: BorderRadius.all(Radius.circular(15)),),
                                                  width: MediaQuery.of(context).size.width* 0.13,
                                                  height: MediaQuery.of(context).size.width* 0.11,
                                                  alignment: Alignment.center,
                                                  child: const Icon(Icons.phone, size: 25))),
                                            ])
                  )
                  
                  ])),
                  SizedBox(
                    height: MediaQuery.of(context).size.height*0.06,
                    child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
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
                                child: Text(order["timeOfThirdProcess"], style: GoogleFonts.poiretOne(
                                                                                  textStyle: const TextStyle(
                                                                                  color: Color.fromRGBO(254, 182, 102, 1),
                                                                                  fontSize: 14,
                                                                                  decoration: TextDecoration.none,
                                                                                  fontWeight: FontWeight.w800)))), 
                  ],)),
                  Container(
                    margin: EdgeInsets.only(top: MediaQuery.of(context).size.height*0.03), 
                    height: MediaQuery.of(context).size.height*0.06,
                    child:Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
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
                                child: Text(order["timeOfSecondProcess"], style: GoogleFonts.poiretOne(
                                                                                  textStyle: const TextStyle(
                                                                                  color: Color.fromRGBO(254, 182, 102, 1),
                                                                                  fontSize: 14,
                                                                                  decoration: TextDecoration.none,
                                                                                  fontWeight: FontWeight.w800)))), 
                  ],)),
                  Container(
                    margin: EdgeInsets.only(top: MediaQuery.of(context).size.height*0.03),
                    height: MediaQuery.of(context).size.height*0.06,
                    child:Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
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
                                child: Text(order["timeOfFirstProcess"], style: GoogleFonts.poiretOne(
                                                                                  textStyle: const TextStyle(
                                                                                  color: Color.fromRGBO(254, 182, 102, 1),
                                                                                  fontSize: 14,
                                                                                  decoration: TextDecoration.none,
                                                                                  fontWeight: FontWeight.w800)))), 
                  ],)),
                ])])
            )));
        case 5: return 
              SizedBox( 
              height: MediaQuery.of(context).size.height*0.35,
              child: SingleChildScrollView(
                child: 
                  Container(
                  padding: EdgeInsets.only(left: MediaQuery.of(context).size.width*0.05,
                                                                right: MediaQuery.of(context).size.width*0.07),
                  decoration: BoxDecoration(borderRadius: BorderRadius.circular(30), 
                                            color: const Color.fromRGBO(255, 255, 255, 1)),
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height*0.45,
                  child: 
              Row(children: [
                Stack(
                  alignment: Alignment.topCenter,
                  children: [
                    Container(
                      margin: EdgeInsets.only(top: MediaQuery.of(context).size.height*0.01),
                      color: Colors.black,
                      height: MediaQuery.of(context).size.height*0.4,
                      width: MediaQuery.of(context).size.width*0.0025,
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                          margin: EdgeInsets.only(top: MediaQuery.of(context).size.height*0.01),
                          width: MediaQuery.of(context).size.width*0.15,
                          height: MediaQuery.of(context).size.height*0.07,
                          decoration: BoxDecoration(borderRadius: BorderRadius.circular(100), 
                                          color: const Color.fromRGBO(254, 182, 102, 1)),
                          child: const Icon(Icons.check, size: 28)),
                          Container(
                              margin: EdgeInsets.only(top: MediaQuery.of(context).size.height*0.03),
                              width: MediaQuery.of(context).size.width*0.13,
                              height: MediaQuery.of(context).size.height*0.06,
                              decoration: BoxDecoration(borderRadius: BorderRadius.circular(100), 
                                              color: const Color.fromRGBO(222, 222, 222, 1)),
                              child: const Icon(Icons.delivery_dining_outlined, size: 28)),
                         Container(
                          margin: EdgeInsets.only(top: MediaQuery.of(context).size.height*0.03),
                          width: MediaQuery.of(context).size.width*0.13,
                          height: MediaQuery.of(context).size.height*0.06,
                          decoration: BoxDecoration(borderRadius: BorderRadius.circular(100), 
                                          color: const Color.fromRGBO(222, 222, 222, 1)),
                          child: const Icon(Icons.shopping_bag, size: 25)),
                         Container(
                          margin: EdgeInsets.only(top: MediaQuery.of(context).size.height*0.03),
                          width: MediaQuery.of(context).size.width*0.13,
                          height: MediaQuery.of(context).size.height*0.06,
                          decoration: BoxDecoration(borderRadius: BorderRadius.circular(100), 
                                          color: const Color.fromRGBO(222, 222, 222, 1)),
                          child: const Icon(Icons.restaurant_rounded, size: 24)),
                         Container(
                          margin: EdgeInsets.only(top: MediaQuery.of(context).size.height*0.03),
                          width: MediaQuery.of(context).size.width*0.13,
                          height: MediaQuery.of(context).size.height*0.06,
                          decoration: BoxDecoration(borderRadius: BorderRadius.circular(100), 
                                          color: const Color.fromRGBO(222, 222, 222, 1)),
                          child: const Icon(Icons.timer, size: 25)),
                      ],
                    )
                  ],
                ),
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container( 
                    margin: EdgeInsets.only(top: MediaQuery.of(context).size.height*0.015),
                    height: MediaQuery.of(context).size.height*0.06,
                    child:Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [ 
                        Container(
                          width: MediaQuery.of(context).size.width*0.49,
                          margin: EdgeInsets.only(left:  MediaQuery.of(context).size.width*0.05),
                          child: Text("Виконано", style: GoogleFonts.poiretOne(
                                                                            textStyle: TextStyle(
                                                                            color: textColor,
                                                                            fontSize: 18,
                                                                            decoration: TextDecoration.none,
                                                                            fontWeight: FontWeight.w800)))),   
                        Container(
                                alignment: Alignment.centerRight,
                                width: MediaQuery.of(context).size.width*0.15,
                                child: Text(order["timeOfFifthProcess"], style: GoogleFonts.poiretOne(
                                                                                  textStyle: const TextStyle(
                                                                                  color: Color.fromRGBO(254, 182, 102, 1),
                                                                                  fontSize: 14,
                                                                                  decoration: TextDecoration.none,
                                                                                  fontWeight: FontWeight.w800)))),                                               
                  ],)),
                  Container(
                    margin: EdgeInsets.only(top: MediaQuery.of(context).size.height*0.035),
                    height: MediaQuery.of(context).size.height*0.06,
                    child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
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
                                child: Text(order["timeOfFourthProcess"], style: GoogleFonts.poiretOne(
                                                                                  textStyle: const TextStyle(
                                                                                  color: Color.fromRGBO(254, 182, 102, 1),
                                                                                  fontSize: 14,
                                                                                  decoration: TextDecoration.none,
                                                                                  fontWeight: FontWeight.w800)))), 
                  ],)),
                  Container(
                    margin: EdgeInsets.only(top: MediaQuery.of(context).size.height*0.03),
                    height: MediaQuery.of(context).size.height*0.06,
                    child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
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
                                child: Text(order["timeOfThirdProcess"], style: GoogleFonts.poiretOne(
                                                                                  textStyle: const TextStyle(
                                                                                  color: Color.fromRGBO(254, 182, 102, 1),
                                                                                  fontSize: 14,
                                                                                  decoration: TextDecoration.none,
                                                                                  fontWeight: FontWeight.w800)))), 
                  ],)),
                  Container(
                    margin: EdgeInsets.only(top: MediaQuery.of(context).size.height*0.03), 
                    height: MediaQuery.of(context).size.height*0.06,
                    child:Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
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
                                child: Text(order["timeOfSecondProcess"], style: GoogleFonts.poiretOne(
                                                                                  textStyle: const TextStyle(
                                                                                  color: Color.fromRGBO(254, 182, 102, 1),
                                                                                  fontSize: 14,
                                                                                  decoration: TextDecoration.none,
                                                                                  fontWeight: FontWeight.w800)))), 
                  ],)),
                  Container(
                    margin: EdgeInsets.only(top: MediaQuery.of(context).size.height*0.03),
                    height: MediaQuery.of(context).size.height*0.06,
                    child:Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
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
                                child: Text(order["timeOfFirstProcess"], style: GoogleFonts.poiretOne(
                                                                                  textStyle: const TextStyle(
                                                                                  color: Color.fromRGBO(254, 182, 102, 1),
                                                                                  fontSize: 14,
                                                                                  decoration: TextDecoration.none,
                                                                                  fontWeight: FontWeight.w800)))), 
                  ],)),
                ])])
            )));
        default: return 
              SizedBox( 
              height: MediaQuery.of(context).size.height*0.35,
              child: SingleChildScrollView(
                controller: _controller,
                child: 
                  Container(
                  padding: EdgeInsets.only(left: MediaQuery.of(context).size.width*0.05,
                                                                right: MediaQuery.of(context).size.width*0.07),
                  decoration: BoxDecoration(borderRadius: BorderRadius.circular(30), 
                                            color: const Color.fromRGBO(255, 255, 255, 1)),
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height*0.45,
                  child: 
              Row(children: [
                Stack(
                  alignment: Alignment.topCenter,
                  children: [
                    Container(
                      margin: EdgeInsets.only(top: MediaQuery.of(context).size.height*0.01),
                      color: Colors.black,
                      height: MediaQuery.of(context).size.height*0.4,
                      width: MediaQuery.of(context).size.width*0.0025,
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                          margin: EdgeInsets.only(top: MediaQuery.of(context).size.height*0.01),
                              width: MediaQuery.of(context).size.width*0.13,
                              height: MediaQuery.of(context).size.height*0.06,
                              decoration: BoxDecoration(borderRadius: BorderRadius.circular(100), 
                                              color: const Color.fromRGBO(222, 222, 222, 1)),
                              child: const Icon(Icons.check, size: 28)),
                          Container(
                              margin: EdgeInsets.only(top: MediaQuery.of(context).size.height*0.03),
                              width: MediaQuery.of(context).size.width*0.13,
                              height: MediaQuery.of(context).size.height*0.06,
                              decoration: BoxDecoration(borderRadius: BorderRadius.circular(100), 
                                              color: const Color.fromRGBO(222, 222, 222, 1)),
                              child: const Icon(Icons.delivery_dining_outlined, size: 28)),
                         Container(
                          margin: EdgeInsets.only(top: MediaQuery.of(context).size.height*0.03),
                          width: MediaQuery.of(context).size.width*0.13,
                          height: MediaQuery.of(context).size.height*0.06,
                          decoration: BoxDecoration(borderRadius: BorderRadius.circular(100), 
                                          color: const Color.fromRGBO(222, 222, 222, 1)),
                          child: const Icon(Icons.shopping_bag, size: 25)),
                         Container(
                          margin: EdgeInsets.only(top: MediaQuery.of(context).size.height*0.03),
                          width: MediaQuery.of(context).size.width*0.15,
                          height: MediaQuery.of(context).size.height*0.07,
                          decoration: BoxDecoration(borderRadius: BorderRadius.circular(100), 
                                          boxShadow: const [
                                                BoxShadow(
                                                  color: Color.fromRGBO(254, 182, 102, 0.7),
                                                  spreadRadius: 7,
                                                  blurRadius: 0,
                                                  offset: Offset(0, 0), 
                                                ),
                                              ],
                                          color: const Color.fromRGBO(254, 182, 102, 1)),
                          child: const Icon(Icons.shopping_bag, size: 28)),
                         Container(
                          margin: EdgeInsets.only(top: MediaQuery.of(context).size.height*0.03),
                          width: MediaQuery.of(context).size.width*0.13,
                          height: MediaQuery.of(context).size.height*0.06,
                          decoration: BoxDecoration(borderRadius: BorderRadius.circular(100), 
                                          color: const Color.fromRGBO(222, 222, 222, 1)),
                          child: const Icon(Icons.timer, size: 25)),
                      ],
                    )
                  ],
                ),
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container( 
                    margin: EdgeInsets.only(top: MediaQuery.of(context).size.height*0.01),
                    height: MediaQuery.of(context).size.height*0.06,
                    child:Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [ 
                        Container(
                          width: MediaQuery.of(context).size.width*0.49,
                          margin: EdgeInsets.only(left:  MediaQuery.of(context).size.width*0.05),
                          child: Text("Виконано", style: GoogleFonts.poiretOne(
                                                                            textStyle: TextStyle(
                                                                            color: textColor,
                                                                            fontSize: 18,
                                                                            decoration: TextDecoration.none,
                                                                            fontWeight: FontWeight.w800)))),                                                 
                  ],)),
                  Container(
                    margin: EdgeInsets.only(top: MediaQuery.of(context).size.height*0.03),
                    height: MediaQuery.of(context).size.height*0.06,
                    child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                        Container(
                          width: MediaQuery.of(context).size.width*0.49,
                          margin: EdgeInsets.only(left:  MediaQuery.of(context).size.width*0.05),
                          child: Text("У дорозі", style: GoogleFonts.poiretOne(
                                                                            textStyle: TextStyle(
                                                                            color: textColor,
                                                                            fontSize: 18,
                                                                            decoration: TextDecoration.none,
                                                                            fontWeight: FontWeight.w800)))),                                                  
                  ],)),
                  Container(
                    margin: EdgeInsets.only(top: MediaQuery.of(context).size.height*0.03),
                    height: MediaQuery.of(context).size.height*0.06,
                    child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                        Container(
                          width: MediaQuery.of(context).size.width*0.49,
                          margin: EdgeInsets.only(left:  MediaQuery.of(context).size.width*0.05),
                          child: Text("Пакується", style: GoogleFonts.poiretOne(
                                                                            textStyle: TextStyle(
                                                                            color: textColor,
                                                                            fontSize: 18,
                                                                            decoration: TextDecoration.none,
                                                                            fontWeight: FontWeight.w800)))),                                                 
                  ],)),
                  Container(
                    margin: EdgeInsets.only(top: MediaQuery.of(context).size.height*0.03), 
                    height: MediaQuery.of(context).size.height*0.06,
                    child:Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
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
                  ],)),
                  Container(
                    margin: EdgeInsets.only(top: MediaQuery.of(context).size.height*0.03),
                    height: MediaQuery.of(context).size.height*0.06,
                    child:Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
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
                  ],)),
                ])])
            )));
      }
      }
      else{
        return Stack(children: [
              Blur(
                borderRadius: BorderRadius.circular(30),
                blur: 5,
                child: SizedBox( 
              height: MediaQuery.of(context).size.height*0.35,
              child: SingleChildScrollView(
                child: 
                  Container(
                  padding: EdgeInsets.only(left: MediaQuery.of(context).size.width*0.05,
                                                                right: MediaQuery.of(context).size.width*0.07),
                  decoration: BoxDecoration(borderRadius: BorderRadius.circular(30), 
                                            color: const Color.fromRGBO(255, 255, 255, 1)),
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height*0.45,
                  child: 
              Row(children: [
                Stack(
                  alignment: Alignment.topCenter,
                  children: [
                    Container(
                      margin: EdgeInsets.only(top: MediaQuery.of(context).size.height*0.01),
                      color: Colors.black,
                      height: MediaQuery.of(context).size.height*0.4,
                      width: MediaQuery.of(context).size.width*0.0025,
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                          margin: EdgeInsets.only(top: MediaQuery.of(context).size.height*0.01),
                          width: MediaQuery.of(context).size.width*0.15,
                          height: MediaQuery.of(context).size.height*0.07,
                          decoration: BoxDecoration(borderRadius: BorderRadius.circular(100), 
                                          color: const Color.fromRGBO(254, 182, 102, 1)),
                          child: const Icon(Icons.check, size: 28)),
                          Container(
                              margin: EdgeInsets.only(top: MediaQuery.of(context).size.height*0.03),
                              width: MediaQuery.of(context).size.width*0.13,
                              height: MediaQuery.of(context).size.height*0.06,
                              decoration: BoxDecoration(borderRadius: BorderRadius.circular(100), 
                                              color: const Color.fromRGBO(222, 222, 222, 1)),
                              child: const Icon(Icons.delivery_dining_outlined, size: 28)),
                         Container(
                          margin: EdgeInsets.only(top: MediaQuery.of(context).size.height*0.03),
                          width: MediaQuery.of(context).size.width*0.13,
                          height: MediaQuery.of(context).size.height*0.06,
                          decoration: BoxDecoration(borderRadius: BorderRadius.circular(100), 
                                          color: const Color.fromRGBO(222, 222, 222, 1)),
                          child: const Icon(Icons.shopping_bag, size: 25)),
                         Container(
                          margin: EdgeInsets.only(top: MediaQuery.of(context).size.height*0.03),
                          width: MediaQuery.of(context).size.width*0.13,
                          height: MediaQuery.of(context).size.height*0.06,
                          decoration: BoxDecoration(borderRadius: BorderRadius.circular(100), 
                                          color: const Color.fromRGBO(222, 222, 222, 1)),
                          child: const Icon(Icons.restaurant_rounded, size: 24)),
                         Container(
                          margin: EdgeInsets.only(top: MediaQuery.of(context).size.height*0.03),
                          width: MediaQuery.of(context).size.width*0.13,
                          height: MediaQuery.of(context).size.height*0.06,
                          decoration: BoxDecoration(borderRadius: BorderRadius.circular(100), 
                                          color: const Color.fromRGBO(222, 222, 222, 1)),
                          child: const Icon(Icons.timer, size: 25)),
                      ],
                    )
                  ],
                ),
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container( 
                    margin: EdgeInsets.only(top: MediaQuery.of(context).size.height*0.015),
                    height: MediaQuery.of(context).size.height*0.06,
                    child:Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [ 
                        Container(
                          width: MediaQuery.of(context).size.width*0.49,
                          margin: EdgeInsets.only(left:  MediaQuery.of(context).size.width*0.05),
                          child: Text("Виконано", style: GoogleFonts.poiretOne(
                                                                            textStyle: TextStyle(
                                                                            color: textColor,
                                                                            fontSize: 18,
                                                                            decoration: TextDecoration.none,
                                                                            fontWeight: FontWeight.w800)))),   
                        Container(
                                alignment: Alignment.centerRight,
                                width: MediaQuery.of(context).size.width*0.15,
                                child: Text("22:10", style: GoogleFonts.poiretOne(
                                                                                  textStyle: const TextStyle(
                                                                                  color: Color.fromRGBO(254, 182, 102, 1),
                                                                                  fontSize: 14,
                                                                                  decoration: TextDecoration.none,
                                                                                  fontWeight: FontWeight.w800)))),                                               
                  ],)),
                  Container(
                    margin: EdgeInsets.only(top: MediaQuery.of(context).size.height*0.035),
                    height: MediaQuery.of(context).size.height*0.06,
                    child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
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
                  ],)),
                  Container(
                    margin: EdgeInsets.only(top: MediaQuery.of(context).size.height*0.03),
                    height: MediaQuery.of(context).size.height*0.06,
                    child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
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
                  ],)),
                  Container(
                    margin: EdgeInsets.only(top: MediaQuery.of(context).size.height*0.03), 
                    height: MediaQuery.of(context).size.height*0.06,
                    child:Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
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
                  ],)),
                  Container(
                    margin: EdgeInsets.only(top: MediaQuery.of(context).size.height*0.03),
                    height: MediaQuery.of(context).size.height*0.06,
                    child:Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
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
                  ],)),
                ])])
            )))),
            Container(
              height: MediaQuery.of(context).size.height* 0.35,
              alignment: Alignment.center,
              child: Column(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      children: [
                                        AutoSizeText("Замовлення скасовано",
                                            style: GoogleFonts.montserrat(
                                                                          textStyle: TextStyle(
                                                                          color: textColor,
                                                                          fontSize: 20,
                                                                          fontWeight: FontWeight.w700)),
                                            minFontSize: 16,
                                            stepGranularity: 2,
                                            textAlign: TextAlign.center),
                                        Lottie.asset('lottie/error.json',
                                          width: MediaQuery.of(context).size.width* 0.4,
                                          height: MediaQuery.of(context).size.height* 0.2
                                          ),
            ]))
            ]);
      }
    }


    Future<void> _makePhoneCall(String phoneNumber) async {
    final Uri launchUri = Uri(
      scheme: 'tel',
      path: phoneNumber,
    );
    await launchUrl(launchUri);
  }
  }

