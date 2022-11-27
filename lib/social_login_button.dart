import 'package:flutter/material.dart';


class LoginWithContainer extends StatelessWidget{
  const LoginWithContainer({Key? key, required this.type}) : super(key: key);
  
  final SocialLoginButtonType type;

  @override
  Widget build(BuildContext context) {
    return SocialLoginButton(
            buttonType: type,
            backgroundColor: Colors.white,
            borderRadius: 20,
            width: MediaQuery.of(context).size.height*0.07,
            height: MediaQuery.of(context).size.height*0.07,
  ); 
  } 
}


enum SocialLoginButtonType {
  facebook,
  google,
  apple,
  appleBlack
}

// ignore: must_be_immutable
class SocialLoginButton extends StatelessWidget {
  SocialLoginButton({
    Key? key,
    required this.buttonType,
    required this.backgroundColor,
    required this.height,
    required this.borderRadius,
    required this.width,
  }) : super(key: key);

  final SocialLoginButtonType buttonType;
  Color? backgroundColor;
  double? height;
  double? borderRadius;
  double? width;

  final _defaultImagePath = "images/";

  @override
  Widget build(BuildContext context) {
    String? imageName;

    switch (buttonType) {
      case SocialLoginButtonType.facebook:
        imageName = "${_defaultImagePath}facebook-logo.png";
        break;
      case SocialLoginButtonType.google:
        imageName = "${_defaultImagePath}google-logo.png";
        break;
      case SocialLoginButtonType.apple:
        imageName = "${_defaultImagePath}apple-logo.png";
        break;
      case SocialLoginButtonType.appleBlack:
        imageName = "${_defaultImagePath}apple-black-logo.png";
        break;
    }
  
    return _LoginButton(
      imagePath: imageName,
      backgroundColor: backgroundColor,
      height: height!,
      borderRadius: borderRadius!,
      width: width,
    );
  }
}

class _LoginButton extends StatelessWidget {
  const _LoginButton({
    Key? key,
    this.backgroundColor,
    required this.height,
    required this.imagePath,
    required this.borderRadius,
    required this.width,
  }) : super(key: key);

  final String? imagePath;
  final Color? backgroundColor;
  final double height;
  final double? width;
  final double borderRadius;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        height: height,
        width: width,
        padding: EdgeInsets.all(MediaQuery.of(context).size.height*0.017),
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(15), 
                                  color: backgroundColor),
        child: Image.asset(imagePath.toString(), 
                              alignment: Alignment.center)
      ),
    );
  }

}