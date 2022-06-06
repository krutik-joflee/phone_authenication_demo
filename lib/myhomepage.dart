// ignore_for_file: avoid_print

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:phone_authenication_demo/otp.dart';

FirebaseAuth auth = FirebaseAuth.instance;
TextEditingController numbercontroller = TextEditingController();

class MyHomePage extends StatelessWidget {
  MyHomePage({Key? key}) : super(key: key);

  String verificationID = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Phone Authentication"),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: TextFormField(
                controller: numbercontroller,
                // ignore: prefer_const_constructors
                decoration: InputDecoration(
                    hintText: 'Enter phonenumber', labelText: 'Phone'),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: ElevatedButton(
                  onPressed: () async {
                    await FirebaseAuth.instance.verifyPhoneNumber(
                      phoneNumber: '+91${numbercontroller.text}',
                      verificationCompleted:
                          (PhoneAuthCredential credential) async {},
                      verificationFailed: (FirebaseAuthException e) {
                        if (e.code == 'invalid-phone-number') {
                          print('the number is invalid');
                        }
                      },
                      codeSent:
                          (String verificationId, int? resendToken) async {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => OtpScreen(
                                      verficationId: verificationId,
                                    )));
                      },
                      timeout: const Duration(seconds: 60),
                      codeAutoRetrievalTimeout: (String verificationId) {},
                    );
                  },
                  child: const Text('Submit')),
            )
          ],
        ),
      ),
    );
  }
}
