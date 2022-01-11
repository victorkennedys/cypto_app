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
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          BlackPinkText(blackText: "Dina", pinkText: "Hundar"),
          /* AppButton(
              buttonColor: kPurpleColor,
              textColor: Colors.white,
              onPressed: () {
                Navigator.pushNamed(context, AddDogScreen.id);
              },
              buttonText: "Lägg till en hund"), */
          UserDogList(),
        ],
      ),
      bottomNavigationBar: NavBar(1),
    );
  }
}
