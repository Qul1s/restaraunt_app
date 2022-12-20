// ignore: import_of_legacy_library_into_null_safe
import 'package:awesome_page_transitions/awesome_page_transitions.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:restaraunt_app/ftoast_controller.dart';
import 'package:restaraunt_app/main_screen.dart';
import 'package:restaraunt_app/register_page.dart';
import 'package:restaraunt_app/reset_password.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'authentication.dart';
import 'error_text.dart';


class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginState();
}

class _LoginState extends State<LoginPage> {

  Color mainColor = const Color.fromRGBO(254, 182, 102, 1);
  Color additionalColor = const Color.fromRGBO(40, 40, 40, 1);

  // ignore: prefer_typing_uninitialized_variables
  var currentFocus;
  // ignore: prefer_final_fields
  var _text = '';
  final bool _submitted = false;

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  

  unfocus() {
    currentFocus = FocusScope.of(context);
    if (!currentFocus.hasPrimaryFocus) {
      currentFocus.unfocus();
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
            onTap: unfocus,
            child: Scaffold(
      body: Center(
        child: Stack(
          children: <Widget>[
          Container(padding: EdgeInsets.only(
                        left: MediaQuery.of(context).size.width * 0.07,
                        right: MediaQuery.of(context).size.width * 0.07),
            child: Column(mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
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
                              margin: EdgeInsets.only(top: MediaQuery.of(context).size.height* 0.04),
                              width: MediaQuery.of(context).size.width* 0.1,
                              height: MediaQuery.of(context).size.width* 0.1,
                              child: const Icon(Icons.arrow_back_outlined, size: 30, color: Color.fromRGBO(31, 31, 47, 1),)
                          )),
                      Container(
                            margin: EdgeInsets.only(top: MediaQuery.of(context).size.height*0.2),
                            height: MediaQuery.of(context).size.height * 0.1,
                            alignment: Alignment.topCenter,
                            child: TextField(
                              onChanged: (text) => setState(() => _text),
                              controller: emailController,
                              obscureText: false,
                              textAlign: TextAlign.left,
                              cursorColor: const Color.fromRGBO(40, 40, 40, 1),
                              textAlignVertical: TextAlignVertical.bottom,
                              decoration: InputDecoration(
                                errorText: _submitted
                                    ? errorText(emailController)
                                    : null,
                                focusedBorder: UnderlineInputBorder(
                                    borderSide:
                                        BorderSide(color: additionalColor, width: 3)),
                                enabledBorder: UnderlineInputBorder(
                                    borderSide:
                                        BorderSide(color: additionalColor, width: 3)),
                                border: UnderlineInputBorder(
                                    borderSide:
                                        BorderSide(color: additionalColor, width: 3)),
                                labelText: 'Введіть пошту',
                                labelStyle: GoogleFonts.poiretOne(
                                          textStyle: TextStyle(
                                    fontSize: 16,
                                    color: additionalColor,
                                  fontWeight: FontWeight.w800)),
                              ),
                              style: GoogleFonts.poiretOne(
                                          textStyle: TextStyle(
                                  fontSize: 16,
                                  color: additionalColor,
                                  fontWeight: FontWeight.w800)),
                            )),
                      Container(
                            height: MediaQuery.of(context).size.height * 0.1,
                            margin: EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.02),
                            alignment: Alignment.topCenter,
                            child: TextField(
                              controller: passwordController,
                              obscureText: true,
                              cursorColor: const Color.fromRGBO(40, 40, 40, 1),
                              decoration: InputDecoration(
                                errorText: _submitted
                                    ? errorText(passwordController)
                                    : null,
                                focusedBorder: UnderlineInputBorder(
                                    borderSide:
                                        BorderSide(color: additionalColor, width: 3)),
                                enabledBorder: UnderlineInputBorder(
                                    borderSide:
                                        BorderSide(color: additionalColor, width: 3)),
                                border: UnderlineInputBorder(
                                    borderSide:
                                        BorderSide(color: additionalColor, width: 3)),
                                labelText: 'Введіть пароль',
                                labelStyle: GoogleFonts.poiretOne(
                                    textStyle: TextStyle(
                                    fontSize: 16,
                                    color: additionalColor,
                                  fontWeight: FontWeight.w800)),
                              ),
                              style: GoogleFonts.poiretOne(
                                          textStyle: TextStyle(
                                            fontSize: 16,
                                            color: additionalColor,
                                            fontWeight: FontWeight.w400)),
                              textAlign: TextAlign.left,
                            )),
                      GestureDetector(
                        onTap: () => buttonResetAction(),
                        child: Container(alignment: Alignment.centerRight,
                                height: MediaQuery.of(context).size.height * 0.03,
                                child: Text("Забули пароль?", 
                                          style: GoogleFonts.poiretOne(
                                          textStyle: TextStyle(
                                            color: additionalColor,
                                            fontSize: 16,
                                            fontWeight: FontWeight.w800,
                                            decoration: TextDecoration.underline,
                                            decorationColor: additionalColor,
                                          ))))
                                ),
                      Container( 
                        alignment: Alignment.center,
                        width: MediaQuery.of(context).size.width*0.9,
                        child: GestureDetector(
                          onTap: () => buttonLoginAction(),
                          child: Container(alignment: Alignment.center,
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
                                                                        ))),                            
                     GestureDetector(
                                          onTap: () => Navigator.push( context,
                                              AwesomePageRoute(
                                                transitionDuration: const Duration(milliseconds: 600),
                                                enterPage: const RegisterPage(),
                                                transition: StackTransition(),
                                              )),
                                          child: Container(alignment: Alignment.center,
                                                  height: MediaQuery.of(context).size.height * 0.03,
                                                  margin: EdgeInsets.only(top: MediaQuery.of(context).size.height*0.02),
                                                  child: Text("Немає акаунту? Зареєструватись", 
                                                  style: GoogleFonts.poiretOne(
                                                                          textStyle: const TextStyle(
                                                                          color: Colors.black,
                                                                          fontSize: 16,
                                                                          fontWeight: FontWeight.w800,
                                                                          decoration: TextDecoration.underline,
                                                                          decorationColor: Colors.black,)))
                                        )),
                ]),
            ),
          ],
        ),
      ),
    ));
  }

void buttonResetAction(){
   Navigator.push( context,
                                              AwesomePageRoute(
                                                transitionDuration: const Duration(milliseconds: 600),
                                                exitPage: widget,
                                                enterPage: const ResetPasswordPage(),
                                                transition: StackTransition(),
                                              ));
}

void buttonRegisterAction(){
  Navigator.push( context,
                                              AwesomePageRoute(
                                                transitionDuration: const Duration(milliseconds: 600),
                                                exitPage: widget,
                                                enterPage: const RegisterPage(),
                                                transition: StackTransition(),
                                              ));
}

void buttonLoginAction(){
   if (emailController.value.text.isNotEmpty) {
      if (passwordController.value.text.isNotEmpty) {
          AuthenticationServices auth = AuthenticationServices();
              auth.loginUser(emailController.text, passwordController.text, context).then((value){
              if (value) {
                Navigator.push( context,
                  AwesomePageRoute(
                    transitionDuration: const Duration(milliseconds: 600),
                    exitPage: widget,
                    enterPage: const MainScreen(),
                    transition: StackTransition()));
              _setLogin(true);
              }
              }); 
          }
        else{
          FtoastController.showToast(context, "Введіть пароль");
        }
    }
    else{
      FtoastController.showToast(context, "Введіть номер телефону");
     }
  }

 void _setLogin(bool login) async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      prefs.setBool('login', login);
    });
  }

}

