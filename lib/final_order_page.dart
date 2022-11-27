import 'package:flutter/material.dart';


 class FinalOrderPage extends StatefulWidget {
    const FinalOrderPage({Key? key}) : super(key: key);

    @override
    State<FinalOrderPage> createState() => _FinalOrderPageState();
  }

  class _FinalOrderPageState extends State<FinalOrderPage> {

    dynamic currentFocus;
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
          child: const Scaffold(
            
          ));
    }
  }