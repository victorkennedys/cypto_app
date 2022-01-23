import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:woof/models/dog_model.dart';

final _auth = FirebaseAuth.instance;
var dogOwners = FirebaseFirestore.instance.collection('dog owners');

class DogOwnerModel {
  Future<Map<String, dynamic>> getCurrentUserData() async {
    final loggedInUserPhone = _auth.currentUser!.phoneNumber;

    final user = dogOwners.doc(loggedInUserPhone);
    Map<String, dynamic> data = {};
    await user.get().then((DocumentSnapshot snapshot) {
      data = snapshot.data() as Map<String, dynamic>;
    });
    List<dynamic> dogList = data['dogs'];
    List<Map<String, dynamic>> userDogList = [];
    for (String dog in dogList) {
      Map<String, dynamic> dogData = await DogModel().getDogData(dog);
      userDogList.add(dogData);
    }
    data.addAll({'user dogs data': userDogList});
    return data;
  }

  updateUserData(Map<String, dynamic> userData) {
    //adding location too!
    final loggedInUserPhone = _auth.currentUser!.phoneNumber;
    dogOwners.doc(loggedInUserPhone).update(userData);
  }
}
