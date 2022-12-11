import 'package:awesome_page_transitions/awesome_page_transitions.dart';
import 'package:flutter/material.dart';
import 'login_page.dart';
import 'social_login_button.dart';


class StartPage extends StatefulWidget {
  const StartPage({Key? key}) : super(key: key);

  @override
  State<StartPage> createState() => _StartState();
}

class _StartState extends State<StartPage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Stack(
          clipBehavior: Clip.none,
          children: <Widget>[
           SizedBox(height: MediaQuery.of(context).size.height,
                     width: MediaQuery.of(context).size.width,
                     child: Image.asset("images/login_background.jpg", 
                                         fit: BoxFit.fill)),
          Column(mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                     Container(margin: EdgeInsets.only(top: MediaQuery.of(context).size.height*0.6,
                                                        left: MediaQuery.of(context).size.width*0.05),
                      child: const Text("Ви не увійшли в свій акаунт", 
                            textAlign: TextAlign.left,
                            style: TextStyle(
                                    color: Color.fromRGBO(240, 240, 240, 1),
                                    fontSize: 40,
                                    fontFamily: "uaBrand",
                                    fontWeight: FontWeight.w700
                                    )),),
                                            GestureDetector(
                          onTap: (() {
                            buttonAction();
                            }),
                          behavior: HitTestBehavior.translucent,
                          child: Container(alignment: Alignment.center,
                                height: MediaQuery.of(context).size.height*0.08,
                                width: MediaQuery.of(context).size.width*0.9,
                                margin: EdgeInsets.only(top: MediaQuery.of(context).size.height*0.04,
                                                        left: MediaQuery.of(context).size.width*0.05),
                                decoration: BoxDecoration(borderRadius: BorderRadius.circular(15), 
                                            color: const Color.fromRGBO(255, 105, 49, 1)),
                                child: const Text("Увійти", 
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                              color: Color.fromRGBO(240, 240, 240, 1),
                                              fontSize: 24,
                                              fontFamily: "uaBrand",
                                              fontWeight: FontWeight.w400
                                              )),  
                                                        ),),
                            Container(
                                  margin: EdgeInsets.only(top: MediaQuery.of(context).size.height*0.03,
                                                          left: MediaQuery.of(context).size.width*0.05),
                                  height: MediaQuery.of(context).size.height*0.07,
                                  width: MediaQuery.of(context).size.width*0.5,
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: const[
                                      LoginWithContainer(type: SocialLoginButtonType.google),
                                      LoginWithContainer(type: SocialLoginButtonType.apple),
                                      LoginWithContainer(type: SocialLoginButtonType.facebook),
                                      ]
                                    ),
                          ),]),
          ],
        ),
      ),
    );
  }


  void buttonAction(){
    Navigator.push( context,
                                              AwesomePageRoute(
                                                transitionDuration: const Duration(milliseconds: 600),
                                                exitPage: widget,
                                                enterPage: const LoginPage(),
                                                transition: StackTransition(),
                                              ));
  }
}

  


