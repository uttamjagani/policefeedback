// ignore_for_file: prefer_const_constructors, unused_import
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:policefeedback/views/Police/dropdown.dart';
import 'package:policefeedback/views/Police/policehomescreen.dart';
import 'package:policefeedback/views/Police/policelogin.dart';
import 'package:policefeedback/views/Police/qrcode.dart';
import 'package:policefeedback/views/User/feedback.dart';
import 'package:policefeedback/views/User/scanner.dart';
import 'package:policefeedback/views/User/userlogin.dart';
import 'package:policefeedback/views/registartion/registartion.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        useMaterial3: true,
      ),
      home: registartion(
          //police
          //police@gmail.com
          //police100
          //user
          //user@gmail.com
          //user123
          ),
    );
  }
}
