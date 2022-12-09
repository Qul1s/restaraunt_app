import 'dart:convert';

import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
// ignore: depend_on_referenced_packages
import 'package:latlong2/latlong.dart';
import 'package:url_launcher/url_launcher.dart';

class AboutUsPage extends StatefulWidget {
     const AboutUsPage({Key? key, 
    }) : super(key: key);

    @override
    // ignore: no_logic_in_create_state
    State<AboutUsPage> createState() => _AboutUsPageState();
  }

  class _AboutUsPageState extends State<AboutUsPage> {

    _AboutUsPageState();
    dynamic info ='';

    void getData(){
      final ref = FirebaseDatabase.instance.ref('About');

      Stream<DatabaseEvent> stream = ref.onValue;
      stream.listen((DatabaseEvent event) {
        setState(() {
          info = jsonDecode(jsonEncode(event.snapshot.value)) as Map<String, dynamic>;
        });
      });
    }

    @override
    void initState(){
      getData();
      super.initState();    
  }
    @override
    Widget build(BuildContext context) {
      return Scaffold(
        backgroundColor: const Color.fromRGBO(240, 240, 240, 1),
        body: Column( 
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                          Container(
                            alignment: Alignment.center,
                            margin: EdgeInsets.only(left: MediaQuery.of(context).size.width* 0.23,
                                                    top: MediaQuery.of(context).size.height* 0.04),
                            width: MediaQuery.of(context).size.width* 0.5,
                            height: MediaQuery.of(context).size.height* 0.04,
                            child: Text("Про нас", 
                              style: GoogleFonts.montserrat(
                                    textStyle: const TextStyle(
                                    color: Color.fromRGBO(31, 31, 47, 1),
                                    fontSize: 22,
                                    fontWeight: FontWeight.w500)))),
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
                              margin: EdgeInsets.only(left: MediaQuery.of(context).size.width* 0.09,
                                                      top: MediaQuery.of(context).size.height* 0.04),
                              width: MediaQuery.of(context).size.width* 0.1,
                              height: MediaQuery.of(context).size.width* 0.1,
                              child: const Icon(Icons.close_rounded, size: 30, color: Color.fromRGBO(31, 31, 47, 1),)
                        ))
                        ],),
              Container(
                margin: EdgeInsets.only(top: MediaQuery.of(context).size.height*0.02),
                alignment: Alignment.center,
                height: MediaQuery.of(context).size.height*0.4,
                width: MediaQuery.of(context).size.width,
                child: FlutterMap(
                options: MapOptions(
                    center: LatLng(info["latitude"], info["longitude"]),
                    zoom: info["zoom"],
                ),
                children: [
                    TileLayer(
                        urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                        userAgentPackageName: 'com.example.app',
                    ),
                    MarkerLayer(
                        markers: [
                            Marker(
                              point: LatLng(47.8298247, 31.176442),
                              width: 80,
                              height: 80,
                              builder: (context) => const Icon(Icons.location_on, size: 40, color: Colors.red),
                            ),
                        ],
                    ),
              ])),
              SizedBox(
                height: MediaQuery.of(context).size.height*0.49,
                width: MediaQuery.of(context).size.width*0.9,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Номер телефону",
                    style: GoogleFonts.poiretOne(
                          textStyle: const TextStyle(
                          color: Colors.black,
                          fontSize: 20,
                          fontWeight: FontWeight.w800))),
                  Container(
                    margin: EdgeInsets.only(top: MediaQuery.of(context).size.height* 0.01),
                    padding: EdgeInsets.only(top: MediaQuery.of(context).size.height* 0.0075,
                                            bottom: MediaQuery.of(context).size.height* 0.0075,
                                            right: MediaQuery.of(context).size.width* 0.03,
                                            left: MediaQuery.of(context).size.width* 0.03),
                    height: MediaQuery.of(context).size.height* 0.07,
                    decoration: const BoxDecoration(color: Color.fromRGBO(255, 255, 255, 1),
                                                  borderRadius: BorderRadius.all(Radius.circular(15)),),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                      Text("+${info["number"]}",
                        style: GoogleFonts.montserrat(
                              textStyle: const TextStyle(
                              color: Colors.black,
                              fontSize: 16,
                              fontWeight: FontWeight.w500))),
                      Container(
                                                decoration: const BoxDecoration(color: Color.fromRGBO(254, 182, 102, 1),
                                                  borderRadius: BorderRadius.all(Radius.circular(15)),),
                                                width: MediaQuery.of(context).size.height* 0.055,
                                                height: MediaQuery.of(context).size.height* 0.055,
                                                alignment: Alignment.center,
                                                child: const Icon(Icons.phone, size: 25)),
                    ],
                  ))    
                          ]),
               Column(
                 mainAxisAlignment: MainAxisAlignment.start,
                 crossAxisAlignment: CrossAxisAlignment.start,
                 children: [
                   Text("Адреса",
                     style: GoogleFonts.poiretOne(
                           textStyle: const TextStyle(
                           color: Colors.black,
                           fontSize: 20,
                           fontWeight: FontWeight.w800))),
                   Container(
                     margin: EdgeInsets.only(top: MediaQuery.of(context).size.height* 0.01),
                     padding: EdgeInsets.only(top: MediaQuery.of(context).size.height* 0.0075,
                                             bottom: MediaQuery.of(context).size.height* 0.0075,
                                             right: MediaQuery.of(context).size.width* 0.03,
                                             left: MediaQuery.of(context).size.width* 0.03),
                     height: MediaQuery.of(context).size.height* 0.07,
                     decoration: const BoxDecoration(color: Color.fromRGBO(255, 255, 255, 1),
                                                   borderRadius: BorderRadius.all(Radius.circular(15)),),
                     child: Row(
                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
                       children: [
                       Text(info["address"],
                         style: GoogleFonts.montserrat(
                               textStyle: const TextStyle(
                               color: Colors.black,
                               fontSize: 16,
                               fontWeight: FontWeight.w500))),
                       Container(
                                                 decoration: const BoxDecoration(color: Color.fromRGBO(254, 182, 102, 1),
                                                   borderRadius: BorderRadius.all(Radius.circular(15)),),
                                                 width: MediaQuery.of(context).size.height* 0.055,
                                                 height: MediaQuery.of(context).size.height* 0.055,
                                                 alignment: Alignment.center,
                                                 child: const Icon(Icons.location_on, size: 25)),
                     ],
                   ))    
                           ]),
               Column(
                 mainAxisAlignment: MainAxisAlignment.start,
                 crossAxisAlignment: CrossAxisAlignment.start,
                 children: [
                   Text("Графік роботи",
                     style: GoogleFonts.poiretOne(
                           textStyle: const TextStyle(
                           color: Colors.black,
                           fontSize: 20,
                           fontWeight: FontWeight.w800))),
                   Container(
                     margin: EdgeInsets.only(top: MediaQuery.of(context).size.height* 0.01),
                     padding: EdgeInsets.only(top: MediaQuery.of(context).size.height* 0.0075,
                                             bottom: MediaQuery.of(context).size.height* 0.0075,
                                             right: MediaQuery.of(context).size.width* 0.03,
                                             left: MediaQuery.of(context).size.width* 0.03),
                     height: MediaQuery.of(context).size.height* 0.07,
                     decoration: const BoxDecoration(color: Color.fromRGBO(255, 255, 255, 1),
                                                   borderRadius: BorderRadius.all(Radius.circular(15)),),
                     child: Row(
                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
                       children: [
                       Text(info["schedule"],
                         style: GoogleFonts.montserrat(
                               textStyle: const TextStyle(
                               color: Colors.black,
                               fontSize: 16,
                               fontWeight: FontWeight.w500))),
                     ],
                   ))    
                           ]),
                    Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                            GestureDetector(
                              onTap:() {
                                _launchUrl(info["facebookURL"]);
                              },
                              child: const Icon(FontAwesomeIcons.facebook, size: 35)),
                            GestureDetector(
                              onTap:() {
                                _launchUrl(info["instagramURL"]);
                              },
                              child: const Icon(FontAwesomeIcons.instagram, size: 35)),
                            GestureDetector(
                              onTap:() {
                                _launchUrl(info["siteURL"]);
                              },
                              child: const  Icon(FontAwesomeIcons.globe, size: 35))
                            ]),        
            ]))]));
    }

    Future<void> _launchUrl(url) async {
      final Uri urlFinal = Uri.parse(url);
      if (!await launchUrl(urlFinal)) {
        throw 'Could not launch $urlFinal';
      }
}
  }  