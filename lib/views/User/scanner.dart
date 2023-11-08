// ignore_for_file: use_key_in_widget_constructors, library_private_types_in_public_api, use_build_context_synchronously, prefer_const_constructors, unused_local_variable, unnecessary_import, unnecessary_new

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:policefeedback/views/User/feedback.dart';
import 'package:policefeedback/views/User/userlogin.dart';

class IFlutterBarcodeScanner extends StatefulWidget {
  @override
  _IFlutterBarcodeScannerState createState() => _IFlutterBarcodeScannerState();
}

class _IFlutterBarcodeScannerState extends State<IFlutterBarcodeScanner> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  String _scanBarcode = 'Unknown';

  Future<void> scanQR() async {
    String barcodeScanRes;
    try {
      barcodeScanRes = await FlutterBarcodeScanner.scanBarcode(
        '#ff6666',
        'Cancel',
        true,
        ScanMode.QR,
      );
      debugPrint("Scanned Data: $barcodeScanRes");
      // String uniqueIdentifier = 'mylogin3_qr';
      if (barcodeScanRes.startsWith('ㅤ')) {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => feedbackform(
              feedbackFormUrl: barcodeScanRes,
            ),
          ),
        );
      }
    } on PlatformException {
      barcodeScanRes = 'Failed to get platform version.';
    }

    if (!mounted) return;

    setState(() {
      _scanBarcode = barcodeScanRes;
    });

    User? user = _auth.currentUser;
    if (user != null) {
      DocumentSnapshot userDetails =
          await _firestore.collection("users").doc(user.uid).get();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Color.fromARGB(30, 107, 107, 107),
        title: Text(
          'Barcode Scanner',
          style: TextStyle(color: Colors.black),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: GestureDetector(
                onTap: () {
                  FirebaseAuth.instance.signOut();
                  Get.off(() => LoginScreen());
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
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              ElevatedButton(
                onPressed: () => scanQR(),
                child: Text('Start QR Scan'),
              ),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Text('Scan Result: $_scanBarcode\n',
                    style: TextStyle(fontSize: 20)),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
