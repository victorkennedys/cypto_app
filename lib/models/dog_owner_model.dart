import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

final _auth = FirebaseAuth.instance;
var dogOwners = FirebaseFirestore.instance.collection('dog owners');

class DogOwnerModel {
  Future<Map<String, dynamic>> getCurrentUser() async {
    final loggedInUserPhone = _auth.currentUser!.phoneNumber;

    final user = dogOwners.doc(loggedInUserPhone);
    Map<String, dynamic> data = {};
    await user.get().then((DocumentSnapshot snapshot) {
      data = snapshot.data() as Map<String, dynamic>;
    });
    return data;
  }

  updateUserData(Map<String, dynamic> userData) {
    //adding location too!
    final loggedInUserPhone = _auth.currentUser!.phoneNumber;
    dogOwners.doc(loggedInUserPhone).update(userData);
  }
}
