// ignore_for_file: dead_code

import 'dart:convert';
import 'dart:math';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_swipe_action_cell/flutter_swipe_action_cell.dart';
import 'package:flutterfire_ui/database.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconsax/iconsax.dart';
import 'package:lottie/lottie.dart';
import 'package:restaraunt_app/authentication.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'error_text.dart';
import 'ftoast_controller.dart';

class SavedAddressPage extends StatefulWidget {
     const SavedAddressPage({Key? key, 
    }) : super(key: key);

    @override
    // ignore: no_logic_in_create_state
    State<SavedAddressPage> createState() => _SavedAddressPageState();
  }

  class _SavedAddressPageState extends State<SavedAddressPage> {

    _SavedAddressPageState();
    dynamic addressQuery='';
    dynamic userId = '';

  @override
  void initState() {
    getData();
    super.initState();
  }

  void getData() async{
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      userId = (prefs.getString('userId') ?? '');
      addressQuery = FirebaseDatabase.instance.ref('Users/$userId/addresses');
    });
  }



    @override
    Widget build(BuildContext context) {
      if(addressQuery == ""){
                  return Expanded(
                            child:Container(
                                            width: MediaQuery.of(context).size.width* 0.95,
                                            alignment: Alignment.center,
                                            child: Column(
                                                mainAxisAlignment: MainAxisAlignment.center,
                                                crossAxisAlignment: CrossAxisAlignment.center,
                                                children: [
                                                  Lottie.asset('lottie/loading_food.json',
                                                      width: MediaQuery.of(context).size.width* 0.8,
                                                      height: MediaQuery.of(context).size.height* 0.3
                                                      ),
                                                  AutoSizeText("Загрузка..",
                                                      style: GoogleFonts.poiretOne(
                                                        textStyle: const TextStyle(
                                                        color: Colors.black,
                                                        fontSize: 20,
                                                        fontWeight: FontWeight.w800)),
                                                      minFontSize: 12,
                                                      stepGranularity: 2,
                                                      textAlign: TextAlign.center),
                                                ])));
              }
      else{
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
                              margin: EdgeInsets.only(left: MediaQuery.of(context).size.width* 0.05,
                                                      top: MediaQuery.of(context).size.height* 0.04),
                              width: MediaQuery.of(context).size.width* 0.1,
                              height: MediaQuery.of(context).size.width* 0.1,
                              child: const Icon(Icons.arrow_back_outlined, size: 30, color: Color.fromRGBO(31, 31, 47, 1),)
                        )),
                          Container(
                            alignment: Alignment.center,
                            margin: EdgeInsets.only(left: MediaQuery.of(context).size.width* 0.12,
                                                    top: MediaQuery.of(context).size.height* 0.04),
                            width: MediaQuery.of(context).size.width* 0.5,
                            height: MediaQuery.of(context).size.height* 0.04,
                            child: AutoSizeText("Збережені адреси", 
                            textAlign: TextAlign.center,
                              style: GoogleFonts.montserrat(
                                    textStyle: const TextStyle(
                                    color: Color.fromRGBO(31, 31, 47, 1),
                                    fontSize: 19,
                                    fontWeight: FontWeight.w600)))),
                        ],),
                        Expanded(
                          child: Container(
                            margin: EdgeInsets.only(top: MediaQuery.of(context).size.height* 0.01),
                            width: MediaQuery.of(context).size.width* 0.9,
                            child: FirebaseDatabaseQueryBuilder(
                                  query: addressQuery,
                                  builder: (context, snapshot, _) { 
                                  return ListView.separated(
                              itemCount: snapshot.docs.length,
                              separatorBuilder: (BuildContext context, int index) => SizedBox(height: MediaQuery.of(context).size.height* 0.015),
                              itemBuilder: (BuildContext context, int index){
                                if (snapshot.hasMore && index + 1 == snapshot.docs.length) {
                                  snapshot.fetchMore();
                                  } 
                                final address = jsonDecode(jsonEncode(snapshot.docs[index].value)) as Map<String, dynamic>;
                                String code = snapshot.docs[index].key.toString();
                                return SwipeActionCell(
                                            backgroundColor: const Color.fromRGBO(245, 245, 245, 1),
                                            key: ObjectKey(address), 
                                            trailingActions: <SwipeAction>[
                                              SwipeAction(
                                                  onTap: (CompletionHandler handler) async {
                                                    await handler(true);
                                                    setState(() {
                                                      deleteAddress(code);
                                                    });
                                                  },
                                              backgroundRadius: 0,
                                              performsFirstActionWithFullSwipe: true,
                                              widthSpace: MediaQuery.of(context).size.width* 0.2,
                                              icon: const Icon(Iconsax.trash, color: Colors.white, size: 30),
                                              color: Colors.red),
                                        ],
                                        child: GestureDetector(
                                          onTap: ((){
                                            ShowDialog(context, code, "Змінити адресу", address["street"].toString(), address["name"].toString(), 
                                            address["building"].toString(), address["entrance"].toString(), address["floor"].toString(), address["apartment"].toString());
                                          }),
                                          child: Container(
                                            padding: EdgeInsets.only(left: MediaQuery.of(context).size.width* 0.05,
                                                                    right: MediaQuery.of(context).size.width* 0.05),
                                            width: MediaQuery.of(context).size.width* 0.9,
                                            height: MediaQuery.of(context).size.width* 0.17,
                                            decoration: BoxDecoration(borderRadius: BorderRadius.circular(15), 
                                                                  color: const Color.fromRGBO(255, 255, 255, 1)),
                                            child: Column(
                                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                Row(
                                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                children: [
                                                  Text("${address["name"]}", 
                                                  textAlign: TextAlign.center,
                                                    style: GoogleFonts.nunito(
                                                          textStyle: const TextStyle(
                                                          color: Color.fromRGBO(31, 31, 47, 1),
                                                          fontSize: 18,
                                                          fontWeight: FontWeight.w800))),
                                                Text("${address["street"]}, ${address["building"]}", 
                                                  textAlign: TextAlign.center,
                                                    style: GoogleFonts.poiretOne(
                                                          textStyle: const TextStyle(
                                                          color: Color.fromRGBO(31, 31, 47, 1),
                                                          fontSize: 17,
                                                          fontWeight: FontWeight.w800))),
                                                ],),
                                                Row(
                                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                  children: [
                                                  Text("Квартира: ${address["apartment"]}", 
                                                    textAlign: TextAlign.center,
                                                      style: GoogleFonts.poiretOne(
                                                            textStyle: const TextStyle(
                                                            color: Color.fromRGBO(31, 31, 47, 1),
                                                            fontSize: 16,
                                                            fontWeight: FontWeight.w800))),
                                                  Text("Поверх: ${address["floor"]}", 
                                                    textAlign: TextAlign.center,
                                                      style: GoogleFonts.poiretOne(
                                                            textStyle: const TextStyle(
                                                            color: Color.fromRGBO(31, 31, 47, 1),
                                                            fontSize: 16,
                                                            fontWeight: FontWeight.w800))),
                                                  Text("Під'їзд: ${address["entrance"]}", 
                                                    textAlign: TextAlign.center,
                                                      style: GoogleFonts.poiretOne(
                                                            textStyle: const TextStyle(
                                                            color: Color.fromRGBO(31, 31, 47, 1),
                                                            fontSize: 16,
                                                            fontWeight: FontWeight.w800))),
                                                ])
                                            ],)
                                            )));
                              });}))
                        ),
                        GestureDetector( 
                          onTap: () => ShowDialog(context),
                          child: Container(
                                        alignment: Alignment.center,
                                        margin: EdgeInsets.only(bottom: MediaQuery.of(context).size.height* 0.03),
                                        padding: EdgeInsets.only(left: MediaQuery.of(context).size.width* 0.05,
                                                                right: MediaQuery.of(context).size.width* 0.05),
                                        width: MediaQuery.of(context).size.width* 0.6,
                                        height: MediaQuery.of(context).size.height* 0.05,
                                        decoration: BoxDecoration(borderRadius: BorderRadius.circular(15), 
                                                              color: const Color.fromRGBO(254, 182, 102, 1),),
                                        child: 
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                          children: [
                                            Text("Додати адресу", 
                                                textAlign: TextAlign.center,
                                                  style: GoogleFonts.poiretOne(
                                                        textStyle: const TextStyle(
                                                        color: Color.fromRGBO(255, 255, 255, 1),
                                                        fontSize: 18,
                                                        fontWeight: FontWeight.w800))),
                                            const Icon(Icons.add_location_alt, color: Color.fromRGBO(255, 255, 255, 1), size: 25)
                                          ],
                                        )
                                        ))
                      ])
      );}
      }


