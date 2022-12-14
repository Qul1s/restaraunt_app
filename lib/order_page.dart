
import 'dart:convert';
import 'package:auto_size_text/auto_size_text.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:awesome_page_transitions/awesome_page_transitions.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutterfire_ui/database.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconsax/iconsax.dart';
import 'package:lottie/lottie.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'login_page.dart';
import 'order_details.dart';
import 'register_page.dart';

 class OrderPage extends StatefulWidget {
    const OrderPage({Key? key}) : super(key: key);

    @override
    State<OrderPage> createState() => _OrderPageState();
  }

  class _OrderPageState extends State<OrderPage> {
       
    Color additionalColor = const Color.fromRGBO(248, 248, 248, 1);
    Color textColor = const Color.fromRGBO(68, 68,68, 1);

    bool login = true;
    dynamic ordersQuery = FirebaseDatabase.instance.ref('Orders');

    @override
    void initState() {
      getData();
      super.initState();
    }

    void getData() async{
      final prefs = await SharedPreferences.getInstance();
      setState(() {
        var userId = (prefs.getString('userId') ?? '');
        ordersQuery = FirebaseDatabase.instance.ref('Orders').orderByChild("userId").equalTo(userId);
      });
    }
       
    @override
    Widget build(BuildContext context) {
      if(!login){
      return GestureDetector( 
          child: Scaffold(
            backgroundColor: additionalColor,
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
                                                                          textStyle: TextStyle(
                                                                          color: textColor,
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
                                          child:Container(alignment: Alignment.center,
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
                                                                          textStyle: TextStyle(
                                                                          color: const Color.fromRGBO(240, 240, 240, 1),
                                                                          fontSize: 16,
                                                                          fontWeight: FontWeight.w800,
                                                                          decoration: TextDecoration.underline,
                                                                          decorationColor: textColor,)))
                                        )),   
                                                        ]))
          ));}
          else{
            if(ordersQuery == ""){
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
                                                        textStyle: TextStyle(
                                                        color: textColor,
                                                        fontSize: 20,
                                                        fontWeight: FontWeight.w800)),
                                                      minFontSize: 12,
                                                      stepGranularity: 2,
                                                      textAlign: TextAlign.center),
                                                ])));
              }
            else{
            return Container(
                    padding: EdgeInsets.only(top: MediaQuery.of(context).size.height* 0.05),
                    height: MediaQuery.of(context).size.height*0.927,
                    width: MediaQuery.of(context).size.width,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
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
                            child: Text("Ваші замовлення", 
                              style: GoogleFonts.nunito(
                                    textStyle: const TextStyle(
                                    color: Color.fromRGBO(31, 31, 47, 1),
                                    fontSize: 18,
                                    fontWeight: FontWeight.w800)))),
                          GestureDetector(
                            onTap:() {
                              //Navigator.pop(context);
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
                              child: const Icon(Icons.filter_list, size: 30, color: Color.fromRGBO(31, 31, 47, 1),)
                        ))
                        ],),
                        Expanded(child: Container(
                          margin: EdgeInsets.only(top: MediaQuery.of(context).size.height* 0.02),
                          width: MediaQuery.of(context).size.width*0.9,
                          child: FirebaseDatabaseQueryBuilder(
                                  query: ordersQuery,
                                  builder: (context, snapshot, _) { 
                                  return ListView.separated(
                            clipBehavior: Clip.antiAlias,
                            itemCount: snapshot.docs.length,
                            separatorBuilder: (BuildContext context, int index) => SizedBox(height: MediaQuery.of(context).size.height* 0.02),
                            shrinkWrap: true,
                              itemBuilder: (BuildContext context, int index){
                                if (snapshot.hasMore && index + 1 == snapshot.docs.length) {
                                  snapshot.fetchMore();
                                  } 
                                final order = jsonDecode(jsonEncode(snapshot.docs[index].value)) as Map<String, dynamic>;
                                var indexTemp = snapshot.docs[index].key.toString();
                                var dishesQuery = FirebaseDatabase.instance.ref('Orders/$indexTemp/dishes');
                                return GestureDetector( 
                                          onTap: () {
                                            Navigator.push( context,
                                              AwesomePageRoute(
                                                transitionDuration: const Duration(milliseconds: 600),
                                                enterPage: OrderDetailsPage(index: indexTemp.toString()),
                                                transition: StackTransition(),
                                              ));
                                          },
                                    child: Container(
                                    padding: EdgeInsets.only(left: MediaQuery.of(context).size.width*0.05,
                                                            right: MediaQuery.of(context).size.width*0.05,
                                                            top: MediaQuery.of(context).size.height*0.01,
                                                            bottom: MediaQuery.of(context).size.height*0.015),
                                    width: MediaQuery.of(context).size.width*0.9,
                                    height: MediaQuery.of(context).size.height*0.43,
                                    decoration: BoxDecoration(borderRadius: BorderRadius.circular(15), 
                                      color: const Color.fromRGBO(255, 255, 255, 1)),
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      children: [
                                      Container(
                                        margin: EdgeInsets.only(top: MediaQuery.of(context).size.height*0.01),
                                        width: MediaQuery.of(context).size.width*0.8,
                                        child: Text("Замовлення №${order["number"]}",
                                                style: GoogleFonts.poiretOne(
                                                                            textStyle: TextStyle(
                                                                            color: textColor,
                                                                            fontSize: 18,
                                                                            fontWeight: FontWeight.w800)))),
                                        Container(
                                        margin: EdgeInsets.only(top: MediaQuery.of(context).size.height*0.005),
                                        width: MediaQuery.of(context).size.width*0.8,
                                        child: Text("${order["date"]}, ${order["time"]}",
                                                style: GoogleFonts.poiretOne(
                                                                            textStyle: const TextStyle(
                                                                            color: Color.fromRGBO(100, 100, 100, 1),
                                                                            fontSize: 16,
                                                                            fontWeight: FontWeight.w600)))),
                                      
                                      Expanded(child: 
                                       Container(
                                        alignment: Alignment.center,
                                        child: FirebaseDatabaseQueryBuilder(
                                        query: dishesQuery,
                                        builder: (context, snapshot, _) { 
                                  return ListView.separated(
                                          separatorBuilder: (context, index) {
                                            return const Divider();
                                          },
                                          physics: const NeverScrollableScrollPhysics(),
                                          itemCount: snapshot.docs.length,
                                          shrinkWrap: true,
                                            itemBuilder: (BuildContext context, int secondIndex){
                                                if (snapshot.hasMore && secondIndex + 1 == snapshot.docs.length) {
                                                 snapshot.fetchMore();
                                                } 
                                              final dishes = jsonDecode(jsonEncode(snapshot.docs[secondIndex].value)) as Map<String, dynamic>;
                                              return Container(
                                                decoration: const BoxDecoration(
                                                color: Color.fromRGBO(255, 255, 255, 1),
                                                borderRadius: BorderRadius.all(Radius.circular(10)),
                                              ),
                                                child: Row(
                                                mainAxisAlignment: MainAxisAlignment.start,
                                                crossAxisAlignment: CrossAxisAlignment.center,
                                                children: [
                                                  Container(
                                                    width: MediaQuery.of(context).size.width* 0.25,
                                                    height: MediaQuery.of(context).size.width* 0.25,
                                                    alignment: Alignment.center,
                                                    child: Image.asset(
                                                            dishes["image"],
                                                            width: MediaQuery.of(context).size.width* 0.32,
                                                            height: MediaQuery.of(context).size.width* 0.32,
                                                            fit: BoxFit.fill)),
                                                  Column(
                                                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                                          crossAxisAlignment: CrossAxisAlignment.start,
                                                          children: [
                                                            Container(
                                                              width: MediaQuery.of(context).size.width* 0.52,
                                                              padding: EdgeInsets.only(left: MediaQuery.of(context).size.width* 0.05),
                                                              child: Text(dishes["name"],
                                                                style: GoogleFonts.poiretOne(
                                                                            textStyle: const TextStyle(
                                                                            color: Color.fromRGBO(31, 31, 47, 1),
                                                                            fontSize: 17,
                                                                            fontWeight: FontWeight.w800)))),
                                                            Container(
                                                              width: MediaQuery.of(context).size.width* 0.47,
                                                              margin: EdgeInsets.only(left: MediaQuery.of(context).size.width* 0.05),
                                                              child: Row(
                                                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                                crossAxisAlignment: CrossAxisAlignment.center,
                                                                children: [
                                                                  RichText(
                                                                  text: TextSpan(
                                                                  children: <TextSpan>[
                                                                      TextSpan(text: "₴",
                                                                      style: GoogleFonts.nunito(
                                                                            textStyle: const TextStyle(
                                                                            color: Color.fromRGBO(254, 182, 102, 1),
                                                                            fontSize: 17,
                                                                            fontWeight: FontWeight.w800))                                                                 ),
                                                                      TextSpan(text: " ${dishes["price"]*dishes["count"]}",                                                                  
                                                                          style: GoogleFonts.nunito(
                                                                            textStyle: const TextStyle(
                                                                            color: Color.fromRGBO(31, 31, 47, 1),
                                                                            fontSize: 20,
                                                                            fontWeight: FontWeight.w600))),
                                                                    ],)),
                                                                  Text("Кількість: ${dishes["count"]}",
                                                                      style: GoogleFonts.poiretOne(
                                                                            textStyle: const TextStyle(
                                                                            color: Color.fromRGBO(31, 31, 47, 1),
                                                                            fontSize: 15,
                                                                            fontWeight: FontWeight.w800))),  
                                                            ],)),
                                                          ],),
                                              ]),
                                            );});})),
                                    ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: [
                                      Text(" ${order["price"]} ₴",
                                                textAlign: TextAlign.right,
                                                style: GoogleFonts.nunito(
                                                                            textStyle: const TextStyle(
                                                                            color: Color.fromRGBO(31, 31, 47, 1),
                                                                            fontSize: 25,
                                                                            fontWeight: FontWeight.w800))),
                                  statusContainer(order["status"])
                                  ],)])));});})))]));}                          
          }
  }

  Widget statusContainer(String status){
    if(status == 'Виконаний'){
      return Container(
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(13), 
            color: const Color.fromRGBO(166, 255, 166, 0.1),
            border: Border.all(color: const Color.fromRGBO(75, 253, 105, 0.2), width: 1)),
          width: MediaQuery.of(context).size.width*0.35,
          height: MediaQuery.of(context).size.height*0.065,
          alignment: Alignment.center,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Icon(Icons.check, size: 30, color: Color.fromRGBO(75, 253, 105, 0.6),),
              Text(status.toUpperCase(),
                  style: GoogleFonts.nunito(
                                                                            textStyle: const TextStyle(
                                                                            color: Color.fromRGBO(75, 253, 105, 0.6),
                                                                            fontSize: 13,
                                                                            fontWeight: FontWeight.w900))
                                          )],));
    }
    else if(status == 'Відхилений'){
       return Container(
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(13), 
            color: const Color.fromRGBO(255, 166, 166, 0.1),
            border: Border.all(color: const Color.fromRGBO(254, 66, 66, 0.2), width: 1)),
          width: MediaQuery.of(context).size.width*0.35,
          height: MediaQuery.of(context).size.height*0.065,
          alignment: Alignment.center,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Icon(Icons.close_outlined, size: 30, color: Color.fromRGBO(254, 66, 66, 0.4),),
              Text(status.toUpperCase(),
                style: GoogleFonts.nunito(
                                                                            textStyle: const TextStyle(
                                                                            color: Color.fromRGBO(254, 66, 66, 0.4),
                                                                            fontSize: 13,
                                                                            fontWeight: FontWeight.w800))),
                                          ],));
    }
    else{
      return Container(
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(13), 
            color: const Color.fromRGBO(254, 254, 166, 0.1),
            border: Border.all(color: const Color.fromRGBO(254, 204, 66, 0.3), width: 1)),
          width: MediaQuery.of(context).size.width*0.35,
          height: MediaQuery.of(context).size.height*0.07,
          alignment: Alignment.center,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Icon(Iconsax.activity, size: 30, color: Color.fromRGBO(254, 204, 66, 0.8),),
              Text(status.toUpperCase(),
                  style: GoogleFonts.nunito(
                                                                            textStyle: const TextStyle(
                                                                            color: Color.fromRGBO(254, 204, 66, 0.8),
                                                                            fontSize: 13,
                                                                            fontWeight: FontWeight.w800))),
                                          ],));
    }
  }
}

