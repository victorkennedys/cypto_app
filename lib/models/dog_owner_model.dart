import 'package:cloud_firestore/cloud_firestore.dart';

class DogOwnerModel {
  var dogOwners = FirebaseFirestore.instance.collection('dog owners');

  Future<bool> userExists(String phone) async {
    bool newUser = true;
    await dogOwners
        .where('phone', isEqualTo: phone)
        .get()
        .then((QuerySnapshot querySnapshot) {
      if (querySnapshot.docs.length == 0) {
        newUser = true;
      } else {
        newUser = false;
      }
    });
    return newUser;
  }
}
