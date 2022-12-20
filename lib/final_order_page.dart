import 'dart:convert';
// ignore: import_of_legacy_library_into_null_safe
import 'package:awesome_page_transitions/awesome_page_transitions.dart';
import 'package:flutterfire_ui/database.dart';
import 'package:page_transition/page_transition.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:dotted_decoration/dotted_decoration.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:restaraunt_app/authentication.dart';
import 'package:restaraunt_app/register_page.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:swipeable_button_view/swipeable_button_view.dart';
import 'package:time_picker_sheet/widget/sheet.dart';
import 'package:time_picker_sheet/widget/time_picker.dart';
import 'package:toggle_switch/toggle_switch.dart';

import 'dashboard_page.dart';
import 'login_page.dart';
import 'order.dart';


 class FinalOrderPage extends StatefulWidget {
    const FinalOrderPage({Key? key}) : super(key: key);

    @override
    State<FinalOrderPage> createState() => _FinalOrderPageState();
  }

  class _FinalOrderPageState extends State<FinalOrderPage> {

    dynamic currentFocus;

    bool delivery = true;
    
      int initialIndex = 0;
      int secondInitialIndex = 0;

    unfocus() {
      currentFocus = FocusScope.of(context);
      if (!currentFocus.hasPrimaryFocus) {
        currentFocus.unfocus();
      }
    }

    dynamic address='';
    dynamic userId = '';
    String street = '';
    bool payment = false;
    bool isFinished = false;
    int countOfcutlery = 1;

    dynamic time = DateTime.now().toLocal();
    int hour = DateTime.now().toLocal().hour;
    dynamic addressQuery = '';
    dynamic pickupAddress = '';

  @override
  void initState() {
    getLogin();
    getData();
    super.initState();
  }

  void getData() async{
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      userId = (prefs.getString('userId') ?? '');
    });
    final ref = FirebaseDatabase.instance.ref('Users/$userId/addresses');
    Stream<DatabaseEvent> stream = ref.onValue;
    stream.listen((DatabaseEvent event) {
        setState(() {
          address = jsonDecode(jsonEncode(event.snapshot.children.first.value)) as Map<String, dynamic>;
          street = event.snapshot.children.first.key.toString();
          addressQuery = FirebaseDatabase.instance.ref('Users/$userId/addresses');
        });
      });

    final secondRef = FirebaseDatabase.instance.ref('About');
    Stream<DatabaseEvent> secondStream = secondRef.onValue;
    secondStream.listen((DatabaseEvent event) {
        setState(() {
          pickupAddress = jsonDecode(jsonEncode(event.snapshot.value)) as Map<String, dynamic>;
        });
      });
  }

  bool login = false;

  void getLogin() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      login = prefs.getBool('login') ?? false;
    });
  }
    


   @override
    Widget build(BuildContext context) {
      if(!login){
      return GestureDetector( 
          child: Scaffold(
            backgroundColor: const Color.fromRGBO(245, 245, 245, 1),
                  body: Container(
                                  alignment: Alignment.center,
                                  child: Column(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      children: [
                                        Lottie.asset('lottie/not_login.json',
                                          width: MediaQuery.of(context).size.width* 0.8,
                                          height: MediaQuery.of(context).size.height* 0.3
                                          ),
                                        AutoSizeText("Щоб побачити свої замовлення, увійдіть в акаунт",
                                            style: GoogleFonts.poiretOne(
                                                                          textStyle: const TextStyle(
                                                                          color: Colors.black,
                                                                          fontSize: 20,
                                                                          fontWeight: FontWeight.w800)),
                                            minFontSize: 12,
                                            stepGranularity: 2,
                                            textAlign: TextAlign.center), 
                                        GestureDetector(
                                          onTap: (() {
                                            Navigator.push( context,
                                              AwesomePageRoute(
                                                transitionDuration: const Duration(milliseconds: 600),
                                                enterPage: const LoginPage(),
                                                transition: StackTransition(),
                                              ));
                                          }),
                                          child:
                                          Container(alignment: Alignment.center,
                                            height: MediaQuery.of(context).size.height*0.07,
                                            width: MediaQuery.of(context).size.width*0.8,
                                            margin: EdgeInsets.only(top: MediaQuery.of(context).size.height*0.04),
                                            decoration: BoxDecoration(borderRadius: BorderRadius.circular(15), 
                                                          color: const Color.fromRGBO(254, 182, 102, 1)),
                                            child: Text("Увійти", 
                                                    textAlign: TextAlign.center,
                                                    style: GoogleFonts.poiretOne(
                                                                          textStyle: const TextStyle(
                                                                          color: Color.fromRGBO(240, 240, 240, 1),
                                                                          fontSize: 22,
                                                                          fontWeight: FontWeight.w800)),),  
                                                                      )),
                                        GestureDetector(
                                          onTap: () => Navigator.push( context,
                                              AwesomePageRoute(
                                                transitionDuration: const Duration(milliseconds: 600),
                                                enterPage: const RegisterPage(),
                                                transition: StackTransition(),
                                              )),
                                          child: Container(alignment: Alignment.center,
                                                  height: MediaQuery.of(context).size.height * 0.03,
                                                  margin: EdgeInsets.only(top: MediaQuery.of(context).size.height*0.015),
                                                  child: Text("Немає акаунту? Зареєструватись", 
                                                  style: GoogleFonts.poiretOne(
                                                                          textStyle: const TextStyle(
                                                                          color: Colors.black,
                                                                          fontSize: 16,
                                                                          fontWeight: FontWeight.w800,
                                                                          decoration: TextDecoration.underline,
                                                                          decorationColor: Colors.black,)))
                                        )),   
                                                        ]))
          ));}
          else{
      return GestureDetector( 
          onTap: unfocus,
          child: Scaffold(
            body: Column(
              children: [
            Container(
                      height: MediaQuery.of(context).size.height,
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
                                                      top: MediaQuery.of(context).size.height* 0.04),
                              width: MediaQuery.of(context).size.width* 0.5,
                              height: MediaQuery.of(context).size.height* 0.04,
                              child: AutoSizeText("Ваше замовлення", 
                                stepGranularity: 1,
                                minFontSize: 12,
                                style: GoogleFonts.montserrat(
                                      textStyle: const TextStyle(
                                      color: Color.fromRGBO(31, 31, 47, 1),
                                      fontSize: 18,
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
                                                        top: MediaQuery.of(context).size.height* 0.04),
                                width: MediaQuery.of(context).size.width* 0.1,
                                height: MediaQuery.of(context).size.width* 0.1,
                                child: const Icon(Icons.close_rounded, size: 30, color: Color.fromRGBO(31, 31, 47, 1),)
                          ))
                          ],),
                            SizedBox(
                                height: MediaQuery.of(context).size.height*0.35,
                                width: MediaQuery.of(context).size.width* 0.9,
                                child: ListView.separated(
                                        shrinkWrap: false,
                                        itemCount: OrderList.order.length,
                                        separatorBuilder: (BuildContext context, int index) => SizedBox(height: MediaQuery.of(context).size.height* 0.015),
                                        itemBuilder: (BuildContext context, int index){
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
                                                            OrderList.order[index].image,
                                                            width: MediaQuery.of(context).size.height* 0.12,
                                                            height: MediaQuery.of(context).size.height* 0.12,
                                                            fit: BoxFit.fill)
                                                            ),
                                                  Column(
                                                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                                          crossAxisAlignment: CrossAxisAlignment.start,
                                                          children: [
                                                            Text(OrderList.order[index].name,
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
                                                                        TextSpan(text: " ${OrderList.order[index].price*OrderList.order[index].count}",                                                                  
                                                                            style: GoogleFonts.nunito(
                                                                              textStyle: const TextStyle(
                                                                              color: Color.fromRGBO(31, 31, 47, 1),
                                                                              fontSize: 20,
                                                                              fontWeight: FontWeight.w600))),
                                                                      ],)),
                                                                  Text("x${OrderList.order[index].count}",
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
                                )
                          ),
                          Container(
                            margin: EdgeInsets.only(top: MediaQuery.of(context).size.height* 0.02),
                            width: MediaQuery.of(context).size.width* 0.9,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text("",
                                     style: GoogleFonts.poiretOne(
                                      textStyle: const TextStyle(
                                      color: Colors.black,
                                      fontSize: 20,
                                       fontWeight: FontWeight.w800))),
                                Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(15),
                                    boxShadow: [
                                      BoxShadow(
                                      color: Colors.grey.withOpacity(0.5),
                                      spreadRadius: 2,
                                      blurRadius: 4,
                                      offset: const Offset(0, 5), ),
                                    ]),
                                  child: ToggleSwitch(
                                    minWidth: MediaQuery.of(context).size.width* 0.3,
                                    minHeight: MediaQuery.of(context).size.height* 0.05,
                                    fontSize: 16,
                                    cornerRadius: 15,
                                    animate: true,
                                    curve: Curves.fastOutSlowIn,
                                    animationDuration: 500,
                                    initialLabelIndex: initialIndex,
                                    activeBgColor: const [ Color.fromRGBO(254, 182, 102, 1)],
                                    activeFgColor: Colors.white,
                                    inactiveBgColor: const Color.fromRGBO(200, 200, 200, 1),
                                    inactiveFgColor: Colors.black,
                                    totalSwitches: 2,
                                    customTextStyles: [GoogleFonts.poiretOne(
                                        textStyle: const TextStyle(
                                        color: Colors.black,
                                        fontSize: 17,
                                        fontWeight: FontWeight.w600))],
                                    labels: const ['Доставка', 'Самовивіз'],
                                    onToggle: (index) {
                                      setState(() {
                                        initialIndex = index!;
                                        delivery = !delivery;
                                      });
                                    },
                                )),
                              ],
                            )
                          ),
                          infoArea()
                          ],)), 
            ])));}
    }

    Widget infoArea(){
       if(address == ""){
                  return Expanded(
                            child:Container(
                                            width: MediaQuery.of(context).size.width* 0.95,
                                            alignment: Alignment.center,
                                            child: Column(
                                                mainAxisAlignment: MainAxisAlignment.center,
                                                crossAxisAlignment: CrossAxisAlignment.center,
                                                children: [
                                                  Lottie.asset('lottie/loading_food.json',
                                                      width: MediaQuery.of(context).size.width* 0.8,
                                                      height: MediaQuery.of(context).size.height* 0.3
                                                      ),
                                                  AutoSizeText("Загрузка..",
                                                      style: GoogleFonts.poiretOne(
                                                        textStyle: const TextStyle(
                                                        color: Colors.black,
                                                        fontSize: 20,
                                                        fontWeight: FontWeight.w800)),
                                                      minFontSize: 12,
                                                      stepGranularity: 2,
                                                      textAlign: TextAlign.center),
                                                ])));
              }
      else{
        if(delivery){
          return Container(
            height: MediaQuery.of(context).size.height*0.48,
              width: MediaQuery.of(context).size.width* 0.9,
              alignment: Alignment.center,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                Text("Адреса доставки",
                     style: GoogleFonts.montserrat(
                      textStyle: const TextStyle(
                      color: Colors.black,
                      fontSize: 18,
                      fontWeight: FontWeight.w600))),
                              GestureDetector( 
                  onTap: () {
                    openAddressSheet();
                  },
                  child: Container(
                                          margin: EdgeInsets.only(top: MediaQuery.of(context).size.height* 0.01),
                                          padding: EdgeInsets.only(left: MediaQuery.of(context).size.width* 0.05,
                                                                  right: MediaQuery.of(context).size.width* 0.05),
                                          width: MediaQuery.of(context).size.width* 0.9,
                                          height: MediaQuery.of(context).size.width* 0.17,
                                          decoration: BoxDecoration(borderRadius: BorderRadius.circular(15), 
                                                                color: const Color.fromRGBO(255, 255, 255, 1),
                                                                boxShadow: [
                                                                  BoxShadow(
                                                                    color: Colors.grey.withOpacity(0.5),
                                                                    spreadRadius: 2,
                                                                    blurRadius: 5,
                                                                    offset: const Offset(0, 5), 
                                                                  ),
                                                                ]),
                                          child: Column(
                                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text("${address["name"]}", 
                                              textAlign: TextAlign.center,
                                                style: GoogleFonts.nunito(
                                                      textStyle: const TextStyle(
                                                      color: Color.fromRGBO(31, 31, 47, 1),
                                                      fontSize: 18,
                                                      fontWeight: FontWeight.w800))),
                                            Text("${address["street"]}, ${address["building"]}", 
                                              textAlign: TextAlign.center,
                                                style: GoogleFonts.poiretOne(
                                                      textStyle: const TextStyle(
                                                      color: Color.fromRGBO(31, 31, 47, 1),
                                                      fontSize: 17,
                                                      fontWeight: FontWeight.w800))),
                                            ],),
                                              Row(
                                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                children: [
                                                Text("Квартира: ${address["apartment"]}", 
                                                  textAlign: TextAlign.center,
                                                    style: GoogleFonts.poiretOne(
                                                          textStyle: const TextStyle(
                                                          color: Color.fromRGBO(31, 31, 47, 1),
                                                          fontSize: 16,
                                                          fontWeight: FontWeight.w800))),
                                                Text("Поверх: ${address["floor"]}", 
                                                  textAlign: TextAlign.center,
                                                    style: GoogleFonts.poiretOne(
                                                          textStyle: const TextStyle(
                                                          color: Color.fromRGBO(31, 31, 47, 1),
                                                          fontSize: 16,
                                                          fontWeight: FontWeight.w800))),
                                                Text("Під'їзд: ${address["entrance"]}", 
                                                  textAlign: TextAlign.center,
                                                    style: GoogleFonts.poiretOne(
                                                          textStyle: const TextStyle(
                                                          color: Color.fromRGBO(31, 31, 47, 1),
                                                          fontSize: 16,
                                                          fontWeight: FontWeight.w800))),
                                              ])
                                          ],)
                                          )),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                    Text("Кількість приборів",
                     style: GoogleFonts.montserrat(
                      textStyle: const TextStyle(
                      color: Colors.black,
                      fontSize: 18,
                      fontWeight: FontWeight.w600))),
                     Container(
                      margin: EdgeInsets.only(top: MediaQuery.of(context).size.height* 0.01),
                      width: MediaQuery.of(context).size.width* 0.2,
                      height: MediaQuery.of(context).size.height* 0.04,
                      decoration: BoxDecoration(
                        color: const Color.fromRGBO(254, 182, 102, 1),
                        borderRadius: const BorderRadius.all(Radius.circular(15),),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.5),
                            spreadRadius: 2,
                            blurRadius: 5,
                            offset: const Offset(0, 5), ),
                           ]
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          GestureDetector(
                            onTap: (){
                              setState(() {
                                if(countOfcutlery!=0){
                                  countOfcutlery-=1;
                                }
                              });
                           },
                            child: const Text("-",
                              style: TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                              fontWeight: FontWeight.normal))),
                          Text("$countOfcutlery",
                            style: GoogleFonts.poiretOne(
                              textStyle: const TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                              fontWeight: FontWeight.w800))),
                          GestureDetector(
                            onTap: (){
                              setState(() { 
                                if(countOfcutlery!=10){
                                  countOfcutlery+=1;
                                } 
                              });
                            },
                            child: const Text("+",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 22,
                                fontWeight: FontWeight.normal))),
                            ]))]),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                    Text("Час доставки",
                     style: GoogleFonts.montserrat(
                      textStyle: const TextStyle(
                      color: Colors.black,
                      fontSize: 18,
                      fontWeight: FontWeight.w600))),
                    Container(
                      width: MediaQuery.of(context).size.width* 0.2,
                      height: MediaQuery.of(context).size.height* 0.04,
                      decoration: BoxDecoration(
                        color: const Color.fromRGBO(254, 182, 102, 1),
                        borderRadius: const BorderRadius.all(Radius.circular(15),),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.5),
                            spreadRadius: 2,
                            blurRadius: 5,
                            offset: const Offset(0, 5), ),
                           ]
                      ),
                      child: TextButton(
                      onPressed: () {
                          openTimeSheet();
                    },
                    child: Text(getTimeText(),
                        style: GoogleFonts.poiretOne(
                                textStyle: const TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                                //decoration: TextDecoration.underline,
                                fontWeight: FontWeight.w800))
                    )))]),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                    Text("Спосіб оплати",
                     style: GoogleFonts.montserrat(
                      textStyle: const TextStyle(
                      color: Colors.black,
                      fontSize: 18,
                      fontWeight: FontWeight.w600))),
                    Container(
                      width: MediaQuery.of(context).size.width* 0.25,
                      height: MediaQuery.of(context).size.height* 0.04,
                      decoration: BoxDecoration(
                        color: const Color.fromRGBO(254, 182, 102, 1),
                        borderRadius: const BorderRadius.all(Radius.circular(15),),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.5),
                            spreadRadius: 2,
                            blurRadius: 5,
                            offset: const Offset(0, 5), ),
                           ]
                      ),
                      child: TextButton(
                      onPressed: () {
                          openMoneySheet();
                      },
                      child: Text(getPaymentText(),
                          style: GoogleFonts.poiretOne(
                                  textStyle: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 17,
                                  //decoration: TextDecoration.underline,
                                  fontWeight: FontWeight.w800),
                                  )
                    )))]),
                  Container(
                    margin: EdgeInsets.only(top: MediaQuery.of(context).size.height* 0.01),
                    decoration: DottedDecoration(shape: Shape.line, linePosition: LinePosition.top),
                    child:
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                    Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                margin: EdgeInsets.only(top: MediaQuery.of(context).size.height* 0.01),
                                child: Text("Сума:", 
                                    textAlign: TextAlign.center,
                                    style: GoogleFonts.poiretOne(
                                      textStyle: const TextStyle(
                                      color: Color.fromRGBO(31, 31, 47, 1),
                                      fontSize: 20,
                                      fontWeight: FontWeight.w800)))),     
                              Container(
                                margin: EdgeInsets.only(top: MediaQuery.of(context).size.height* 0.01),
                                child: Text("${sumOfElements()}₴", 
                                    textAlign: TextAlign.center,
                                    style: GoogleFonts.nunito(
                                      textStyle: const TextStyle(
                                      color: Color.fromRGBO(31, 31, 47, 1),
                                      fontSize: 16,
                                      fontWeight: FontWeight.w600))),                                ),
                        ],),
                        Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                margin: EdgeInsets.only(top: MediaQuery.of(context).size.height* 0.005),
                                child: Text("Доставка:", 
                                    textAlign: TextAlign.center,
                                    style: GoogleFonts.poiretOne(
                                      textStyle: const TextStyle(
                                      color: Color.fromRGBO(31, 31, 47, 1),
                                      fontSize: 18,
                                      fontWeight: FontWeight.w800)))),     
                              Container(
                                margin: EdgeInsets.only(top: MediaQuery.of(context).size.height* 0.005),
                                child: Text("+40₴", 
                                    textAlign: TextAlign.center,
                                    style: GoogleFonts.nunito(
                                      textStyle: const TextStyle(
                                      color: Color.fromRGBO(31, 31, 47, 1),
                                      fontSize: 14,
                                      fontWeight: FontWeight.w600))),                                ),
                        ],),
                        Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                margin: EdgeInsets.only(top: MediaQuery.of(context).size.height* 0.01),
                                child: Text("Разом:", 
                                    textAlign: TextAlign.center,
                                    style: GoogleFonts.poiretOne(
                                      textStyle: const TextStyle(
                                      color: Color.fromRGBO(31, 31, 47, 1),
                                      fontSize: 24,
                                      fontWeight: FontWeight.w800)))),     
                              Container(
                                margin: EdgeInsets.only(top: MediaQuery.of(context).size.height* 0.01),
                                child: Text("${sumOfElements()+40}₴", 
                                    textAlign: TextAlign.center,
                                    style: GoogleFonts.nunito(
                                      textStyle: const TextStyle(
                                      color: Color.fromRGBO(31, 31, 47, 1),
                                      fontSize: 20,
                                      fontWeight: FontWeight.w600))),                                ),
                        ],),
                        Container(
                          margin: EdgeInsets.only(top: MediaQuery.of(context).size.height* 0.01),
                          child: SwipeableButtonView(
                          buttonText: 'Замовити',
                          buttontextstyle: GoogleFonts.poiretOne(
                                      textStyle: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 21,
                                      fontWeight: FontWeight.w800)),
                          buttonWidget: const Icon(Icons.arrow_forward_ios_rounded,
                              color: Colors.grey,
                                  ),
                          activeColor: const Color.fromRGBO(254, 182, 102, 1),
                          isFinished: isFinished,
                          onWaitingProcess: () {
                            Future.delayed(const Duration(seconds: 1), () {
                                    setState(() {
                                        isFinished = true;
                                              });
                                            });
                                          },
                          onFinish: () async {
                              addOrder(address["apartment"], address["building"], address["entrance"], address["floor"], address["street"], sumOfElements()+40, OrderList.order, getTimeText(), getPaymentText(), countOfcutlery);
                              await Navigator.push(context,
                                              PageTransition(
                                                  type: PageTransitionType.fade,
                                                  child: const DashboardPage()));
                                          setState(() {
                                            isFinished = false;
                                          });
                                        },
                      ))
                        ]))
                ],
              )
        );
      }
      else{
        return Container(
            height: MediaQuery.of(context).size.height*0.48,
              width: MediaQuery.of(context).size.width* 0.9,
              alignment: Alignment.center,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                Text("Адреса самовивозу",
                     style: GoogleFonts.montserrat(
                      textStyle: const TextStyle(
                      color: Colors.black,
                      fontSize: 18,
                      fontWeight: FontWeight.w600))),
               Container(
                                          padding: EdgeInsets.only(left: MediaQuery.of(context).size.width* 0.05,
                                                                  right: MediaQuery.of(context).size.width* 0.05),
                                          width: MediaQuery.of(context).size.width* 0.9,
                                          height: MediaQuery.of(context).size.width* 0.12,
                                          decoration: BoxDecoration(borderRadius: BorderRadius.circular(15), 
                                                                color: const Color.fromRGBO(255, 255, 255, 1)),
                                          child: Column(
                                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              Text("${pickupAddress["address"]}", 
                                                textAlign: TextAlign.center,
                                                  style: GoogleFonts.poiretOne(
                                                        textStyle: const TextStyle(
                                                        color: Color.fromRGBO(31, 31, 47, 1),
                                                        fontSize: 18,
                                                        fontWeight: FontWeight.w800))),
                                          ],)
                                          ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                    Text("Кількість приборів",
                     style: GoogleFonts.montserrat(
                      textStyle: const TextStyle(
                      color: Colors.black,
                      fontSize: 18,
                      fontWeight: FontWeight.w600))),
                     Container(
                      margin: EdgeInsets.only(top: MediaQuery.of(context).size.height* 0.01),
                      width: MediaQuery.of(context).size.width* 0.2,
                      height: MediaQuery.of(context).size.height* 0.04,
                      decoration: BoxDecoration(
                        color: const  Color.fromRGBO(254, 182, 102, 1),
                        borderRadius: const BorderRadius.all(Radius.circular(15)),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.5),
                            spreadRadius: 2,
                            blurRadius: 5,
                            offset: const Offset(0, 5), ),
                           ]
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          GestureDetector(
                            onTap: (){
                              setState(() {
                                if(countOfcutlery!=0){
                                  countOfcutlery-=1;
                                }
                              });
                           },
                            child: const Text("-",
                              style: TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                              fontWeight: FontWeight.normal))),
                          Text("$countOfcutlery",
                            style: GoogleFonts.poiretOne(
                              textStyle: const TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                              fontWeight: FontWeight.w800))),
                          GestureDetector(
                            onTap: (){
                              setState(() { 
                                if(countOfcutlery!=10){
                                  countOfcutlery+=1;
                                } 
                              });
                            },
                            child: const Text("+",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 22,
                                fontWeight: FontWeight.normal))),
                            ]))]),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                    Text("Час самовивозу",
                     style: GoogleFonts.montserrat(
                      textStyle: const TextStyle(
                      color: Colors.black,
                      fontSize: 18,
                      fontWeight: FontWeight.w600))),
                    Container(
                      width: MediaQuery.of(context).size.width* 0.2,
                      height: MediaQuery.of(context).size.height* 0.04,
                      decoration: BoxDecoration(
                        color: const Color.fromRGBO(254, 182, 102, 1),
                        borderRadius: const BorderRadius.all(Radius.circular(15),),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.5),
                            spreadRadius: 2,
                            blurRadius: 5,
                            offset: const Offset(0, 5), ),
                           ]
                      ),
                      child: TextButton(
                      onPressed: () {
                          openTimeSheet();
                    },
                    child: Text(getTimeText(),
                        style: GoogleFonts.poiretOne(
                                textStyle: const TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                                //decoration: TextDecoration.underline,
                                fontWeight: FontWeight.w800))
                    )))]),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                    Text("Спосіб оплати",
                     style: GoogleFonts.montserrat(
                      textStyle: const TextStyle(
                      color: Colors.black,
                      fontSize: 18,
                      fontWeight: FontWeight.w600))),
                    Container(
                      width: MediaQuery.of(context).size.width* 0.25,
                      height: MediaQuery.of(context).size.height* 0.04,
                      decoration: BoxDecoration(
                        color: const Color.fromRGBO(254, 182, 102, 1),
                        borderRadius: const BorderRadius.all(Radius.circular(15),),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.5),
                            spreadRadius: 2,
                            blurRadius: 5,
                            offset: const Offset(0, 5), ),
                           ]
                      ),
                      child: TextButton(
                      onPressed: () {
                          openMoneySheet();
                    },
                    child: Text(getPaymentText(),
                        style: GoogleFonts.poiretOne(
                                textStyle: const TextStyle(
                                color: Colors.white,
                                fontSize: 17,
                                //decoration: TextDecoration.underline,
                                fontWeight: FontWeight.w800))
                    )))]),
                  Container(
                    decoration: DottedDecoration(shape: Shape.line, linePosition: LinePosition.top),
                    child:
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                    Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                margin: EdgeInsets.only(top: MediaQuery.of(context).size.height* 0.01),
                                child: Text("Сума:", 
                                    textAlign: TextAlign.center,
                                    style: GoogleFonts.poiretOne(
                                      textStyle: const TextStyle(
                                      color: Color.fromRGBO(31, 31, 47, 1),
                                      fontSize: 20,
                                      fontWeight: FontWeight.w800)))),     
                              Container(
                                margin: EdgeInsets.only(top: MediaQuery.of(context).size.height* 0.01),
                                child: Text("${sumOfElements()}₴", 
                                    textAlign: TextAlign.center,
                                    style: GoogleFonts.nunito(
                                      textStyle: const TextStyle(
                                      color: Color.fromRGBO(31, 31, 47, 1),
                                      fontSize: 16,
                                      fontWeight: FontWeight.w600))),                                ),
                        ],),
                        Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                margin: EdgeInsets.only(top: MediaQuery.of(context).size.height* 0.005),
                                child: Text("Самовивіз:", 
                                    textAlign: TextAlign.center,
                                    style: GoogleFonts.poiretOne(
                                      textStyle: const TextStyle(
                                      color: Color.fromRGBO(31, 31, 47, 1),
                                      fontSize: 18,
                                      fontWeight: FontWeight.w800)))),     
                              Container(
                                margin: EdgeInsets.only(top: MediaQuery.of(context).size.height* 0.005),
                                child: Text("+0₴", 
                                    textAlign: TextAlign.center,
                                    style: GoogleFonts.nunito(
                                      textStyle: const TextStyle(
                                      color: Color.fromRGBO(31, 31, 47, 1),
                                      fontSize: 14,
                                      fontWeight: FontWeight.w600))),                                ),
                        ],),
                        Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                margin: EdgeInsets.only(top: MediaQuery.of(context).size.height* 0.01),
                                child: Text("Разом:", 
                                    textAlign: TextAlign.center,
                                    style: GoogleFonts.poiretOne(
                                      textStyle: const TextStyle(
                                      color: Color.fromRGBO(31, 31, 47, 1),
                                      fontSize: 24,
                                      fontWeight: FontWeight.w800)))),     
                              Container(
                                margin: EdgeInsets.only(top: MediaQuery.of(context).size.height* 0.01),
                                child: Text("${sumOfElements()}₴", 
                                    textAlign: TextAlign.center,
                                    style: GoogleFonts.nunito(
                                      textStyle: const TextStyle(
                                      color: Color.fromRGBO(31, 31, 47, 1),
                                      fontSize: 20,
                                      fontWeight: FontWeight.w600))),                                ),
                        ],),
                        Container(
                          margin: EdgeInsets.only(top: MediaQuery.of(context).size.height* 0.01),
                          child: SwipeableButtonView(
                          buttonText: 'Замовити',
                          buttontextstyle: GoogleFonts.poiretOne(
                                      textStyle: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 21,
                                      fontWeight: FontWeight.w800)),
                          buttonWidget: const Icon(Icons.arrow_forward_ios_rounded,
                              color: Colors.grey,
                                  ),
                          activeColor: const Color.fromRGBO(254, 182, 102, 1),
                          isFinished: isFinished,
                          onWaitingProcess: () {
                            Future.delayed(const Duration(seconds: 1), () {
                                    setState(() {
                                        isFinished = true;
                                              });
                                            });
                                          },
                          onFinish: () async {
                              addOrder(address["apartment"], address["building"], address["entrance"], address["floor"], address["street"], sumOfElements(), OrderList.order, getTimeText(), getPaymentText(), countOfcutlery);
                              await Navigator.push(context,
                                              PageTransition(
                                                  type: PageTransitionType.fade,
                                                  child: const DashboardPage()));
                                          setState(() {
                                            isFinished = false;
                                          });
                                        },
                      ))
                        ]))
                ],
              )
        );
      }}
    }

    int sumOfElements(){
    int sum = 0; 
    for (var element in OrderList.order) {
      sum += element.price*element.count;
     }
  return sum;
} 

    String getPaymentText(){
      if(!payment){
          return "Готівка";
      }
      else{
        return "Карткою";
      }
    }

    void openAddressSheet(){
      showDialog<String>(
                 context: context,
                 builder: (BuildContext context) => StatefulBuilder(
                  builder: (context, setModalState){ 
                    return AlertDialog(
                      backgroundColor: const Color.fromRGBO(245, 245, 245, 1),
                      insetPadding: const EdgeInsets.all(0),
                      shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(15))),
                  contentPadding: const EdgeInsets.all(0),
                  content: Container(
                            padding: EdgeInsets.only(left: MediaQuery.of(context).size.width* 0.025,
                                                     right: MediaQuery.of(context).size.width* 0.025),
                            height: MediaQuery.of(context).size.height*0.4,
                            margin: EdgeInsets.only(top: MediaQuery.of(context).size.height* 0.02),
                            width: MediaQuery.of(context).size.width* 0.9,
                            child: FirebaseDatabaseQueryBuilder(
                                  query: addressQuery,
                                  builder: (context, snapshot, _) { 
                                  return ListView.separated(
                              itemCount: snapshot.docs.length,
                              separatorBuilder: (BuildContext context, int index) => SizedBox(height: MediaQuery.of(context).size.height* 0.015),
                              itemBuilder: (BuildContext context, int index){
                                if (snapshot.hasMore && index + 1 == snapshot.docs.length) {
                                  snapshot.fetchMore();
                                  } 
                                final addressTemp = jsonDecode(jsonEncode(snapshot.docs[index].value)) as Map<String, dynamic>;
                                String streetTemp = snapshot.docs[index].key.toString();
                                return GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      address = addressTemp;
                                      street = streetTemp;
                                      Navigator.pop(context);
                                    });
                                  },
                                  child: Container(
                                        padding: EdgeInsets.only(left: MediaQuery.of(context).size.width* 0.05,
                                                                right: MediaQuery.of(context).size.width* 0.05),
                                        width: MediaQuery.of(context).size.width* 0.8,
                                        height: MediaQuery.of(context).size.width* 0.17,
                                        decoration: BoxDecoration(borderRadius: BorderRadius.circular(15), 
                                                              color: const Color.fromRGBO(255, 255, 255, 1)),
                                        child: Column(
                                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text("${addressTemp["name"]}", 
                                              textAlign: TextAlign.center,
                                                style: GoogleFonts.nunito(
                                                      textStyle: const TextStyle(
                                                      color: Color.fromRGBO(31, 31, 47, 1),
                                                      fontSize: 18,
                                                      fontWeight: FontWeight.w800))),
                                            Text("${addressTemp["street"]}, ${addressTemp["building"]}",
                                              textAlign: TextAlign.center,
                                                style: GoogleFonts.poiretOne(
                                                      textStyle: const TextStyle(
                                                      color: Color.fromRGBO(31, 31, 47, 1),
                                                      fontSize: 17,
                                                      fontWeight: FontWeight.w800))),
                                            ],),
                                            Row(
                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                              children: [
                                              Text("Квартира: ${addressTemp["apartment"]}", 
                                                textAlign: TextAlign.center,
                                                  style: GoogleFonts.poiretOne(
                                                        textStyle: const TextStyle(
                                                        color: Color.fromRGBO(31, 31, 47, 1),
                                                        fontSize: 16,
                                                        fontWeight: FontWeight.w800))),
                                              Text("Поверх: ${addressTemp["floor"]}", 
                                                textAlign: TextAlign.center,
                                                  style: GoogleFonts.poiretOne(
                                                        textStyle: const TextStyle(
                                                        color: Color.fromRGBO(31, 31, 47, 1),
                                                        fontSize: 16,
                                                        fontWeight: FontWeight.w800))),
                                              Text("Під'їзд: ${addressTemp["entrance"]}", 
                                                textAlign: TextAlign.center,
                                                  style: GoogleFonts.poiretOne(
                                                        textStyle: const TextStyle(
                                                        color: Color.fromRGBO(31, 31, 47, 1),
                                                        fontSize: 16,
                                                        fontWeight: FontWeight.w800))),
                                            ])
                                        ],)
                                        ));
                              });}))
                        );}));
    }

    void openMoneySheet(){
       showDialog<String>(
                 context: context,
                 builder: (BuildContext context) => StatefulBuilder(
                  builder: (context, setModalState){ 
                    return AlertDialog(
                      insetPadding: const EdgeInsets.all(0),
                      shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(25))),
                  contentPadding: const EdgeInsets.all(0),
                  content: ToggleSwitch(
                                isVertical: true,
                                minWidth: MediaQuery.of(context).size.width* 0.9,
                                minHeight: MediaQuery.of(context).size.height* 0.1,
                                fontSize: 20,
                                cornerRadius: 15,
                                animate: true,
                                curve: Curves.fastOutSlowIn,
                                animationDuration: 500,
                                initialLabelIndex: secondInitialIndex,
                                activeBgColor: const [ Color.fromRGBO(254, 182, 102, 1)],
                                activeFgColor: Colors.white,
                                inactiveBgColor: const Color.fromRGBO(200, 200, 200, 1),
                                inactiveFgColor: Colors.black,
                                totalSwitches: 2,
                                customTextStyles: [GoogleFonts.poiretOne(
                                    textStyle: const TextStyle(
                                    color: Colors.black,
                                    fontSize: 17,
                                    fontWeight: FontWeight.w600))],
                                labels: const ["Готівка", "Карткою"],
                                onToggle: (index) {
                                  setState(() {
                                    secondInitialIndex = index!;
                                    payment = !payment;
                                  });
                                },
                              ));}));
    }

    void openTimeSheet() async{ 
      final result = await TimePicker.show<DateTime?>(
                            roundedCorner: 15,
                            context: context,
                            sheet: TimePickerSheet(
                              initialDateTime: DateTime.now(),
                              saveButtonColor: const Color.fromRGBO(254, 182, 102, 1),
                              minuteTitleStyle: GoogleFonts.poiretOne(
                                                textStyle: const TextStyle(
                                                color: Colors.black,
                                                fontSize: 20,
                                                fontWeight: FontWeight.w800)),
                              hourTitleStyle: GoogleFonts.poiretOne(
                                              textStyle: const TextStyle(
                                              color: Colors.black,
                                              fontSize: 20,
                                              fontWeight: FontWeight.w800)),
                              sheetCloseIconColor: const Color.fromRGBO(254, 182, 102, 1),
                              sheetTitleStyle: GoogleFonts.poiretOne(
                                            textStyle: const TextStyle(
                                            color: Colors.black,
                                            fontSize: 20,
                                            fontWeight: FontWeight.w800)),
                              wheelNumberSelectedStyle: GoogleFonts.poiretOne(
                                                        textStyle: const TextStyle(
                                                        color: Color.fromRGBO(254, 182, 102, 1),
                                                        fontSize: 16,
                                                        fontWeight: FontWeight.w800)),
                              wheelNumberItemStyle: GoogleFonts.poiretOne(
                                                    textStyle: const TextStyle(
                                                    color: Colors.black,
                                                    fontSize: 16,
                                                    fontWeight: FontWeight.w800)),
                              minuteInterval: 1,
                              minHour: 6,
                              maxHour: 22,
                              sheetTitle: 'Час доставки',
                              hourTitle: 'Година',
                              minuteTitle: 'Хвилина',
                              saveButtonText: 'Зберегти',
                          ),
                      ); 
      if(result == null){
        setState(() {
          time = DateTime.now().toLocal();
        });
        }
      else{
        setState(() {
          time = result;
        });
      }
      } 


      String getTimeText(){
        String hour;
        String minute;
        if(time.hour<10){
          hour = '0${time.hour}';
        }
        else{
          hour = time.hour.toString();
        }
        if(time.minute<10){
          minute = '0${time.minute}';
        }
        else{
          minute = time.minute.toString();
        }
        return "$hour:$minute";
      }
    }
  