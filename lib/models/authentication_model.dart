import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthenticationModel {
  Future<bool> dogOwnerExists(String phone) async {
    var dogOwners = FirebaseFirestore.instance.collection('dog owners');
    bool newOwner;

    final user = await dogOwners.doc(phone).get();
    user.exists ? newOwner = false : newOwner = true;

    return newOwner;
  }

  Future<bool> dogWalkerExists(String phone) async {
    var dogWalkers = FirebaseFirestore.instance.collection('dog walkers');
    bool newWalker;

    final user = await dogWalkers.doc(phone).get();
    user.exists ? newWalker = false : newWalker = true;

    return newWalker;
  }

  authenticateNumber(
      {required String verificationCode,
      required String inputCode,
      required bool newUser,
      required bool newWalker,
      required String phone}) async {
    var dogOwners = FirebaseFirestore.instance.collection('dog owners');
    await FirebaseAuth.instance
        .signInWithCredential(PhoneAuthProvider.credential(
            verificationId: verificationCode, smsCode: inputCode))
        .then((response) async {
      if (response.user != null) {
        if (newUser && newWalker) {
          dogOwners.doc(phone).set({'phone': phone});
        }
      }
    });
  }
}
