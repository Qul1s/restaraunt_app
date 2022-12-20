
// ignore: import_of_legacy_library_into_null_safe
import 'package:awesome_page_transitions/awesome_page_transitions.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
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
                                labelStyle:  GoogleFonts.poiretOne(
                                                                            textStyle: TextStyle(
                                                                            color: additionalColor,
                                                                            fontSize: 16,
                                                                            fontWeight: FontWeight.w800)),
                              ),
                              style:  GoogleFonts.poiretOne(
                                                                            textStyle: TextStyle(
                                                                            color: additionalColor,
                                                                            fontSize: 16,
                                                                            fontWeight: FontWeight.w800)),
                            )),
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
                                              child: Text("Відновити", 
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