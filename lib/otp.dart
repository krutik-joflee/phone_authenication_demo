// ignore_for_file: prefer_const_constructors, must_be_immutable

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:phone_authenication_demo/myhomepage.dart';

class OtpScreen extends StatelessWidget {
  OtpScreen({Key? key, required this.verficationId}) : super(key: key);

  final String verficationId;

  TextEditingController otpController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("OTP"),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: TextFormField(
                controller: otpController,
                decoration: InputDecoration(
                  hintText: 'Enter otp',
                  labelText: "OTP",
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: ElevatedButton(
                  onPressed: () async {
                    PhoneAuthCredential credential =
                        PhoneAuthProvider.credential(
                      verificationId: verficationId,
                      smsCode: otpController.text,
                    );
                    await auth.signInWithCredential(credential);
                  },
                  child: const Text("submit")),
            )
          ],
        ),
      ),
    );
  }
}
