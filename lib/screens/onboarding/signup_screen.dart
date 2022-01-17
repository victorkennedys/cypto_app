import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:woof/components/app_button.dart';
import 'package:woof/constants.dart';
import 'package:woof/screens/dog/add_dog.dart';
import '../../components/black_and_pink_text.dart';

class RegistrationScreen extends StatelessWidget {
  static const String id = 'registration_screen';
  final _auth = FirebaseAuth.instance;
  String email = '';
  String passWord = '';

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: EdgeInsets.only(
          top: MediaQuery.of(context).size.height / 40,
          left: MediaQuery.of(context).size.width / 12,
          right: MediaQuery.of(context).size.width / 12,
        ),
        child: Scaffold(
          backgroundColor: kBgColor,
          body: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              BlackPinkText(
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
                  decoration:
                      kInputDecoration.copyWith(hintText: "Ange din email"),
                  onChanged: (value) {
                    email = value;
                  },
                ),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height / 40,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: TextField(
                  decoration:
                      kInputDecoration.copyWith(hintText: "Välj ett lösenord"),
                  obscureText: true,
                  onChanged: (value) {
                    passWord = value;
                  },
                ),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height / 40,
              ),
              AppButton(
                buttonColor: kPurpleColor,
                textColor: kPinkColor,
                onPressed: () async {
                  try {
                    final newUser = await _auth.createUserWithEmailAndPassword(
                        email: email, password: passWord);
                    if (newUser != null) {
                      /* Navigator.pushNamed(context, AddDogScreen.id);
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => AddDogScreen(urlList))); */
                    }
                  } catch (e) {
                    print(e);
                  }
                },
                buttonText: "Klar",
              )
            ],
          ),
        ),
      ),
    );
  }
}
