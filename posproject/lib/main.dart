import "package:flutter/material.dart";
import "package:get/get.dart";
import "package:posproject/login.dart";
import 'package:sqflite_common_ffi/sqflite_ffi.dart';
void main(){
  sqfliteFfiInit();
  databaseFactory = databaseFactoryFfi;
  runApp(myApp());
}
class myApp extends StatelessWidget{
  const myApp({Key? key}): super(key: key);  
  @override
  Widget build(BuildContext context) {    
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Main Page',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: LoginPage(),
    );
}
}