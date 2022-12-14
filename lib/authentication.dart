
// ignore_for_file: avoid_print

import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:restaraunt_app/order.dart';
import 'package:shared_preferences/shared_preferences.dart';


class AuthenticationServices {
  final FirebaseAuth _auth = FirebaseAuth.instance;


  Future createNewUser(String password) async {
    final prefs = await SharedPreferences.getInstance();
    String mail =  prefs.getString('mail').toString();
    try {
      UserCredential result = await _auth.createUserWithEmailAndPassword(email: mail, password: password);
      User? user = result.user;
      final prefs = await SharedPreferences.getInstance();
      prefs.setString('userId', user!.uid);
      return user;
    } catch (e) {
      print(e.toString());
    }
  }


  Future loginUser(String mail, String password) async {
    try {
      UserCredential result = await _auth.signInWithEmailAndPassword(email: mail, password: password);
      User? user = result.user;
      final prefs = await SharedPreferences.getInstance();
      prefs.setString('userId', user!.uid);
      return user;
    } catch (e) {
      print(e.toString());
    }
  }
}

  bool createUser(password) {
  AuthenticationServices auth = AuthenticationServices();
  dynamic result = auth.createNewUser(password);
  if (result == null) {
    return false;
  } else {
    return true;
  }
}

bool loginUser(mail, password){
  AuthenticationServices auth = AuthenticationServices();
  dynamic result = auth.loginUser(mail, password);
  if (result == null) {
    return false;
  } else {
    return true;
  }
}

void resetPassword(mail) async{
  await FirebaseAuth.instance.sendPasswordResetEmail(email: mail);
}


Future<void> setMail(mail) async {
  final prefs = await SharedPreferences.getInstance();
  prefs.setString('mail', mail);
}


void setPhoneNumber(String phoneNumber) async{
  final prefs = await SharedPreferences.getInstance();
  var userId = (prefs.getString('userId') ?? '');
  final usersQuery = FirebaseDatabase.instance.ref('Users/$userId');
   await usersQuery.set({
                          "phoneNumber": phoneNumber,
                           });
}



void setName(name) async{
  final prefs = await SharedPreferences.getInstance();
  var userId = (prefs.getString('userId') ?? '');
  final usersQuery = FirebaseDatabase.instance.ref('Users/$userId');
   await usersQuery.update({
                          "name": name,
                           });
}

void setAge(age) async{
  final prefs = await SharedPreferences.getInstance();
  var userId = (prefs.getString('userId') ?? '');
  final usersQuery = FirebaseDatabase.instance.ref('Users/$userId');
   await usersQuery.update({
                          "age": age,
                           });
}


void addToFavorite(name, categories, image, ingridient, price) async{
  final prefs = await SharedPreferences.getInstance();
  var userId = (prefs.getString('userId') ?? '');
  final ref = FirebaseDatabase.instance.ref("Users/$userId/favorite/$name");
  final snapshot = await ref.get();
  if (snapshot.exists) {
       ref.remove();
  } else {
      await ref.update({
        "categories": categories,
        "image": image,
        "ingridient": ingridient,
        "price": price
      });
  }
}


void addAddress(apartment, building, entrance, floor, street) async{
  final prefs = await SharedPreferences.getInstance();
  var userId = (prefs.getString('userId') ?? '');
  final ref = FirebaseDatabase.instance.ref("Users/$userId/addresses/$street");
      await ref.update({
        "apartment": apartment,
        "building": building,
        "entrance": entrance,
        "floor": floor
      });
}


void deleteAddress(street) async{
  final prefs = await SharedPreferences.getInstance();
  var userId = (prefs.getString('userId') ?? '');
  final ref = FirebaseDatabase.instance.ref("Users/$userId/addresses/$street");
  ref.remove();
}


void addOrder(apartment, building, entrance, floor, street, price, dishes, time, payment) async{

  final prefs = await SharedPreferences.getInstance();
  var userId = (prefs.getString('userId') ?? '');
  
  FirebaseDatabase.instance
      .ref()
      .child("Orders")
      .once()
      .then((onValue) async{
       final String length = onValue.snapshot.children.last.key.toString();
       final ref = FirebaseDatabase.instance.ref("Orders/${int.parse(length)+1}");
       await ref.update({
        "address": {
            "street": street,
            "building": building,
            "entrance": entrance,
            "floor": floor,
            "apartment": apartment
        },
        "courier":{
          "name": "",
          "number": ""
        },
        "dishes": setDishes(),
        "forTime": time,
        "payment": payment,
        "number": int.parse(length)+1,
        "price": price,
        "date":  getDataText(),
        "status": "В процесі",
        "statusOfProcessing": 1,
        "time": getTimeText(),
        "timeOfFirstProcess": "",
        "timeOfSecondProcess": "",
        "timeOfThirdProcess": "",
        "timeOfFourthProcess": "",
        "timeOfFifthProcess": "",
        "userId": userId,
      });   
  });
}

String getDataText(){
        String day;
        String month;
        String year = DateTime.now().year.toString();
        if(DateTime.now().day<10){
          day = '0${DateTime.now().day}';
        }
        else{
          day = DateTime.now().day.toString();
        }
        if(DateTime.now().month<10){
         month = '0${DateTime.now().month}';
        }
        else{
          month = DateTime.now().month.toString();
        }
        return "$day:$month:$year";
}


 String getTimeText(){
        String hour;
        String minute;
        if(DateTime.now().hour<10){
          hour = '0${DateTime.now().hour}';
        }
        else{
          hour = DateTime.now().hour.toString();
        }
        if(DateTime.now().minute<10){
          minute = '0${DateTime.now().minute}';
        }
        else{
          minute = DateTime.now().minute.toString();
        }
        return "$hour:$minute";
      }


Map<String, dynamic> setDishes(){
  Map<String, dynamic> data = {
    "0": OrderList.order[0].toJson()
  };
  for (int i = 0; i < OrderList.order.length; i++){ 
      data["$i"] = OrderList.order[i].toJson();
  }
  return data;
}

    


