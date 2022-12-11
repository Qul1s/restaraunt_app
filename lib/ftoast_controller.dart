import 'package:flutter/material.dart';
import 'package:ftoast/ftoast.dart';
import 'package:fsuper/fsuper.dart';
import 'package:google_fonts/google_fonts.dart';

class FtoastController{
    static void showToast(BuildContext context, String text){
      FToast.toast(
      context,
      padding: const EdgeInsets.all(0),
      toast: FSuper(
            width: MediaQuery.of(context).size.width * 0.7,
            height: MediaQuery.of(context).size.height * 0.07,
            textAlignment: Alignment.center,
            textAlign: TextAlign.left,
            text: text,
            style: GoogleFonts.poiretOne(
                                    textStyle: const TextStyle(
                                    color: Colors.black,
                                    fontSize: 18,
                                    fontWeight: FontWeight.w800)),
            backgroundColor: const Color.fromRGBO(255, 255, 255, 0),
            child2: Container(
              decoration: const BoxDecoration(shape: BoxShape.circle, color:Color.fromRGBO(255, 0, 0, 0.3),),
              height: MediaQuery.of(context).size.height * 0.06,
              width: MediaQuery.of(context).size.width * 0.06,
              alignment: Alignment.center,
              child: const Icon(Icons.close_sharp, color: Colors.white, size:15)),
            child2Margin: EdgeInsets.only(left: MediaQuery.of(context).size.height * 0.015),
            child2Alignment: Alignment.centerLeft,
            cornerStyle: FCornerStyle.round,
            corner: FCorner.all(25),
            shadowColor: const Color.fromRGBO(255, 0, 0, 0.5),
            shadowBlur: 50,
            margin: EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.7, 
                                    left: MediaQuery.of(context).size.height * 0.04),
          ),
    );
  }

  static void showPositiveToast(BuildContext context, IconData icon, String text){
      FToast.toast(
      context,
      padding: const EdgeInsets.all(0),
      toast: FSuper(
            width: MediaQuery.of(context).size.width * 0.7,
            height: MediaQuery.of(context).size.height * 0.07,
            textAlignment: Alignment.center,
            textAlign: TextAlign.left,
            text: text,
            style: GoogleFonts.poiretOne(
                                    textStyle: const TextStyle(
                                    color: Colors.black,
                                    fontSize: 18,
                                    fontWeight: FontWeight.w800)),
            backgroundColor: const Color.fromRGBO(255, 255, 255, 0),
            child2: Container(
              decoration: BoxDecoration(shape: BoxShape.circle, color:Colors.green.withOpacity(0.3),),
              height: MediaQuery.of(context).size.height * 0.06,
              width: MediaQuery.of(context).size.width * 0.06,
              alignment: Alignment.center,
              child: Icon(icon, color: Colors.white, size:15)),
            child2Margin: EdgeInsets.only(left: MediaQuery.of(context).size.height * 0.015),
            child2Alignment: Alignment.centerLeft,
            cornerStyle: FCornerStyle.round,
            corner: FCorner.all(25),
            shadowColor: Colors.green.withOpacity(0.5),
            shadowBlur: 50,
            margin: EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.7, 
                                    left: MediaQuery.of(context).size.height * 0.04),
          ),
    );
  }


  
}
