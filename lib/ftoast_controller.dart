import 'package:flutter/material.dart';
import 'package:ftoast/ftoast.dart';
import 'package:fsuper/fsuper.dart';

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
            style: const TextStyle(color:Colors.black, 
                                  fontFamily: "uaBrand", 
                                  fontSize: 20, 
                                  fontWeight: FontWeight.normal,),
            backgroundColor: const Color.fromRGBO(255, 255, 255, 0),
            child2: Container(
              decoration: const BoxDecoration(shape: BoxShape.circle, color:Color.fromRGBO(255, 0, 0, 0.3),),
              height: MediaQuery.of(context).size.height * 0.06,
              width: MediaQuery.of(context).size.width * 0.06,
              alignment: Alignment.center,
              child: const Icon(Icons.close_sharp, color: Colors.white, size:15)),
            child2Margin: EdgeInsets.only(left: MediaQuery.of(context).size.height * 0.027),
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


  
}
