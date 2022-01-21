import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

final _auth = FirebaseAuth.instance;

class DogWalkerModel {
  Future<Map<String, dynamic>> getCurrentUser() async {
    final loggedInUserPhone = _auth.currentUser!.phoneNumber;
    var dogWalkers = FirebaseFirestore.instance.collection('dog walkers');
    final user = dogWalkers.doc(loggedInUserPhone);
    Map<String, dynamic> data = {};
    await user.get().then((DocumentSnapshot snapshot) {
      data = snapshot.data() as Map<String, dynamic>;
    });
    return data;
  }
}
