
import 'package:awesome_page_transitions/awesome_page_transitions.dart';
import 'package:flutter/material.dart';
import 'package:restaraunt_app/authentication.dart';
import 'package:restaraunt_app/login_page.dart';
import 'error_text.dart';
import 'ftoast_controller.dart';


class ResetPasswordPage extends StatefulWidget {
  const ResetPasswordPage({Key? key}) : super(key: key);

  @override
  State<ResetPasswordPage> createState() => _ResetPasswordState();
}

class _ResetPasswordState extends State<ResetPasswordPage> {

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
                            height: MediaQuery.of(context).size.height * 0.1,
                            margin: EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.25),
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
                            )),
                      GestureDetector( child: Container(alignment: Alignment.center,
                                height: MediaQuery.of(context).size.height*0.08,
                                width: MediaQuery.of(context).size.width*0.9,
                                margin: EdgeInsets.only(top: MediaQuery.of(context).size.height*0.07),
                                decoration: BoxDecoration(borderRadius: BorderRadius.circular(15), 
                                            color: mainColor),
                                child: Text("Відновити", 
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
  
  int code = 1;

  void buttonAction() async{
        resetPassword(emailController.value.text);
       FtoastController.showPositiveToast(context, Icons.email_outlined, "Перевірте пошту"); 
       await Future.delayed(const Duration(seconds: 2));
       // ignore: use_build_context_synchronously
       Navigator.push( context,
                                              AwesomePageRoute(
                                                transitionDuration: const Duration(milliseconds: 600),
                                                exitPage: widget,
                                                enterPage: const LoginPage(),
                                                transition: StackTransition(),
                                              ));
    }
}