import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';


class ConnectionErrorPage extends StatefulWidget {
  const ConnectionErrorPage({Key? key}) : super(key: key);

  @override
  State<ConnectionErrorPage> createState() => _ConnectionErrorState();
}

class _ConnectionErrorState extends State<ConnectionErrorPage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Expanded(
                  child:Container(
                                  width: MediaQuery.of(context).size.width* 0.95,
                                  alignment: Alignment.center,
                                  child: Column(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      children: [
                                        Lottie.asset('lottie/connection_error.json',
                                          width: MediaQuery.of(context).size.width* 0.8,
                                          height: MediaQuery.of(context).size.height* 0.3
                                          ),
                                        AutoSizeText("Перевірте своє інтернет з'єднання",
                                            style: GoogleFonts.poiretOne(
                                              textStyle: const TextStyle(
                                              color: Colors.black,
                                              fontSize: 20,
                                              fontWeight: FontWeight.w800)),
                                            minFontSize: 12,
                                            stepGranularity: 2,
                                            textAlign: TextAlign.center),
                                        Lottie.asset('lottie/loading.json',
                                          width: MediaQuery.of(context).size.width* 0.8,
                                          height: MediaQuery.of(context).size.height* 0.3
                                          ),
                                      ])))));
  }

}

  


