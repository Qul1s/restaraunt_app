import 'dart:convert';
import 'package:crypto/crypto.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:shared_preferences/shared_preferences.dart';


Future<bool> loginUser(number, password) async{
  bool result = false;
  final users = await FirebaseDatabase.instance.ref('Users/$number').get();
  String passwordFromDB = users.child("password").value.toString();
  List<int> bytes = utf8.encode(password);
  password = sha256.convert(bytes).toString();
    if (passwordFromDB == password){
    result = true;
     }
    else{
      result = false;
    }
    return result;
}

Future<String> getDataFromDB(number) async{
  String passwordFromDB = '';
  final users = await FirebaseDatabase.instance.ref('Users/$number').get();
  passwordFromDB = users.child("password").value.toString();
  return passwordFromDB.toString();
}

Future<void> setUserData(String name, String surname, String age, String image) async {
  String userId = '';
  final prefs = await SharedPreferences.getInstance();
  userId = (prefs.getString('userId') ?? '');
  final usersQuery = FirebaseDatabase.instance.ref('Users/$userId');
   await usersQuery.update({
                          "Image": image,
                           "Name": name,
                           "Surname": surname,
                            "Age": age,
                           });

}

