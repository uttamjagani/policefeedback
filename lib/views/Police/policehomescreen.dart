// ignore_for_file: camel_case_types, prefer_const_constructors, unnecessary_import, use_key_in_widget_constructors

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:policefeedback/views/Police/policelogin.dart';
import 'package:policefeedback/views/Police/showfeedback.dart';
import 'package:policefeedback/views/Police/dropdown.dart';

class policehome extends StatefulWidget {
  // const policehome({super.key, required String userRole});

  @override
  State<policehome> createState() => _firstState();
}

class _firstState extends State<policehome> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: Color.fromARGB(30, 107, 107, 107),
          title: Text(
            'Generate the qr code',
            style: TextStyle(color: Colors.black),
          ),
          actions: [
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: GestureDetector(
                  onTap: () {
                    FirebaseAuth.instance.signOut();
                    Get.off(() => policelogin());
                    Fluttertoast.showToast(
                        msg: "Logout Successfully",
                        backgroundColor: Colors.white,
                        textColor: Colors.black);
                  },
                  child: Icon(
                    Icons.logout,
                    color: Colors.black,
                  )),
            ),
          ],
        ),
        body: Container(
          decoration: BoxDecoration(
              image: DecorationImage(
            image: AssetImage("assets/bg2.jpg"),
            fit: BoxFit.cover,
            colorFilter: new ColorFilter.mode(
                Colors.black.withOpacity(0.5), BlendMode.dstATop),
          )),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Center(
                child: ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => drop()),
                      );
                    },
                    child: Text('Generate Qr Code')),
              ),
              Center(
                child: ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => FeedbackListScreen()),
                      );
                    },
                    child: Text('Show Feedback ')),
              ),
            ],
          ),
        ));
  }
}
