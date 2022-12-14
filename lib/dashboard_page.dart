
// ignore: import_of_legacy_library_into_null_safe
import 'package:awesome_page_transitions/awesome_page_transitions.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:restaraunt_app/main_screen.dart';

class DashboardPage extends StatefulWidget {
    const DashboardPage({Key? key}) : super(key: key);

    @override
    State<DashboardPage> createState() => _DashboardPageState();
  }

  class _DashboardPageState extends State<DashboardPage> {

     @override
    Widget build(BuildContext context) {
      return GestureDetector( 
        onTap:() {
          Navigator.push( context,
                                              AwesomePageRoute(
                                                transitionDuration: const Duration(milliseconds: 600),
                                                enterPage: const MainScreen(),
                                                transition: StackTransition(),
                                              ));
        },
        child: Expanded(
                            child:Container(
                                            color: const Color.fromRGBO(254, 182, 102, 1),
                                            height: MediaQuery.of(context).size.height,
                                            width: MediaQuery.of(context).size.width,
                                            alignment: Alignment.center,
                                            child: Column(
                                                mainAxisAlignment: MainAxisAlignment.center,
                                                crossAxisAlignment: CrossAxisAlignment.center,
                                                children: [
                                                  Lottie.asset('lottie/done.json',
                                                      width: MediaQuery.of(context).size.width* 0.8,
                                                      height: MediaQuery.of(context).size.height* 0.3
                                                      ),
                                                  Text("Успіх",
                                                      style: GoogleFonts.poiretOne(
                                                        textStyle: const TextStyle(
                                                        color: Colors.black,
                                                        decoration: TextDecoration.none,
                                                        fontSize: 24,
                                                        fontWeight: FontWeight.w800)),
                                                      textAlign: TextAlign.center),
                                                ]))));

  }
  }