import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:woof/components/dog_avatar.dart';

final _firestore = FirebaseFirestore.instance;
User loggedInUser = _auth.currentUser!;

final _auth = FirebaseAuth.instance;

class UserDogList extends StatefulWidget {
  @override
  State<UserDogList> createState() => _UserDogListState();
}

class _UserDogListState extends State<UserDogList> {
  List<DogCard> dogList = [];
  getDogList() async {
    await _firestore
        .collection('dogs')
        .where("owner", isEqualTo: loggedInUser.email)
        .get()
        .then((QuerySnapshot querySnapshot) {
      List<QueryDocumentSnapshot<Object?>> list = querySnapshot.docs;
      for (var doc in list) {
        final String dogName = doc.get("name");
        final String breed = doc.get("breed");
        final String birthDay = doc.get("birthday");
        final String imageUrl = doc.get("image1");
        print(imageUrl);

        dogList.add(DogCard(dogName, breed, birthDay, imageUrl));
      }
    });
  }

  @override
  void initState() {
    getDogList();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Column(
      children: dogList,
    );
  }
}

class DogCard extends StatelessWidget {
  final String name;
  final String breed;
  final String birthDay;
  final String imageUrl;

  DogCard(this.name, this.breed, this.birthDay, this.imageUrl);
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        DogAvatar(imageUrl),
        Column(
          children: [
            Text(name),
            Text(breed),
          ],
        ),
      ],
    );
  }
}
