import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:woof/components/app_button.dart';
import 'package:woof/components/black_and_pink_text.dart';
import 'package:woof/components/dog_avatar.dart';
import 'package:woof/constants.dart';
import '../components/user_dog_list.dart';

class Home extends StatefulWidget {
  static const String id = 'home_screen';
  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  late User loggedInUser;

  final _auth = FirebaseAuth.instance;

  @override
  void initState() {
    getCurrentUser();
    super.initState();
  }

  void getCurrentUser() async {
    try {
      final user = await _auth.currentUser;
      if (user != null) {
        loggedInUser = user;
      }
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.only(
            left: MediaQuery.of(context).size.width / 10,
            right: MediaQuery.of(context).size.width / 10,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              BlackPinkText(
                blackText: "Vad behöver",
                pinkText: "Zoe?",
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height / 40,
              ),
              AppButton(
                  buttonColor: kPurpleColor,
                  textColor: kPinkColor,
                  onPressed: () {},
                  buttonText: "Promenad"),
              SizedBox(
                height: MediaQuery.of(context).size.height / 40,
              ),
              AppButton(
                  buttonColor: kPinkColor,
                  textColor: kPurpleColor,
                  onPressed: () {},
                  buttonText: "Hundpassning"),
              SizedBox(
                height: MediaQuery.of(context).size.height / 40,
              ),
              UserDogList(),
            ],
          ),
        ),
      ),
    );
  }
}
