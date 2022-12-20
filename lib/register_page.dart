import 'dart:math';
// ignore: import_of_legacy_library_into_null_safe
import 'package:awesome_page_transitions/awesome_page_transitions.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:im_stepper/stepper.dart';
import 'package:restaraunt_app/authentication.dart';
import 'package:restaraunt_app/mailer.dart';
import 'package:restaraunt_app/main_screen.dart';
import 'package:scroll_date_picker/scroll_date_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
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
                      alignment: Alignment.center,
                      margin: EdgeInsets.only(top: MediaQuery.of(context).size.height*0.2),
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
                      Container( 
                        alignment: Alignment.center,
                        width: MediaQuery.of(context).size.width*0.9,
                        child: GestureDetector(
                          onTap: () => buttonAction(),
                          child: Container(alignment: Alignment.center,
                                              height: MediaQuery.of(context).size.height*0.07,
                                              width: MediaQuery.of(context).size.width*0.8,
                                              margin: EdgeInsets.only(top: MediaQuery.of(context).size.height*0.04),
                                              decoration: BoxDecoration(borderRadius: BorderRadius.circular(15), 
                                                            color: const Color.fromRGBO(254, 182, 102, 1)),
                                              child: Text("Далі", 
                                                      textAlign: TextAlign.center,
                                                      style: GoogleFonts.poiretOne(
                                                                            textStyle: const TextStyle(
                                                                            color: Color.fromRGBO(240, 240, 240, 1),
                                                                            fontSize: 22,
                                                                            fontWeight: FontWeight.w800)),),  
                                                                        ))),]),
            ),
      ),
    ));
  }

    bool isValidPhoneNumber(String? value) => RegExp(r'(^[\+]?[(]?[0-9]{3}[)]?[-\s\.]?[0-9]{3}[-\s\.]?[0-9]{4,6}$)').hasMatch(value ?? '');
  
    void _setLogin(bool login) async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      prefs.setBool('login', login);
    });
  }
  
    void nextStep(){
    setState(() {
      emailController.clear();
      if(activeStep != 4){
        activeStep += 1; 
        }
      else{
      _setLogin(true);
       Navigator.push( context,
          AwesomePageRoute(
             transitionDuration: const Duration(milliseconds: 600),
             enterPage: const MainScreen(),
             transition: StackTransition(),
           ));
        }
     });
    }

  int code = 1;

  void buttonAction(){
    if(emailController.value.text != "" || _selectedDate!=DateTime.now()){
      switch(activeStep){
        case 0:
        if(emailController.value.text.contains("@")){
           setMail(emailController.value.text);
          Random rnd = Random();
          setState(() {
            code = rnd.nextInt(10000);
          });
          sendToMail(emailController.value.text, code);
          nextStep();
        }
        else{
          FtoastController.showToast(context, "Неправильна пошта");
        }
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
              AuthenticationServices auth = AuthenticationServices();
              auth.createNewUser(emailController.text, context).then((value){
              if (value) {
                nextStep();
              }
              }); 
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
            setBonuses();
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
                            ));
      
      case 5: return Container(
                            height: MediaQuery.of(context).size.height * 0.17,
                            margin: EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.1),
                            alignment: Alignment.topCenter,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                              Text("Введіть дату народження",style: GoogleFonts.poiretOne(
                                    textStyle: TextStyle(
                                    fontSize: 18,
                                    color: additionalColor,
                                  fontWeight: FontWeight.w800)),),
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
                              style: GoogleFonts.poiretOne(
                                    textStyle: TextStyle(
                                    fontSize: 24,
                                    color: additionalColor,
                                  fontWeight: FontWeight.w800)),
                            ));
    }
  }
}

