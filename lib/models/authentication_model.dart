import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AuthenticationModel {
  authenticateNumber(
      {required String verificationCode,
      required String inputCode,
      required bool newUser,
      required String phone}) async {
    var dogOwners = FirebaseFirestore.instance.collection('dog owners');
    await FirebaseAuth.instance
        .signInWithCredential(PhoneAuthProvider.credential(
            verificationId: verificationCode, smsCode: inputCode))
        .then((response) async {
      if (response.user != null) {
        if (newUser == true) {
          dogOwners.doc(phone).set({'phone': phone});
        }
      }
    });
  }
}
