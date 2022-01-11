import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:woof/screens/add_dog.dart';
import 'package:woof/screens/home_screen.dart';
import 'package:woof/screens/login_screen.dart';
import 'package:woof/screens/my_dogs.dart';
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
      initialRoute: WelcomeScreen.id,
      routes: {
        WelcomeScreen.id: (context) => WelcomeScreen(),
        LoginScreen.id: (context) => LoginScreen(),
        RegistrationScreen.id: (context) => RegistrationScreen(),
        Home.id: (context) => Home(),
        AddDogScreen.id: (context) => AddDogScreen(),
        MyDogs.id: (context) => MyDogs(),
      },
    );
  }
}

class WelcomeScreen extends StatelessWidget {
  static const String id = 'welcome_screen';
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
                  Navigator.pushNamed(context, RegistrationScreen.id);
                },
                buttonText: "Kom igång!",
              ),
            ),
            TextButton(
              child: Text("Redan registrerad? Logga in"),
              onPressed: () {
                Navigator.pushNamed(context, LoginScreen.id);
              },
            )
          ],
        ),
      ),
    );
  }
}
