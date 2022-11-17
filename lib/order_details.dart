import 'package:dotted_decoration/dotted_decoration.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
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

    ScrollController _controller = ScrollController();


    @override
    void initState() {
      super.initState();
      _controller = ScrollController();
      WidgetsBinding.instance.addPostFrameCallback((_) {
          _controller.animateTo(
            _controller.position.maxScrollExtent,
            duration: const Duration(seconds: 1),
            curve: Curves.fastOutSlowIn,
    );
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
                      borderRadius: BorderRadius.all(Radius.circular(25)),
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
                            child: Text("Ваше замовлення", 
                              style: GoogleFonts.poiretOne(
                                    textStyle: const TextStyle(
                                    color: Color.fromRGBO(31, 31, 47, 1),
                                    fontSize: 22,
                                    fontWeight: FontWeight.w800)))),
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
                        Expanded( 
                            child: Container(
                              margin: EdgeInsets.only(top: MediaQuery.of(context).size.height* 0.02),
                              width: MediaQuery.of(context).size.width* 0.9,
                              child: ListView.separated(
                                      clipBehavior: Clip.none,
                                      itemCount: readyOrder.dishOrder.length,
                                      separatorBuilder: (BuildContext context, int index) => SizedBox(height: MediaQuery.of(context).size.height* 0.02),
                                      itemBuilder: (BuildContext context, int index){
                                          return  Container(
                                            height: MediaQuery.of(context).size.height* 0.15,
                                            decoration: const BoxDecoration(
                                              color: Color.fromRGBO(255, 255, 255, 1),
                                              borderRadius: BorderRadius.all(Radius.circular(20)),
                                            ),
                                            child: Row(
                                              mainAxisAlignment: MainAxisAlignment.start,
                                              crossAxisAlignment: CrossAxisAlignment.center,
                                              children: [
                                                Container(
                                                  padding: EdgeInsets.all(MediaQuery.of(context).size.width* 0.05),
                                                  width: MediaQuery.of(context).size.width* 0.32,
                                                  height: MediaQuery.of(context).size.width* 0.32,
                                                  alignment: Alignment.center,
                                                  child: Image.asset(
                                                          width: MediaQuery.of(context).size.width* 0.32,
                                                          height: MediaQuery.of(context).size.width* 0.32,
                                                          readyOrder.dishOrder[index].image,
                                                          fit: BoxFit.fill)),
                                                Column(
                                                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                                        crossAxisAlignment: CrossAxisAlignment.start,
                                                        children: [
                                                          Text(readyOrder.dishOrder[index].name,
                                                              style: GoogleFonts.poiretOne(
                                                                          textStyle: const TextStyle(
                                                                          color: Color.fromRGBO(31, 31, 47, 1),
                                                                          fontSize: 20,
                                                                          fontWeight: FontWeight.w800))),
                                                          Container(
                                                            width: MediaQuery.of(context).size.width* 0.54,
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
                                                                    TextSpan(text: " ${readyOrder.dishOrder[index].price*readyOrder.dishOrder[index].count}",                                                                  
                                                                        style: GoogleFonts.nunito(
                                                                          textStyle: const TextStyle(
                                                                          color: Color.fromRGBO(31, 31, 47, 1),
                                                                          fontSize: 20,
                                                                          fontWeight: FontWeight.w600))),
                                                                  ],)),
                                                          ],)),
                                                        ],),
                                            ]),
                                          );
                                },
                              ))
                        ),
                        Container(
                          //decoration: DottedDecoration(shape: Shape.line, linePosition: LinePosition.top,),
                          decoration: BoxDecoration(color: additionalColor),
                          alignment: Alignment.topCenter,
                          width: MediaQuery.of(context).size.width,
                          child:Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                margin: EdgeInsets.only(top: MediaQuery.of(context).size.height*0.03),
                                child: Text("Сума:", 
                                    textAlign: TextAlign.center,
                                    style: GoogleFonts.poiretOne(
                                      textStyle: const TextStyle(
                                      color: Color.fromRGBO(31, 31, 47, 1),
                                      fontSize: 26,
                                      fontWeight: FontWeight.w800)))),     
                              Container(
                                margin: EdgeInsets.only(bottom: MediaQuery.of(context).size.height*0.02,
                                                        top: MediaQuery.of(context).size.height*0.03),
                                child: Text("${readyOrder.price}₴", 
                                    textAlign: TextAlign.center,
                                    style: GoogleFonts.nunito(
                                      textStyle: const TextStyle(
                                      color: Color.fromRGBO(31, 31, 47, 1),
                                      fontSize: 22,
                                      fontWeight: FontWeight.w600))),                                ),
                        ],)),    
                        ],)),
              statusOfProcessing(),
                        
        ]));
    }

    Widget statusOfProcessing(){
      switch(readyOrder.statufOfProcessing){
        case 1: return  SizedBox( 
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
                  height: MediaQuery.of(context).size.height*0.53,
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
                                child: Text("20:25", style: GoogleFonts.poiretOne(
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
                                                Container(
                                                  decoration: const BoxDecoration(color: Color.fromRGBO(254, 182, 102, 1),
                                                    borderRadius: BorderRadius.all(Radius.circular(15)),),
                                                  width: MediaQuery.of(context).size.width* 0.13,
                                                  height: MediaQuery.of(context).size.width* 0.11,
                                                  alignment: Alignment.center,
                                                  child: const Icon(Icons.phone, size: 25)),
                                            ])
                  )
                  
                  ])),
                ])])
            )));
        case 2: return 
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
                                child: Text("20:40", style: GoogleFonts.poiretOne(
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
                                child: Text("20:20", style: GoogleFonts.poiretOne(
                                                                                  textStyle: const TextStyle(
                                                                                  color: Color.fromRGBO(254, 182, 102, 1),
                                                                                  fontSize: 14,
                                                                                  decoration: TextDecoration.none,
                                                                                  fontWeight: FontWeight.w800)))), 
                  ],)),
                ])])
            )));
        case 3: return 
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
                                child: Text("20:20", style: GoogleFonts.poiretOne(
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
                                child: Text("21:40", style: GoogleFonts.poiretOne(
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
  }

