import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:woof/components/app_button.dart';
import 'package:woof/components/nav_bar.dart';
import 'package:woof/constants.dart';
import 'package:woof/main.dart';
import 'package:woof/screens/helper%20onboarding/helper_info.dart';
import 'package:woof/screens/onboarding/user_info.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  static const String id = 'profile_screen';

  signOut(context) {
    FirebaseAuth.instance.signOut();

    Navigator.pushNamed(context, WelcomeScreen.id);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            AppButton(
                buttonColor: kPurpleColor,
                textColor: kPinkColor,
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => HelperInfoScreen()));
                },
                buttonText: "Bli hundpassare"),
            AppButton(
                buttonColor: kPinkColor,
                textColor: kPurpleColor,
                onPressed: () {
                  signOut(context);
                },
                buttonText: "logga ut")
          ],
        ),
      ),
      bottomNavigationBar: NavBar(3),
    );
  }
}
