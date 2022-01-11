import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:woof/components/app_button.dart';
import 'package:woof/components/black_and_pink_text.dart';
import 'package:woof/components/nav_bar.dart';
import 'package:woof/components/user_dog_list.dart';
import 'package:woof/constants.dart';
import 'package:woof/screens/add_dog.dart';

final _firestore = FirebaseFirestore.instance;
User loggedInUser = _auth.currentUser!;

final _auth = FirebaseAuth.instance;

class MyDogs extends StatefulWidget {
  static const String id = 'my_dogs_screen';

  @override
  State<MyDogs> createState() => _MyDogsState();
}

class _MyDogsState extends State<MyDogs> {
  /* List<DogCard> dogList = [];
  void getDogList() async {
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
        setState(() {
          dogList;
        });
      }
    });
  }

  @override
  void initState() {
    getDogList();

    super.initState();
  } */

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          BlackPinkText(blackText: "Dina", pinkText: "Hundar"),
          AppButton(
              buttonColor: kPinkColor,
              textColor: Colors.white,
              onPressed: () {
                Navigator.pushNamed(context, AddDogScreen.id);
              },
              buttonText: "Lägg till en hund"),
          UserDogList(),
        ],
      ),
      bottomNavigationBar: NavBar(1),
    );
  }
}
