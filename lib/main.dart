import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:woof/screens/signup_screen.dart';
import 'constants.dart';
import './components/app_button.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(Woof());
}

class Woof extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: LoginScreen(),
    );
  }
}

class LoginScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBgColor,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Padding(
              padding: EdgeInsets.only(bottom: 20),
              child: AppButton(
                buttonColor: kPurpleColor,
                textColor: kPinkColor,
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (BuildContext context) =>
                              RegistrationScreen()));
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
