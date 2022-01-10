import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:woof/constants.dart';
import '../components/h1_text.dart';

class RegistrationScreen extends StatelessWidget {
  final _auth = FirebaseAuth.instance;
  String email = '';
  String passWord = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBgColor,
      body: Column(
        children: [
          H1Text(
            //To change added padding from textfield
            blackText: "Kom igång med",
            pinkText: "Woof",
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height / 10,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: TextField(
              decoration: kInputDecoration,
            ),
          ),
        ],
      ),
    );
  }
}
