import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

final _auth = FirebaseAuth.instance;
var dogWalkers = FirebaseFirestore.instance.collection('dog walkers');

class DogWalkerModel {
  Future<Map<String, dynamic>> getCurrentUser() async {
    final loggedInUserPhone = _auth.currentUser!.phoneNumber;

    final user = dogWalkers.doc(loggedInUserPhone);
    Map<String, dynamic> data = {};
    await user.get().then((DocumentSnapshot snapshot) {
      data = snapshot.data() as Map<String, dynamic>;
    });
    return data;
  }

  updateUserData(Map<String, dynamic> userData) {
    final loggedInUserPhone = _auth.currentUser!.phoneNumber;
    dogWalkers.doc(loggedInUserPhone).update(userData);
  }
}
