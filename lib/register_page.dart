import 'dart:math';
import 'package:awesome_page_transitions/awesome_page_transitions.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:im_stepper/stepper.dart';
import 'package:restaraunt_app/authentication.dart';
import 'package:restaraunt_app/mailer.dart';
import 'package:restaraunt_app/main_screen.dart';
import 'package:scroll_date_picker/scroll_date_picker.dart';
import 'error_text.dart';
import 'ftoast_controller.dart';


class RegisterPage extends StatefulWidget {
  const RegisterPage({Key? key}) : super(key: key);

  @override
  State<RegisterPage> createState() => _RegisterState();
}

class _RegisterState extends State<RegisterPage> {

  Color mainColor = const Color.fromRGBO(254, 182, 102, 1);
  Color additionalColor = const Color.fromRGBO(40, 40, 40, 1);

  // ignore: prefer_typing_uninitialized_variables
  var currentFocus;
  // ignore: prefer_final_fields
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  // ignore: prefer_final_fields
  bool _submitted = false;
  // ignore: prefer_final_fields
  var _text = '';
  var secondText ='';
  int activeStep = 0;
  bool mail = false;
  
  DateTime _selectedDate = DateTime.now();


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
        child: Container(padding: EdgeInsets.only(
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
                      margin: EdgeInsets.only(top: MediaQuery.of(context).size.height*0.15),
                      child: DotStepper(
                            dotCount: 5,
                            dotRadius: MediaQuery.of(context).size.width * 0.03,
                            shape: Shape.circle,
                            spacing: MediaQuery.of(context).size.width * 0.1,        
                            indicator: Indicator.slide,
                            tappingEnabled: true,
                            lineConnectorsEnabled: true,
                            fixedDotDecoration: FixedDotDecoration(
                                  strokeColor: mainColor,
                                  strokeWidth: 0,
                                  color: additionalColor,
                                ),
                            indicatorDecoration: IndicatorDecoration(
                              strokeColor: mainColor,
                              strokeWidth: 0,
                              color: mainColor,
                            ),
                            lineConnectorDecoration: LineConnectorDecoration(
                              color: additionalColor,
                              linePadding: 7,
                              strokeWidth: 1,
                            ),
                            activeStep: activeStep,
                          )),
                      textFieldRegister(activeStep),
                      GestureDetector( child: Container(alignment: Alignment.center,
                                height: MediaQuery.of(context).size.height*0.08,
                                width: MediaQuery.of(context).size.width*0.9,
                                margin: EdgeInsets.only(top: MediaQuery.of(context).size.height*0.07),
                                decoration: BoxDecoration(borderRadius: BorderRadius.circular(15), 
                                            color: mainColor),
                                child: Text("Далі", 
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                              color: additionalColor,
                                              fontSize: 24,
                                              fontFamily: "uaBrand",
                                              fontWeight: FontWeight.w400
                                              )),  
                                                        ),
                              onTap: (){
                                buttonAction();
                              },),]),
            ),
      ),
    ));
  }

    bool isValidPhoneNumber(String? value) => RegExp(r'(^[\+]?[(]?[0-9]{3}[)]?[-\s\.]?[0-9]{3}[-\s\.]?[0-9]{4,6}$)').hasMatch(value ?? '');
  
    void nextStep(){
    setState(() {
      emailController.clear();
      if(activeStep != 5){
        activeStep += 1; 
        }
      else{
       Navigator.push( context,
                                              AwesomePageRoute(
                                                transitionDuration: const Duration(milliseconds: 600),
                                                exitPage: widget,
                                                enterPage: const RegisterPage(),
                                                transition: StackTransition(),
                                              ));
        }
     });
    }

  int code = 1;

  void buttonAction(){
    if(emailController.value.text.isNotEmpty || _selectedDate != DateTime.now()){
      switch(activeStep){
      case 0:
        setMail(emailController.value.text);
        Random rnd = Random();
        setState(() {
          code = rnd.nextInt(10000);
        });
        sendToMail(emailController.value.text, code);
        nextStep();
        break;
      case 1:
        if(code == int.parse(emailController.value.text)){
          nextStep();
        }
        else{
           FtoastController.showToast(context, "Неправильний код");
        }
        break;
      case 2:
        if(emailController.value.text == passwordController.value.text){
            bool result = createUser(emailController.text);
            if (result == true) {
              nextStep();
            } 
            else {
              FtoastController.showToast(context, "Сталася помилка, спробуйте ще"); 
            }  
          }
          else{
            FtoastController.showToast(context, "Паролі не збігаються");  
          } 
          break;
      case 3:
         if(isValidPhoneNumber(emailController.value.text)){
          setPhoneNumber(emailController.value.text);
          nextStep();
        }
        else{
          FtoastController.showToast(context, "Неправильний номер");  
        } 
        break;
      case 4:
          setName(emailController.value.text);
          nextStep();
        break;
      case 5:
        if(_selectedDate.isBefore(DateTime.now()) && _selectedDate.isAfter(DateTime(1900))){
          setAge(_selectedDate.toString());
          nextStep();
        }
        else{
          FtoastController.showToast(context, "Неправильна дата");  
        } 
        break; 
    }
    }
    else{
       FtoastController.showToast(context, "Заповніть поле"); 
    }
  }

  


  Widget textFieldRegister(int index){
    switch(index){
      case 0: return Container(
                            height: MediaQuery.of(context).size.height * 0.1,
                            margin: EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.1),
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
                                labelText: "Введіть пошту",
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
                            ));
      case 1: return Container(
                            height: MediaQuery.of(context).size.height * 0.1,
                            margin: EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.1),
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
                                labelText: "Введіть код, відправлений на пошту",
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
                            ));
      case 2: return Column(mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget> [
        Container(
                            height: MediaQuery.of(context).size.height * 0.1,
                            margin: EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.1),
                            alignment: Alignment.topCenter,
                            child: TextField(
                              onChanged: (text) => setState(() => _text),
                              controller: emailController,
                              obscureText: true,
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
                                labelText: "Введіть пароль",
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
                            margin: EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.01),
                            alignment: Alignment.topCenter,
                            child: TextField(
                              onChanged: (text) => setState(() => secondText),
                              controller: passwordController,
                              obscureText: true,
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
                                labelText: "Підтвердіть пароль",
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
                            ))]);  
      case 3: return Container(
                            height: MediaQuery.of(context).size.height * 0.1,
                            margin: EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.1),
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
                                labelText: "Введіть номер телефону",
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
                            ));                 
      case 4: return Container(
                            height: MediaQuery.of(context).size.height * 0.1,
                            margin: EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.1),
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
                                labelText: "Введіть ваше ім'я",
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
                            ));
      
      case 5: return Container(
                            height: MediaQuery.of(context).size.height * 0.17,
                            margin: EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.1),
                            alignment: Alignment.topCenter,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                              Text("Введіть дату народження",style: GoogleFonts.montserrat(
                                    textStyle: const TextStyle(
                                      color: Colors.black,
                                      fontSize: 18,
                                      fontWeight: FontWeight.w400
                                    ),
                                  )),
                          Container(
                            height: MediaQuery.of(context).size.height * 0.1,
                            margin: EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.02),
                            alignment: Alignment.topCenter,
                            child: ScrollDatePicker(
                                selectedDate: _selectedDate,
                                locale: const Locale('en'),
                                onDateTimeChanged: (DateTime value) {
                                  setState(() {
                                    _selectedDate = value;
                                  });
                                },
                            ))
                            ]));
      default: return Container(
                            height: MediaQuery.of(context).size.height * 0.1,
                            margin: EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.1),
                            alignment: Alignment.topCenter,
                            child: Text(
                              "Cталася помилка",
                              style: TextStyle(
                                  fontSize: 24,
                                  color: additionalColor,
                                  fontFamily: "uaBrand",
                                  fontWeight: FontWeight.w400),
                            ));
    }
  }
}

