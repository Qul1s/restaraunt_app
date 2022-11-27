import 'package:flutter/material.dart';
import 'package:im_stepper/stepper.dart';
import 'firebase_controller.dart';
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

  FirebaseController firebaseController = FirebaseController();

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
                            // numbers: const[
                            //     1,
                            //     2,
                            //     3,
                            //     4,
                            // ],
                            // enableNextPreviousButtons: false,
                            // enableStepTapping: false,
                            // stepColor: additionalColor,
                            // numberStyle: TextStyle(color: additionalColor),
                            // activeStepColor: mainColor,
                            // activeStepBorderColor: mainColor,
                            // activeStepBorderPadding: 0,
                            // lineColor: additionalColor,
                            // lineLength: MediaQuery.of(context).size.width*0.1,
                            // lineDotRadius: 1,
                            // stepRadius: MediaQuery.of(context).size.width*0.05,
                            // stepReachedAnimationEffect: Curves.easeIn,
                            // stepReachedAnimationDuration: const Duration(seconds: 10),
                            dotCount: 4,
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
                                child: Text("Увійти", 
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

  void buttonAction(){
    if(emailController.value.text.isEmpty){
      FtoastController.showToast(context, "Заповніть поле");     
    }
    else{
      switch(activeStep){
      case 0:
        mail = firebaseController.setMailOrPhone(emailController.value.text);
        break;
      case 1:
        firebaseController.register(emailController.value.text, passwordController.value.text, mail);
        break;
      case 2:
        firebaseController.setName(emailController.value.text);
        break;
      case 3:
        firebaseController.setAge(emailController.value.text);
        break;
    }
    setState(() {
      emailController.clear();
      if(activeStep != 3){
        activeStep += 1; 
        }
      else{
        activeStep = 0;
        }
     });
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
                                labelText: "Введіть пошту або номер телефону",
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
      case 1: return Column(mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget> [
        Container(
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
      case 2: return Container(
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
                                labelText: "Введіть вашу дату народження",
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

