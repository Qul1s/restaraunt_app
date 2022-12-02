import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:restaraunt_app/connection_error.dart';
import 'package:restaraunt_app/main_screen.dart';
import 'firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'dart:developer' as developer;


void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  //initializeFirebase();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}


class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {


  // ConnectivityResult _connectionStatus = ConnectivityResult.none;
  // final Connectivity _connectivity = Connectivity();
  // late StreamSubscription<ConnectivityResult> _connectivitySubscription;

  Map _source = {ConnectivityResult.none: false};
  final MyConnectivity _connectivity = MyConnectivity.instance;

@override
  void initState() {
    super.initState();
    //StreamSubscription _connectionChangeStream;
    //returnScreen();
    // initConnectivity();
    //_connectivitySubscription = _connectivity.onConnectivityChanged.listen(_updateConnectionStatus);
    _connectivity.initialise();
    _connectivity.myStream.listen((source) {
      setState(() => _source = source);
    });
    
  }


  @override
  void dispose() {
    //_connectivitySubscription.cancel();
    _connectivity.disposeStream();
    super.dispose();
  } 

  //  Future<void> initConnectivity() async {
  //   late ConnectivityResult result;
  //     try {
  //     result = await _connectivity.checkConnectivity();
  //   } on PlatformException catch (e) {
  //     developer.log('Couldn\'t check connectivity status', error: e);
  //     return;
  //   }
  //   if (!mounted) {
  //     return Future.value(null);
  //   }
  //   return _updateConnectionStatus(result);
  // }

  // Future<void> _updateConnectionStatus(ConnectivityResult result) async {
  //   setState(() {
  //     _connectionStatus = result;
  //   });
  // }
  
  @override
  Widget build(BuildContext context) {
    //if(){
    //}
    // else{
    //   return const MaterialApp(
    //      home: ConnectionErrorPage(),
    // );
    // }
    switch (_source.keys.toList()[0]) {
      case ConnectivityResult.mobile:
        return const MaterialApp(
        home: MainScreen(),
    );
      case ConnectivityResult.wifi:
        return const MaterialApp(
        home: MainScreen(),
    );
      case ConnectivityResult.none:
      default:
        return const MaterialApp(
        home: ConnectionErrorPage(),
    );
    }
  }
}


class MyConnectivity {
  MyConnectivity._();

  static final _instance = MyConnectivity._();
  static MyConnectivity get instance => _instance;
  final _connectivity = Connectivity();
  final _controller = StreamController.broadcast();
  Stream get myStream => _controller.stream;

  void initialise() async {
    ConnectivityResult result = await _connectivity.checkConnectivity();
    _checkStatus(result);
    _connectivity.onConnectivityChanged.listen((result) {
      _checkStatus(result);
    });
  }

  void _checkStatus(ConnectivityResult result) async {
    bool isOnline = false;
    try {
      final result = await InternetAddress.lookup('example.com');
      isOnline = result.isNotEmpty && result[0].rawAddress.isNotEmpty;
    } on SocketException catch (_) {
      isOnline = false;
    }
    _controller.sink.add({result: isOnline});
  }

  void disposeStream() => _controller.close();
}