// ignore: non_constant_identifier_names
void ShowDialog(context, [String code = "0", String text = "Додати адресу", String street = "", String name = "", String building= "", String entrance= "", String floor= "",String apartment= ""]){

  Color additionalColor = const Color.fromRGBO(40, 40, 40, 1);
  // ignore: prefer_final_fields
  bool submitted = false;

  final TextEditingController streetController = TextEditingController(text: street);
  final TextEditingController nameController = TextEditingController(text: name);
  final TextEditingController buildingContoller = TextEditingController(text: building);
  final TextEditingController entranceContoller = TextEditingController(text: entrance);
  final TextEditingController floorContoller = TextEditingController(text: floor);
  final TextEditingController apartmentContoller = TextEditingController(text: apartment);
  showDialog<String>(
                 context: context,
                 builder: (BuildContext context) => StatefulBuilder(
                  builder: (context, setState){ 
                    return AlertDialog(
                      insetPadding: const EdgeInsets.all(0),
                      shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(25))),
                  contentPadding: const EdgeInsets.all(0),
                  content: Container(
                    padding: EdgeInsets.all(MediaQuery.of(context).size.width*0.05),
                    height: MediaQuery.of(context).size.height* 0.66,
                    width: MediaQuery.of(context).size.width*0.95,
                    decoration: const BoxDecoration(
                      color: Color.fromRGBO(245, 245, 245, 1),
                      borderRadius: BorderRadius.all(Radius.circular(25)),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                          Container(
                            alignment: Alignment.center,
                            margin: EdgeInsets.only(left: MediaQuery.of(context).size.width* 0.17,
                                                    top: MediaQuery.of(context).size.height* 0.01),
                            width: MediaQuery.of(context).size.width* 0.5,
                            height: MediaQuery.of(context).size.height* 0.04,
                            child: Text(text, 
                              style: GoogleFonts.poiretOne(
                                    textStyle: const TextStyle(
                                    color: Color.fromRGBO(31, 31, 47, 1),
                                    fontSize: 22,
                                    fontWeight: FontWeight.w800)))),
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
                              margin: EdgeInsets.only(left: MediaQuery.of(context).size.width* 0.04,
                                                      top: MediaQuery.of(context).size.height* 0.01),
                              width: MediaQuery.of(context).size.width* 0.1,
                              height: MediaQuery.of(context).size.width* 0.1,
                              child: const Icon(Icons.close_rounded, size: 30, color: Color.fromRGBO(31, 31, 47, 1),)
                        ))
                        ],),
              Container(
                margin: EdgeInsets.only(top: MediaQuery.of(context).size.height* 0.01),
                child:
               Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
              Container(
              margin: EdgeInsets.only(top: MediaQuery.of(context).size.height* 0.02),     
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Назва",
                    style: GoogleFonts.montserrat(
                                                        textStyle: const TextStyle(
                                                        color: Colors.black,
                                                        fontSize: 18,
                                                        fontWeight: FontWeight.w500))),
                  Container(
                          width:MediaQuery.of(context).size.width*0.9,
                          height: MediaQuery.of(context).size.height * 0.03,
                          alignment: Alignment.topCenter,
                          child: TextField(
                            onChanged: (text) => setState(() => text),
                            controller: nameController,
                            obscureText: false,
                            textAlign: TextAlign.left,
                            cursorColor: const Color.fromRGBO(40, 40, 40, 1),
                            textAlignVertical: TextAlignVertical.bottom,
                            decoration: InputDecoration(
                              errorText: submitted
                                  ? errorText(nameController)
                                  : null,
                              focusedBorder: UnderlineInputBorder(
                                  borderSide:
                                      BorderSide(color: additionalColor, width: 1.5)),
                              enabledBorder: UnderlineInputBorder(
                                  borderSide:
                                      BorderSide(color: additionalColor, width: 1.5)),
                              border: UnderlineInputBorder(
                                  borderSide:
                                      BorderSide(color: additionalColor, width: 1.5)),
                            ),
                            style: TextStyle(
                                fontSize: 16,
                                color: additionalColor,
                                fontFamily: "uaBrand",
                                fontWeight: FontWeight.w400),
                          ))   
                          ])),
              Container(
              margin: EdgeInsets.only(top: MediaQuery.of(context).size.height* 0.02),     
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Вулиця (обов'язково)",
                    style: GoogleFonts.montserrat(
                                                        textStyle: const TextStyle(
                                                        color: Colors.black,
                                                        fontSize: 18,
                                                        fontWeight: FontWeight.w500))),
                  Container(
                          width:MediaQuery.of(context).size.width*0.9,
                          height: MediaQuery.of(context).size.height * 0.03,
                          alignment: Alignment.topCenter,
                          child: TextField(
                            onChanged: (text) => setState(() => text),
                            controller: streetController,
                            obscureText: false,
                            textAlign: TextAlign.left,
                            cursorColor: const Color.fromRGBO(40, 40, 40, 1),
                            textAlignVertical: TextAlignVertical.bottom,
                            decoration: InputDecoration(
                              errorText: submitted
                                  ? errorText(streetController)
                                  : null,
                              focusedBorder: UnderlineInputBorder(
                                  borderSide:
                                      BorderSide(color: additionalColor, width: 1.5)),
                              enabledBorder: UnderlineInputBorder(
                                  borderSide:
                                      BorderSide(color: additionalColor, width: 1.5)),
                              border: UnderlineInputBorder(
                                  borderSide:
                                      BorderSide(color: additionalColor, width: 1.5)),
                            ),
                            style: TextStyle(
                                fontSize: 16,
                                color: additionalColor,
                                fontFamily: "uaBrand",
                                fontWeight: FontWeight.w400),
                          ))   
                          ])),
               Container(
              margin: EdgeInsets.only(top: MediaQuery.of(context).size.height* 0.02),     
              child: Column(
                 mainAxisAlignment: MainAxisAlignment.start,
                 crossAxisAlignment: CrossAxisAlignment.start,
                 children: [
                   Text("Номер будинку (обов'язково) ",
                     style: GoogleFonts.montserrat(
                                                        textStyle: const TextStyle(
                                                        color: Colors.black,
                                                        fontSize: 18,
                                                        fontWeight: FontWeight.w500))),
                   Container(
                           width:MediaQuery.of(context).size.width*0.9,
                           height: MediaQuery.of(context).size.height * 0.03,
                           alignment: Alignment.topCenter,
                           child: TextField(
                             onChanged: (text) => setState(() => text),
                             controller: buildingContoller,
                             obscureText: false,
                             textAlign: TextAlign.left,
                             cursorColor: const Color.fromRGBO(40, 40, 40, 1),
                             textAlignVertical: TextAlignVertical.bottom,
                             decoration: InputDecoration(
                               errorText: submitted
                                   ? errorText(buildingContoller)
                                   : null,
                               focusedBorder: UnderlineInputBorder(
                                   borderSide:
                                       BorderSide(color: additionalColor, width: 1.5)),
                               enabledBorder: UnderlineInputBorder(
                                   borderSide:
                                       BorderSide(color: additionalColor, width: 1.5)),
                               border: UnderlineInputBorder(
                                   borderSide:
                                       BorderSide(color: additionalColor, width: 1.5)),
                             ),
                             style: TextStyle(
                                 fontSize: 16,
                                 color: additionalColor,
                                 fontFamily: "uaBrand",
                                 fontWeight: FontWeight.w400),
                           ))    
                           ])),
               Container(
              margin: EdgeInsets.only(top: MediaQuery.of(context).size.height* 0.02),     
              child: Column(
                 mainAxisAlignment: MainAxisAlignment.start,
                 crossAxisAlignment: CrossAxisAlignment.start,
                 children: [
                   Text("Номер під'їзду",
                     style: GoogleFonts.montserrat(
                                                        textStyle: const TextStyle(
                                                        color: Colors.black,
                                                        fontSize: 18,
                                                        fontWeight: FontWeight.w500))),
                   Container(
                           width:MediaQuery.of(context).size.width*0.9,
                           height: MediaQuery.of(context).size.height * 0.03,
                           alignment: Alignment.topCenter,
                           child: TextField(
                             onChanged: (text) => setState(() => text),
                             controller: entranceContoller,
                             obscureText: false,
                             textAlign: TextAlign.left,
                             cursorColor: const Color.fromRGBO(40, 40, 40, 1),
                             textAlignVertical: TextAlignVertical.bottom,
                             decoration: InputDecoration(
                               errorText: submitted
                                   ? errorText(entranceContoller)
                                   : null,
                               focusedBorder: UnderlineInputBorder(
                                   borderSide:
                                       BorderSide(color: additionalColor, width: 1.5)),
                               enabledBorder: UnderlineInputBorder(
                                   borderSide:
                                       BorderSide(color: additionalColor, width: 1.5)),
                               border: UnderlineInputBorder(
                                   borderSide:
                                       BorderSide(color: additionalColor, width: 1.5)),
                             ),
                             style: TextStyle(
                                 fontSize: 16,
                                 color: additionalColor,
                                 fontFamily: "uaBrand",
                                 fontWeight: FontWeight.w400),
                           ))   
                           ])), 
              Container(
              margin: EdgeInsets.only(top: MediaQuery.of(context).size.height* 0.02),     
              child:  Column(
                 mainAxisAlignment: MainAxisAlignment.start,
                 crossAxisAlignment: CrossAxisAlignment.start,
                 children: [
                   Text("Поверх",
                     style: GoogleFonts.montserrat(
                                                        textStyle: const TextStyle(
                                                        color: Colors.black,
                                                        fontSize: 18,
                                                        fontWeight: FontWeight.w500))),
                   Container(
                           width:MediaQuery.of(context).size.width*0.9,
                           height: MediaQuery.of(context).size.height * 0.03,
                           alignment: Alignment.topCenter,
                           child: TextField(
                             onChanged: (text) => setState(() => text),
                             controller: floorContoller,
                             obscureText: false,
                             textAlign: TextAlign.left,
                             cursorColor: const Color.fromRGBO(40, 40, 40, 1),
                             textAlignVertical: TextAlignVertical.bottom,
                             decoration: InputDecoration(
                               errorText: submitted
                                   ? errorText(floorContoller)
                                   : null,
                               focusedBorder: UnderlineInputBorder(
                                   borderSide:
                                       BorderSide(color: additionalColor, width: 1.5)),
                               enabledBorder: UnderlineInputBorder(
                                   borderSide:
                                       BorderSide(color: additionalColor, width: 1.5)),
                               border: UnderlineInputBorder(
                                   borderSide:
                                       BorderSide(color: additionalColor, width: 1.5)),
                             ),
                             style: TextStyle(
                                 fontSize: 16,
                                 color: additionalColor,
                                 fontFamily: "uaBrand",
                                 fontWeight: FontWeight.w400),
                           ))   
                           ])),
                    Container(
              margin: EdgeInsets.only(top: MediaQuery.of(context).size.height* 0.02),     
              child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Номер квартири",
                          style: GoogleFonts.montserrat(
                                                        textStyle: const TextStyle(
                                                        color: Colors.black,
                                                        fontSize: 18,
                                                        fontWeight: FontWeight.w500))),
                        Container(
                                width:MediaQuery.of(context).size.width*0.9,
                                height: MediaQuery.of(context).size.height * 0.03,
                                alignment: Alignment.topCenter,
                                child: TextField(
                                  onChanged: (text) => setState(() => text),
                                  controller: apartmentContoller,
                                  obscureText: false,
                                  textAlign: TextAlign.left,
                                  cursorColor: const Color.fromRGBO(40, 40, 40, 1),
                                  textAlignVertical: TextAlignVertical.bottom,
                                  decoration: InputDecoration(
                                    errorText: submitted
                                        ? errorText(apartmentContoller)
                                        : null,
                                    focusedBorder: UnderlineInputBorder(
                                        borderSide:
                                            BorderSide(color: additionalColor, width: 1)),
                                    enabledBorder: UnderlineInputBorder(
                                        borderSide:
                                            BorderSide(color: additionalColor, width: 1)),
                                    border: UnderlineInputBorder(
                                        borderSide:
                                            BorderSide(color: additionalColor, width: 1)),
                                  ),
                                  style: TextStyle(
                                      fontSize: 16,
                                      color: additionalColor,
                                      fontFamily: "uaBrand",
                                      fontWeight: FontWeight.w400),
                                ))   
                                ])), 
                      Container(
                        alignment: Alignment.centerRight,
                        margin: EdgeInsets.only(top: MediaQuery.of(context).size.height* 0.03),
                        width: MediaQuery.of(context).size.width* 0.9,
                        child: 
                      GestureDetector( 
                          onTap:() async{
                            if(streetController.text.isNotEmpty && buildingContoller.text.isNotEmpty){
                              if(code == "0"){
                                Random rnd = Random();
                                  setState(() {
                                    code = rnd.nextInt(1000000).toString();
                                  });
                              }
                              addAddress(code, nameController.value.text, apartmentContoller.value.text, buildingContoller.value.text, entranceContoller.value.text, floorContoller.value.text, streetController.value.text);
                              Navigator.pop(context);
                              FtoastController.showPositiveToast(context, Icons.add_location_alt_outlined, "Збережено");
                            }
                            else{
                              FtoastController.showToast(context, "Перевірте дані");
                            }
                          },
                          child: Container(
                                        alignment: Alignment.center,
                                        padding: EdgeInsets.only(left: MediaQuery.of(context).size.width* 0.05,
                                                                right: MediaQuery.of(context).size.width* 0.05),
                                        width: MediaQuery.of(context).size.width* 0.35,
                                        height: MediaQuery.of(context).size.height* 0.05,
                                        decoration: BoxDecoration(borderRadius: BorderRadius.circular(15), 
                                                              color: const Color.fromRGBO(254, 182, 102, 1),),
                                        child: 
                                            Text("Зберегти", 
                                                textAlign: TextAlign.center,
                                                  style: GoogleFonts.montserrat(
                                                        textStyle: const TextStyle(
                                                        color: Color.fromRGBO(255, 255, 255, 1),
                                                        fontSize: 18,
                                                        fontWeight: FontWeight.w400))), 
                                        )))      
            ]))
                        ],)
                                                    )
                                          );}),
                                        );
}
    }