import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:woof/components/app_button.dart';
import 'package:woof/constants.dart';
import 'package:woof/screens/home_screen.dart';
import '../components/black_and_pink_text.dart';

class LoginScreen extends StatelessWidget {
  static const String id = 'login_screen';
  final _auth = FirebaseAuth.instance;
  String email = '';
  String passWord = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBgColor,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.only(
            top: MediaQuery.of(context).size.height / 40,
            left: MediaQuery.of(context).size.width / 12,
            right: MediaQuery.of(context).size.width / 12,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              BlackPinkText(
                blackText: "Logga in på",
                pinkText: "Woof",
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height / 10,
              ),
              TextField(
                decoration:
                    kInputDecoration.copyWith(hintText: "Ange din email"),
                onChanged: (value) {
                  email = value;
                },
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height / 40,
              ),
              TextField(
                decoration:
                    kInputDecoration.copyWith(hintText: "Ange lösenord"),
                obscureText: true,
                onChanged: (value) {
                  passWord = value;
                },
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height / 40,
              ),
              AppButton(
                buttonColor: kPurpleColor,
                textColor: kPinkColor,
                onPressed: () async {
                  try {
                    final user = await _auth.signInWithEmailAndPassword(
                        email: email, password: passWord);
                    if (user != null) {
                      /* Navigator.pushNamed(context, Home.id); */

                      Navigator.pushNamed(context, Home.id);
                    }
                  } catch (e) {
                    print(e);
                  }
                },
                buttonText: "Logga in",
              )
            ],
          ),
        ),
      ),
    );
  }
}
