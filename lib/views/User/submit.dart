// ignore_for_file: camel_case_types, prefer_const_constructors, unnecessary_new

import 'package:flutter/material.dart';

class sub extends StatefulWidget {
  const sub({super.key});

  @override
  State<sub> createState() => _subState();
}

class _subState extends State<sub> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(30, 107, 107, 107),
        automaticallyImplyLeading: false,
        title: Text(
          'Thank You',
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
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              SizedBox(height: 20),
              Text(
                'Thank You for Your Support!',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 10),
              Text(
                'We appreciate your kindness and cooperation.',
                style: TextStyle(fontSize: 16),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  // You can add actions or navigate to other screens here.
                },
                child: Text('Take Your Rewards'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
