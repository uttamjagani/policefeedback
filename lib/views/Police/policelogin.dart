// ignore_for_file: prefer_const_constructors, prefer_const_constructors_in_immutables, avoid_print, avoid_unnecessary_containers, unused_field, prefer_final_fields, use_build_context_synchronously, empty_statements, unused_import, camel_case_types, use_key_in_widget_constructors, unnecessary_new

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:policefeedback/views/Police/policehomescreen.dart';
import 'package:policefeedback/views/User/scanner.dart';
import 'package:policefeedback/views/auth/forgotpassword.dart';
import 'package:policefeedback/views/registartion/registartion.dart';

class policelogin extends StatefulWidget {
  @override
  State<policelogin> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<policelogin> {
  final storage = FlutterSecureStorage();

  @override
  void initState() {
    super.initState();
    checkForExistingSession();
  }

  Future<void> checkForExistingSession() async {
    final token = await storage.read(key: 'auth_token');
    if (token != null) {
      // If a token exists, the user is already logged in, so navigate to the home screen
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => policehome()),
      );
    }
  }

  final _formkey = GlobalKey<FormState>();
  bool _obsecuretext = true;
  TextEditingController policenameController = TextEditingController();
  TextEditingController policepasswordController = TextEditingController();
  String selectedRole = "user";
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Form(
      key: _formkey,
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Container(
          decoration: BoxDecoration(
              image: DecorationImage(
            image: AssetImage("assets/bg2.jpg"),
            fit: BoxFit.cover,
            colorFilter: new ColorFilter.mode(
                Colors.black.withOpacity(0.5), BlendMode.dstATop),
          )),
          child: Center(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(15.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // Image(image: AssetImage('assets/Login.png')),
                    Text(
                      'Welcome',
                      style: TextStyle(fontSize: 40, color: Colors.black),
                    ),
                    Text('Police Login Account'),
                    SizedBox(
                      height: 10,
                    ),
                    TextFormField(
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "Email is Required";
                        }
                        return null;
                      },
                      keyboardType: TextInputType.emailAddress,
                      controller: policenameController,
                      decoration: InputDecoration(
                          label: Text('Email'),
                          // hintText: "Enter Email",
                          prefixIcon: const Icon(
                            Icons.email,
                          ),
                          fillColor: Colors.black,
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15))),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    TextFormField(
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "PassWord is Required";
                        }
                        return null;
                      },
                      obscureText: _obsecuretext,
                      controller: policepasswordController,
                      decoration: InputDecoration(
                          label: Text('Password'),
                          // hintText: "Enter Password",
                          prefixIcon: Icon(
                            Icons.password,
                          ),
                          suffixIcon: IconButton(
                              onPressed: () {
                                setState(() {
                                  _obsecuretext = !_obsecuretext;
                                });
                              },
                              icon: _obsecuretext
                                  ? Icon(
                                      Icons.visibility_off,
                                      color: Colors.black,
                                    )
                                  : Icon(
                                      Icons.visibility,
                                      color: Colors.black,
                                    )),
                          fillColor: Colors.black,
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15))),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    GestureDetector(
                        onTap: () {
                          Get.to(() => Forgotpassword());
                        },
                        child: Text(
                          "Forgot Password?",
                          style: TextStyle(),
                        )),
                    SizedBox(
                      height: 20,
                    ),
                    ElevatedButton(
                        onPressed: () async {
                          if (_formkey.currentState!.validate()) {
                            var pemail = policenameController.text.trim();
                            var ppassword =
                                policepasswordController.text.trim();

                            try {
                              final User? firebaseuser = (await FirebaseAuth
                                      .instance
                                      .signInWithEmailAndPassword(
                                          email: pemail, password: ppassword))
                                  .user;
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => policehome()));
                              if (firebaseuser != null) {
                                print("Error");
                              } else {
                                print('Check Email & Password');
                              }

                              Fluttertoast.showToast(
                                  msg: "Login Successfully",
                                  backgroundColor: Colors.white,
                                  textColor: Colors.black);
                            } on FirebaseAuthException catch (e) {
                              showDialog(
                                  context: context,
                                  builder: (context) => AlertDialog(
                                        title: Text(e.code),
                                      ));
                              // Fluttertoast.showToast(
                              //     msg: "Login Failed",
                              //     backgroundColor: Colors.white,
                              //     textColor: Colors.black);
                            }
                          }
                        },
                        child: Text(
                          'Log in',
                          style: TextStyle(color: Colors.black),
                        )),
                    SizedBox(
                      height: 10,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text('Don`t Have An Account?'),
                        SizedBox(
                          width: 15,
                        ),
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => registartion()));
                          },
                          child: Text('Sign up'),
                        )
                      ],
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    ));
  }
}
