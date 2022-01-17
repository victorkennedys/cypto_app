import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:woof/screens/dog/my_dogs.dart';

final _auth = FirebaseAuth.instance;
final User? loggedInUser = _auth.currentUser;

class UserAdverts extends StatelessWidget {
  const UserAdverts({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: FirebaseFirestore.instance
          .collection('adverts')
          .where('creator', isEqualTo: loggedInUser?.phoneNumber)
          .get(),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return Text("error");
        }
        if (snapshot.connectionState == ConnectionState.waiting) {
          return CircularProgressIndicator();
        }
        if (snapshot.connectionState == ConnectionState.done) {
          Map map = snapshot.data as Map<String, dynamic>;
          print(map);
        }
        return Text("Loading");
      },
    );
  }
}
