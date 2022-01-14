import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:woof/screens/adverts/dashboard.dart';
import 'package:woof/screens/dog/my_dogs.dart';
import 'package:woof/screens/home_screen.dart';
import 'package:woof/screens/onboarding/login_screen.dart';
import 'package:woof/screens/dog/add_dog.dart';
import 'package:woof/screens/booking%20process/pick_dog_screen.dart';
import 'package:woof/screens/onboarding/otp.dart';
import 'package:woof/screens/onboarding/signup_screen.dart';
import 'package:woof/screens/profile_screen.dart';
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
        PickDogScreen.id: (context) => PickDogScreen(),
        AdvertsScreen.id: (context) => AdvertsScreen(),
        ProfileScreen.id: (context) => ProfileScreen(),
      },
    );
  }
}

class WelcomeScreen extends StatelessWidget {
  static const String id = 'welcome_screen';

  TextEditingController _phoneController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      backgroundColor: kBgColor,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Card(
            elevation: 8.0,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20), topRight: Radius.circular(20)),
            ),
            child: Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height * 0.2,
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text(
                          "Ange ditt",
                          style: kH1Text.copyWith(fontSize: 20),
                        ),
                        Text(
                          " telefonnummer",
                          style:
                              kH1Text.copyWith(fontSize: 20, color: kPinkColor),
                        )
                      ],
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    Container(
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Flexible(
                            flex: 2,
                            child: Row(
                              children: [
                                Container(
                                  width: 30,
                                  height: 20,
                                  child: Image.asset("images/sweden-flag.png"),
                                ),
                                Padding(
                                  padding: EdgeInsets.symmetric(horizontal: 10),
                                  child: Text(
                                    "+46",
                                    style: kH1Text.copyWith(fontSize: 15),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Flexible(
                            flex: 5,
                            child: TextField(
                              textInputAction: TextInputAction.done,
                              onSubmitted: (value) {
                                if (value.characters.length >= 9) {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => OTPScreen(
                                          phone: _phoneController.text),
                                    ),
                                  );
                                }
                              },
                              maxLength: 9,
                              style: TextStyle(color: Colors.black),
                              enabled: true,
                              keyboardType: TextInputType.numberWithOptions(
                                  decimal: false, signed: true),
                              decoration: kInputDecoration.copyWith(
                                fillColor: Colors.white,
                                filled: true,
                                hintText: "## #### ## ##",
                                border: UnderlineInputBorder(),
                              ),
                              controller: _phoneController,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
