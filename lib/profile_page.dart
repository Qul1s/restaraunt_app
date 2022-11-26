import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:restaraunt_app/about_us.dart';

import 'login_page.dart';
import 'register_page.dart';

class ProfilePage extends StatefulWidget{
    const ProfilePage({Key? key}) : super(key: key);

    @override
    State<ProfilePage> createState() => _ProfilePageState();
  }

  Color additionalColor = const Color.fromRGBO(248, 248, 248, 1);
  Color textColor = const Color.fromRGBO(68, 68,68, 1);
  bool login = true;

  class _ProfilePageState extends State<ProfilePage> with SingleTickerProviderStateMixin{

    @override
    void initState(){
      super.initState();
    }


    @override
    Widget build(BuildContext context) {
      AnimationController animationController = AnimationController(duration: const Duration(milliseconds: 700), vsync: this);
      Animation animationOfAllSum = IntTween(begin: 0, end: 1760).animate(CurvedAnimation(parent: animationController, curve: Curves.easeOut));
      Animation animationOfBonusSum = IntTween(begin: 0, end: 200).animate(CurvedAnimation(parent: animationController, curve: Curves.easeOut));
      Animation animationOfQuantity = IntTween(begin: 0, end: 2).animate(CurvedAnimation(parent: animationController, curve: Curves.easeOut));
      animationController.forward();
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
                                            Navigator.push(context,  MaterialPageRoute(builder: (context)=> const LoginPage()));
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
                                          onTap: () => Navigator.push(context,  MaterialPageRoute(builder: (context)=> const RegisterPage())),
                                          child: Container(alignment: Alignment.center,
                                                  height: MediaQuery.of(context).size.height * 0.03,
                                                  margin: EdgeInsets.only(top: MediaQuery.of(context).size.height*0.015),
                                                  child: Text("Немає акаунту? Зареєструватись", 
                                                  style: GoogleFonts.poiretOne(
                                                                          textStyle: TextStyle(
                                                                          color: Colors.black,
                                                                          fontSize: 16,
                                                                          fontWeight: FontWeight.w800,
                                                                          decoration: TextDecoration.underline,
                                                                          decorationColor: textColor,)))
                                        )),   
                                                        ]))
          ));}
          else{
            return  AnimatedBuilder(animation: animationController, builder: (BuildContext context, child){ 
              return Container(
              padding: EdgeInsets.only(top: MediaQuery.of(context).size.height* 0.02,
                                      bottom: MediaQuery.of(context).size.height* 0.02,
                                      left: MediaQuery.of(context).size.width*0.05,
                                      right: MediaQuery.of(context).size.width*0.05),
              height: MediaQuery.of(context).size.height*0.927,
              width: MediaQuery.of(context).size.width,
              child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Container(
                          alignment: Alignment.center,
                          decoration: BoxDecoration(border: Border.all(color: const Color.fromRGBO(90, 90, 90, 1), width: 1), borderRadius: const BorderRadius.all(Radius.circular(100)),),
                          height: MediaQuery.of(context).size.height*0.13,
                          width: MediaQuery.of(context).size.height*0.13,
                          child: ClipRRect(
                            borderRadius: const BorderRadius.all(Radius.circular(100)),
                            child: Image.asset("images/restaraunt-logo.png",
                              height: MediaQuery.of(context).size.height*0.13,
                              width: MediaQuery.of(context).size.height*0.13, fit: BoxFit.contain,)
                          )),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Container(
                              alignment: Alignment.center,
                              child: Text("Антон Ретюнських", style: GoogleFonts.rubik(
                                                  textStyle: const TextStyle(
                                                    color: Color.fromRGBO(60, 60, 60, 1),
                                                    fontSize: 20,
                                                    fontWeight: FontWeight.w500
                                        ),
                                      ),)),
                            Container(
                              width: MediaQuery.of(context).size.width*0.8,
                              height: MediaQuery.of(context).size.height*0.0005,
                              color: const Color.fromRGBO(60, 60, 60, 1)),]),
                        Container(
                          width: MediaQuery.of(context).size.width*0.8,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Text("${animationOfQuantity.value}", style: GoogleFonts.rubik(
                                    textStyle: const TextStyle(
                                      color: Colors.black,
                                      fontSize: 18,
                                      fontWeight: FontWeight.w500
                                    ))),
                                  Text("Замовлено", style: GoogleFonts.rubik(
                                    textStyle: const TextStyle(
                                      color: Color.fromRGBO(100, 100, 100, 1),
                                      fontSize: 16,
                                      fontWeight: FontWeight.w400
                                    ),
                                  ),)
                                ],),
                              Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Text("${animationOfBonusSum.value}/4000", style: GoogleFonts.rubik(
                                    textStyle: const TextStyle(
                                      color: Colors.black,
                                      fontSize: 18,
                                      fontWeight: FontWeight.w500
                                    ))),
                                  Text("Бонус", style: GoogleFonts.rubik(
                                    textStyle: const TextStyle(
                                      color: Color.fromRGBO(100, 100, 100, 1),
                                      fontSize: 16,
                                      fontWeight: FontWeight.w400
                                    ),
                                  ),)
                                ],),
                              Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Text("${animationOfAllSum.value}₴", style: GoogleFonts.rubik(
                                    textStyle: const TextStyle(
                                      color: Colors.black,
                                      fontSize: 18,
                                      fontWeight: FontWeight.w500
                                    ))),
                                  Text("Сплачено", style: GoogleFonts.rubik(
                                    textStyle: const TextStyle(
                                      color: Color.fromRGBO(100, 100, 100, 1),
                                      fontSize: 16,
                                      fontWeight: FontWeight.w400
                                    ),
                                  ),)
                                ],),
                            ],
                          )),
                          Container(
                             padding: EdgeInsets.only(left: MediaQuery.of(context).size.width*0.05,
                                      right: MediaQuery.of(context).size.width*0.05),
                            height: MediaQuery.of(context).size.height*0.5,
                            width: MediaQuery.of(context).size.width*0.9,
                            decoration: const BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(40)),
                                                            color: Colors.white,),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Container(
                                      alignment: Alignment.center,
                                      height: MediaQuery.of(context).size.width*0.1,
                                      width: MediaQuery.of(context).size.width*0.1,
                                      decoration: const BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(10)),
                                                            color: Color.fromRGBO(230, 230, 230, 1),),
                                      child: const Icon(Icons.settings, size: 25, color: Colors.black),
                                    ),
                                    Container(
                                      width: MediaQuery.of(context).size.width*0.5,
                                      child: Text("Налаштування", style: GoogleFonts.rubik(
                                              textStyle: const TextStyle(
                                                color: Colors.black,
                                                fontSize: 16,
                                                fontWeight: FontWeight.w500
                                              )))),
                                    Container(
                                      width: MediaQuery.of(context).size.width*0.1,
                                      child: const Icon(Icons.arrow_forward_ios_rounded, size: 20, color: Colors.black),
                                    ),
                                  ],
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Container(
                                      height: MediaQuery.of(context).size.width*0.1,
                                      width: MediaQuery.of(context).size.width*0.1,
                                      decoration: const BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(10)),
                                                            color: Color.fromRGBO(230, 230, 230, 1),),
                                      child: const Icon(Icons.home_rounded, size: 25, color: Colors.black),
                                    ),
                                    Container(
                                      width: MediaQuery.of(context).size.width*0.5,
                                      child: Text("Збереження адреси", style: GoogleFonts.rubik(
                                              textStyle: const TextStyle(
                                                color: Colors.black,
                                                fontSize: 16,
                                                fontWeight: FontWeight.w500
                                              )))),
                                    Container(
                                      width: MediaQuery.of(context).size.width*0.1,
                                      child: const Icon(Icons.arrow_forward_ios_rounded, size: 20, color: Colors.black),
                                    ),
                                  ],
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Container(
                                      height: MediaQuery.of(context).size.width*0.1,
                                      width: MediaQuery.of(context).size.width*0.1,
                                      decoration: const BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(10)),
                                                            color: Color.fromRGBO(230, 230, 230, 1),),
                                      child: const Icon(Icons.people_alt_rounded, size: 25, color: Colors.black),
                                    ),
                                    Container(
                                      width: MediaQuery.of(context).size.width*0.5,
                                      child: Text("Мій профіль", style: GoogleFonts.rubik(
                                              textStyle: const TextStyle(
                                                color: Colors.black,
                                                fontSize: 16,
                                                fontWeight: FontWeight.w500
                                              )))),
                                    Container(
                                      width: MediaQuery.of(context).size.width*0.1,
                                      child: const Icon(Icons.arrow_forward_ios_rounded, size: 20, color: Colors.black),
                                    ),
                                  ],
                                ),
                                Container(
                                  height: MediaQuery.of(context).size.height*0.0005,
                                  width: MediaQuery.of(context).size.width*0.7,
                                  color: const Color.fromRGBO(90, 90, 90, 1)),
                                GestureDetector(
                                  onTap: () => Navigator.push(context,  MaterialPageRoute(builder: (context)=> const AboutUsPage())),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                      children: [
                                        Container(
                                          height: MediaQuery.of(context).size.width*0.1,
                                          width: MediaQuery.of(context).size.width*0.1,
                                          decoration: const BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(10)),
                                                                color: Color.fromRGBO(230, 230, 230, 1),),
                                          child: const Icon(Icons.info_outline_rounded, size: 25, color: Colors.black),
                                        ),
                                        Container(
                                          width: MediaQuery.of(context).size.width*0.5,
                                          child: Text("Інформація про нас", style: GoogleFonts.rubik(
                                                  textStyle: const TextStyle(
                                                    color: Colors.black,
                                                    fontSize: 16,
                                                    fontWeight: FontWeight.w500
                                                  )))),
                                        Container(
                                          width: MediaQuery.of(context).size.width*0.1,
                                          child: const Icon(Icons.arrow_forward_ios_rounded, size: 20, color: Colors.black),
                                        ),
                                      ],
                                    )),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Container(
                                      height: MediaQuery.of(context).size.width*0.1,
                                      width: MediaQuery.of(context).size.width*0.1,
                                      decoration: const BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(10)),
                                                            color: Color.fromRGBO(230, 230, 230, 1),),
                                      child: const Icon(Icons.logout_rounded, size: 25, color: Colors.black),
                                    ),
                                    Container(
                                      width: MediaQuery.of(context).size.width*0.5,
                                      child: Text("Вихід", style: GoogleFonts.rubik(
                                              textStyle: const TextStyle(
                                                color: Colors.black,
                                                fontSize: 16,
                                                fontWeight: FontWeight.w500
                                              )))),
                                    Container(
                                      width: MediaQuery.of(context).size.width*0.1,
                                      child: const Icon(Icons.arrow_forward_ios_rounded, size: 20, color: Colors.black),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          )
                      ],
            ));});                          
          }
  }

  }