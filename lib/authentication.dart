
// ignore_for_file: avoid_print

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
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


    


