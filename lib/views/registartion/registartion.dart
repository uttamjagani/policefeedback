// ignore_for_file: unnecessary_null_comparison, body_might_complete_normally_nullable, use_key_in_widget_constructors, use_key_in_widget_constructors, duplicate_ignore, library_private_types_in_public_api, avoid_print, unused_import, prefer_const_constructors, prefer_const_literals_to_create_immutables, camel_case_types, unnecessary_new

import 'dart:io';
import 'dart:math';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:policefeedback/views/Police/policehomescreen.dart';
import 'package:policefeedback/views/Police/policelogin.dart';
import 'package:policefeedback/views/User/userlogin.dart';

class registartion extends StatefulWidget {
  @override
  // ignore: library_private_types_in_public_api
  _MyHomePageState createState() => _MyHomePageState();
}

enum UserRole {
  selectRole,
  user,
  police,
}

class _MyHomePageState extends State<registartion> {
  UserRole selectedRole = UserRole.selectRole;
  final _formkey = GlobalKey<FormState>();
  bool _obsecuretext = true;
  TextEditingController policenameController = TextEditingController();
  TextEditingController idController = TextEditingController();
  TextEditingController loginnameController = TextEditingController();
  TextEditingController loginpasswordController = TextEditingController();
  TextEditingController usernameController = TextEditingController();
  TextEditingController userphoneController = TextEditingController();
  TextEditingController useremailController = TextEditingController();
  TextEditingController userpasswordController = TextEditingController();
  Future<void> _uploadFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles();
    if (result == null || result.files.isEmpty) return;
    PlatformFile file = result.files.first;
    if (file == null || file.path == null) {
      print('Error Accessing The File.');
      return;
    }
    Reference storageReference = FirebaseStorage.instance
        .ref()
        .child('uploads/${result.files.single.name}');
    UploadTask uploadTask = storageReference.putFile(File(file.path!));
    try {
      await uploadTask;
      print('File Uploaded Successfully.');
    } on FirebaseException catch (e) {
      print('Error Uploading The File: $e');
    }
    await uploadTask.whenComplete(() {
      print('File Uploaded Successfully.');
    });
    Fluttertoast.showToast(
        msg: " Upload Successfully ",
        backgroundColor: Colors.white,
        textColor: Colors.black);
  }

  String captchaChallenge = generateRandomString();
  static String generateRandomString() {
    const characters =
        'abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789';
    Random random = Random();
    String result = '';
    for (int i = 0; i < 6; i++) {
      result += characters[random.nextInt(characters.length)];
    }
    return result;
  }

  TextEditingController captchaController = TextEditingController();
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
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // Image(image: AssetImage('assets/Signup.png')),

                    Text(
                      'Welcome',
                      style: TextStyle(fontSize: 40, color: Colors.black),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    DropdownButton<UserRole>(
                      value: selectedRole,
                      onChanged: (UserRole? newValue) {
                        if (newValue != null) {
                          setState(() {
                            selectedRole = newValue;
                          });
                        }
                      },
                      items: [
                        DropdownMenuItem(
                          value: UserRole.selectRole,
                          child: Text('Select Role'),
                        ),
                        DropdownMenuItem(
                          value: UserRole.user,
                          child: Text('User'),
                        ),
                        DropdownMenuItem(
                          value: UserRole.police,
                          child: Text('Police'),
                        ),
                      ],
                    ),
                    SizedBox(height: 10),
                    if (selectedRole == UserRole.user)
                      userRegistrationWidget()
                    else if (selectedRole == UserRole.police)
                      policeRegistrationWidget(),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget userRegistrationWidget() {
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: Column(
        children: <Widget>[
          TextFormField(
            // Username field
            validator: (value) {
              if (value!.isEmpty) {
                return "Username is required";
              }
            },
            controller: usernameController,
            decoration: InputDecoration(
              label: Text("Username"),
              prefixIcon: Icon(Icons.person),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
          ),
          SizedBox(
            height: 10,
          ),
          TextFormField(
            // Phone number field
            validator: (value) {
              if (value!.isEmpty) {
                return "Phone no. is Required";
              }
            },
            controller: userphoneController,
            decoration: InputDecoration(
              label: Text("Phone"),
              prefixIcon: Icon(Icons.phone),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
          ),
          SizedBox(
            height: 10,
          ),
          TextFormField(
            // Email field
            validator: (value) {
              if (value!.isEmpty) {
                return "Email is Required";
              }
            },
            controller: useremailController,
            decoration: InputDecoration(
              label: Text("Email"),
              prefixIcon: Icon(Icons.email),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
          ),
          SizedBox(
            height: 10,
          ),
          TextFormField(
            // Password field
            validator: (value) {
              if (value!.isEmpty) {
                return "Password is Required";
              }
            },
            obscureText: _obsecuretext,
            controller: userpasswordController,
            decoration: InputDecoration(
              label: Text("Password"),
              prefixIcon: Icon(Icons.password),
              suffixIcon: IconButton(
                onPressed: () {
                  setState(() {
                    _obsecuretext = !_obsecuretext;
                  });
                },
                icon: _obsecuretext
                    ? Icon(Icons.visibility_off)
                    : Icon(Icons.visibility),
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
          ),
          SizedBox(
            height: 20,
          ),
          ElevatedButton(
            onPressed: () {
              if (_formkey.currentState!.validate()) {
                var username = usernameController.text.trim();
                var userphone = userphoneController.text.trim();
                var useremail = useremailController.text.trim();
                var userpassword = userpasswordController.text.trim();

                FirebaseAuth.instance
                    .createUserWithEmailAndPassword(
                      email: useremail,
                      password: userpassword,
                    )
                    .then((value) => {
                          print("User Created"),
                          FirebaseFirestore.instance
                              .collection('users')
                              .doc()
                              .set({
                            "UserName": username,
                            "UserPhoneNo": userphone,
                            "UserEmaiId": useremail,
                          }),
                          Fluttertoast.showToast(
                            msg: "Registration Successfully",
                            backgroundColor: Colors.white,
                            textColor: Colors.black,
                          ),
                        });
                Get.to(() => LoginScreen());
              } else {
                Fluttertoast.showToast(
                    msg: 'Registration Failed',
                    backgroundColor: Colors.redAccent);
              }
            },
            child: Text(
              'Register',
              style: TextStyle(color: Colors.black),
            ),
          ),
          Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("Already Have an Account ?  "),
                GestureDetector(
                  onTap: () {
                    // Navigate to login page based on the selected role
                    Get.to(() => LoginScreen());
                  },
                  child: Text(
                    "Log in",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget policeRegistrationWidget() {
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: Column(
        children: <Widget>[
          TextFormField(
            validator: (value) {
              if (value!.isEmpty) {
                return "Policename is Required";
              }
            },
            controller: policenameController,
            decoration: InputDecoration(
              label: Text("PoliceName"),
              prefixIcon: Icon(Icons.person),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
          ),
          SizedBox(
            height: 10,
          ),
          TextFormField(
            validator: (value) {
              if (value!.isEmpty) {
                return "Id is Required";
              }
            },
            keyboardType: TextInputType.emailAddress,
            controller: idController,
            decoration: InputDecoration(
              label: Text('Id'),
              hintText: "ID in Your Id Card",
              prefixIcon: const Icon(
                Icons.security,
              ),
              fillColor: Colors.black,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(15),
              ),
            ),
          ),
          SizedBox(
            height: 10,
          ),
          TextFormField(
            validator: (value) {
              if (value!.isEmpty) {
                return "Email is Required";
              }
            },
            keyboardType: TextInputType.emailAddress,
            controller: loginnameController,
            decoration: InputDecoration(
              label: Text('Email'),
              prefixIcon: const Icon(
                Icons.email,
              ),
              fillColor: Colors.black,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(15),
              ),
            ),
          ),
          SizedBox(
            height: 10,
          ),
          TextFormField(
            validator: (value) {
              if (value!.isEmpty) {
                return "Password is Required";
              }
            },
            obscureText: _obsecuretext,
            controller: loginpasswordController,
            decoration: InputDecoration(
              label: Text('Password'),
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
                      ),
              ),
              fillColor: Colors.black,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(15),
              ),
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Text(
            'Upload your Police Id ',
            style: TextStyle(
              fontSize: 20,
            ),
          ),
          SizedBox(height: 10.0),
          ElevatedButton(
            onPressed: _uploadFile,
            child: Text('Select and Upload File'),
          ),
          Text(
            'Captcha Code : $captchaChallenge',
            style: TextStyle(fontSize: 20),
          ),
          SizedBox(height: 20.0),
          TextFormField(
            controller: captchaController,
            decoration: InputDecoration(
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.grey),
                borderRadius: BorderRadius.circular(12),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.redAccent),
                borderRadius: BorderRadius.circular(12),
              ),
              labelText: 'Enter Code',
              prefixIcon: Icon(Icons.verified, color: Colors.black),
              fillColor: Colors.grey[100],
              filled: true,
            ),
            validator: (value) {
              if (value!.isEmpty) {
                return 'Please Enter a Valid Code.';
              }
            },
          ),
          SizedBox(height: 10.0),
          ElevatedButton(
            onPressed: () {
              if (_formkey.currentState!.validate()) {
                var name = policenameController.text.trim();
                var id = idController.text.trim();
                var email = loginnameController.text.trim();
                var pass = loginpasswordController.text.trim();

                FirebaseAuth.instance
                    .createUserWithEmailAndPassword(
                      email: email,
                      password: pass,
                    )
                    .then((value) => {
                          print("User Created"),
                          FirebaseFirestore.instance
                              .collection('Police')
                              .doc()
                              .set({
                            "PoliceName": name,
                            "PoliceID": id,
                            "PoliceEmaiId": email,
                          }),
                          Fluttertoast.showToast(
                            msg: "Registration Successfully",
                            backgroundColor: Colors.white,
                            textColor: Colors.black,
                          ),
                        });
                String userResponse = captchaController.text;
                if (userResponse.toLowerCase() ==
                    captchaChallenge.toLowerCase()) {
                  // CAPTCHA response is correct, navigate to NextPage
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => policelogin(),
                    ),
                  );
                } else {
                  setState(() {
                    captchaChallenge = generateRandomString();
                  });
                  // CAPTCHA response is incorrect
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('Incorrect CAPTCHA. Please Try Again.'),
                    ),
                  );
                }
              }
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.black87,
            ),
            child: Text(
              'Register',
              style: TextStyle(color: Colors.white),
            ),
          ),
          Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("Already Have An Account ?  "),
                GestureDetector(
                  onTap: () {
                    // Navigate to login page based on the selected role
                    Get.to(() => policelogin());
                  },
                  child: Text(
                    "Log in",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 20,
          ),
        ],
      ),
    );
  }
}
