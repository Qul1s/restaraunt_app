import 'package:flutter/material.dart';
import 'package:restaraunt_app/ftoast_controller.dart';
import 'package:restaraunt_app/main_screen.dart';
import 'package:restaraunt_app/register_page.dart';
import 'package:restaraunt_app/social_login_button.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'authentication.dart';
import 'error_text.dart';


class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginState();
}

class _LoginState extends State<LoginPage> {

  Color mainColor = const Color.fromRGBO(255, 105, 49, 1);
  Color additionalColor = const Color.fromRGBO(40, 40, 40, 1);

  // ignore: prefer_typing_uninitialized_variables
  var currentFocus;
  // ignore: prefer_final_fields
  var _text = '';
  final bool _submitted = false;

  TextEditingController phoneNumberController = TextEditingController();
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
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                        GestureDetector( 
                                onTap: () {
                                  Navigator.pop(context);
                                }, 
                          child:Container(
                            margin: EdgeInsets.only(top: MediaQuery.of(context).size.height*0.07),
                            alignment: Alignment.topLeft,
                            child: Icon(Icons.arrow_back_outlined, size: 45, color: additionalColor)
                          )),
                      Container(
                            margin: EdgeInsets.only(top: MediaQuery.of(context).size.height*0.2),
                            height: MediaQuery.of(context).size.height * 0.1,
                            alignment: Alignment.topCenter,
                            child: TextField(
                              onChanged: (text) => setState(() => _text),
                              controller: phoneNumberController,
                              obscureText: false,
                              textAlign: TextAlign.left,
                              cursorColor: const Color.fromRGBO(40, 40, 40, 1),
                              textAlignVertical: TextAlignVertical.bottom,
                              decoration: InputDecoration(
                                errorText: _submitted
                                    ? errorText(phoneNumberController)
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
                                labelText: 'Введіть номер телефону',
                                labelStyle: TextStyle(
                                    fontSize: 16,
                                    color: additionalColor,
                                    fontFamily: "uaBrand",
                                  fontWeight: FontWeight.w400),
                              ),
                              style: TextStyle(
                                  fontSize: 16,
                                  color: additionalColor,
                                  fontFamily: "uaBrand",
                                  fontWeight: FontWeight.w400),
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
                                labelStyle: TextStyle(
                                    fontSize: 16,
                                    color: additionalColor,
                                    fontFamily: "uaBrand",
                                  fontWeight: FontWeight.w400),
                              ),
                              style: TextStyle(
                                  fontSize: 16,
                                  color: additionalColor,
                                  fontFamily: "uaBrand",
                                  fontWeight: FontWeight.w400),
                              textAlign: TextAlign.left,
                            )),
                      Container(alignment: Alignment.centerRight,
                                height: MediaQuery.of(context).size.height * 0.03,
                                child: Text("Забули пароль?", 
                                          style: TextStyle(
                                            color: additionalColor,
                                            fontSize: 16,
                                            fontFamily: "uaBrand",
                                            fontWeight: FontWeight.w300,
                                            decoration: TextDecoration.underline,
                                            decorationColor: additionalColor,
                                          ))
                                ),
                      GestureDetector(
                        onTap: () => buttonAction(),
                        child:Container(alignment: Alignment.center,
                                height: MediaQuery.of(context).size.height*0.08,
                                width: MediaQuery.of(context).size.width*0.9,
                                margin: EdgeInsets.only(top: MediaQuery.of(context).size.height*0.05),
                                decoration: BoxDecoration(borderRadius: BorderRadius.circular(15), 
                                            color: mainColor),
                                child: const Text("Увійти",
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 22,
                                              fontFamily: "uaBrand",
                                              fontWeight: FontWeight.w400
                                              )),  
                                                        ),),                             
                      Container(  
                                  alignment: Alignment.centerLeft,
                                  margin: EdgeInsets.only(top: MediaQuery.of(context).size.height*0.04),
                                  height: MediaQuery.of(context).size.height*0.07,
                                  width: MediaQuery.of(context).size.width*0.9,
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      const LoginWithContainer(type: SocialLoginButtonType.google),
                                      Container(
                                        margin: EdgeInsets.only(left: MediaQuery.of(context).size.width*0.03),
                                        child: const LoginWithContainer(type: SocialLoginButtonType.apple)),
                                      Container(
                                        margin: EdgeInsets.only(left: MediaQuery.of(context).size.width*0.03),
                                        child: const LoginWithContainer(type: SocialLoginButtonType.facebook)),
                                      ]
                                    ),
                          ),
                ]),
            ),
          ],
        ),
      ),
    ));
  }


void buttonAction(){
   if (phoneNumberController.value.text.isNotEmpty) {
    if(isValidPhoneNumber(phoneNumberController.value.text)){
      if (passwordController.value.text.isNotEmpty) {
        loginUser(phoneNumberController.text, passwordController.text).then((value){
          bool result = value;
          if (result == true) {
              Navigator.push(context, MaterialPageRoute(builder: (context)=> const MainScreen()));
              _setLogin(true);
              } 
          else {
            FtoastController.showToast(context, "Неправильний пароль");
          }
        });    
        }
        else{
          FtoastController.showToast(context, "Введіть пароль");
        }
    }
    else{
      FtoastController.showToast(context, "Неправильний номер");
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

  bool isValidPhoneNumber(String? value) => RegExp(r'(^[\+]?[(]?[0-9]{3}[)]?[-\s\.]?[0-9]{3}[-\s\.]?[0-9]{4,6}$)').hasMatch(value ?? '');

}

