// ignore_for_file: camel_case_types, must_be_immutable, use_key_in_widget_constructors, prefer_const_constructors, avoid_unnecessary_containers, deprecated_member_use, unused_import, prefer_const_constructors_in_immutables

import 'dart:developer';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:policefeedback/views/User/submit.dart';

class feedbackform extends StatefulWidget {
  // final DocumentSnapshot userDetails;
  final String feedbackFormUrl;

  feedbackform({
    required this.feedbackFormUrl,
  });

  @override
  State<feedbackform> createState() => _feedbackformState();
}

class _feedbackformState extends State<feedbackform> {
  String dropdownvalue = 'Excallent';
  var items = [
    'Excallent',
    'Average',
    'Good',
    'Poor',
  ];
  TextEditingController name = TextEditingController();
  TextEditingController phoneno = TextEditingController();
  TextEditingController uname = TextEditingController();
  TextEditingController emailid = TextEditingController();
  TextEditingController comments = TextEditingController();
  TextEditingController ratting = TextEditingController();
  TextEditingController station = TextEditingController();
  final _formkey = GlobalKey<FormState>();
  // String currentUserUsername = "";
  // String currentUserEmail = "";
  // String currentUserPhone = "";

  // @override
  // void initState() {
  //   super.initState();
  //   // fetchCurrentUserDetails();
  // }

  // Future<void> fetchCurrentUserDetails() async {
  //   User? user = FirebaseAuth.instance.currentUser;
  //   if (user != null) {
  //     DocumentSnapshot userDetails = await FirebaseFirestore.instance
  //         .collection("users")
  //         .doc(user.email)
  //         .get();
  //     if (userDetails.exists) {
  //       setState(() {
  //         currentUserUsername = userDetails["UserName"];
  //         currentUserEmail = userDetails["UserEmaiId"];
  //         currentUserPhone = userDetails["UserPhoneNo"];
  //       });
  //     }
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Color.fromARGB(30, 107, 107, 107),
        title: Text(
          'Feed Back Form',
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: Container(
        decoration: BoxDecoration(
            image: DecorationImage(
          image: AssetImage("assets/bg2.jpg"),
          fit: BoxFit.cover,
          colorFilter: new ColorFilter.mode(
              Colors.black.withOpacity(0.5), BlendMode.dstATop),
        )),
        child: Form(
          key: _formkey,
          child: SingleChildScrollView(
            child: Column(
              children: [
                Center(
                    child: Padding(
                  padding: EdgeInsets.only(top: 50.0),
                  child: Text(
                    'Police Feedback Form',
                    style:
                        TextStyle(fontWeight: FontWeight.normal, fontSize: 30),
                  ),
                )),
                SizedBox(
                  height: 20,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 20, right: 20),
                  child: Text(
                    ' District And Police Station Name:\n${widget.feedbackFormUrl}',
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 20, right: 20),
                  child: TextFormField(
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Please Enter Username.';
                      }
                      return null;
                    },
                    controller: uname,
                    decoration: InputDecoration(
                      labelText: 'Username',
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 20, right: 20),
                  child: TextFormField(
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Please Enter PhoneNo.';
                      }
                      return null;
                    },
                    controller: phoneno,
                    decoration: InputDecoration(
                      labelText: 'PhoneNumber',
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 20, right: 20),
                  child: TextFormField(
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Please Enter Email ID.';
                      }
                      return null;
                    },
                    controller: emailid,
                    decoration: InputDecoration(
                      labelText: 'Email ID',
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 20, right: 20),
                  child: TextFormField(
                    controller: name,
                    decoration:
                        InputDecoration(labelText: 'Police Officer Name'),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Please Enter Name Of Police Officer.';
                      }
                      return null;
                    },
                  ),
                ),
                Container(
                  padding: EdgeInsets.only(left: 18, right: 18),
                  width: double.infinity,
                  child: DropdownButton(
                    underline: SizedBox(),
                    // Initial Value
                    value: dropdownvalue,

                    // Down Arrow Icon
                    icon: const Icon(Icons.keyboard_arrow_down),

                    // Array list of items
                    items: items.map((String items) {
                      return DropdownMenuItem(
                        value: items,
                        child: Text(items),
                      );
                    }).toList(),
                    // After selecting the desired option,it will
                    // change button value to selected value
                    onChanged: (String? newValue) {
                      setState(() {
                        dropdownvalue = newValue!;
                        ratting.text = newValue;
                      });
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 20, right: 20),
                  child: TextFormField(
                    controller: comments,
                    maxLines: 5,
                    decoration:
                        InputDecoration(labelText: 'Additional Comments'),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Please Enter Additional Comments.';
                      }
                      return null;
                    },
                  ),
                ),
                SizedBox(
                  height: 50,
                ),
                SizedBox(
                  width: 300,
                  height: 50,
                  child: ElevatedButton(
                    onPressed: () {
                      if (_formkey.currentState!.validate()) {
                        var plocename = name.text.trim();
                        var comm = comments.text.trim();
                        var rat = ratting.text;
                        var username = uname.text.trim();
                        var userphone = phoneno.text.trim();
                        var useremailid = emailid.text.trim();
                        var stationdetail = station.text.trim();
                        (
                          FirebaseFirestore.instance
                              .collection("feedback")
                              .doc()
                              .set({
                            'User name': username,
                            'User Phone no': userphone,
                            'User Email id': useremailid,
                            'Police station detail': stationdetail,
                            'Police Officer(s) Name(s)': plocename,
                            'Ratting': rat,
                            'Additional Comments': comm,
                          }),
                        );

                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => sub()),
                        );
                      }
                    },
                    child: Text(
                      'Submit',
                      style: TextStyle(fontSize: 20, color: Colors.black),
                    ),
                  ),
                ),
                SizedBox(
                  height: 40,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
