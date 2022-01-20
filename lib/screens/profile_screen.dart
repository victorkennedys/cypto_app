import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:woof/components/nav_bar.dart';
import 'package:woof/main.dart';
import 'package:woof/screens/walker%20onboarding/walker_services.dart';

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
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ProfileScreenContainer("Bli hundpassare", "images/dog-leash.png",
                HelperServicesScreen()),
            ProfileScreenContainer("Mina hundar", "images/dog (1).png", null),
            ProfileScreenContainer("Min profil", "images/user.png", null),
            ProfileScreenContainer(
                "Mina hundhjälpare", "images/heart.png", null),
            ProfileScreenContainer(
                "Inställnignar", "images/settings.png", null),
          ],
        ),
      ),
      bottomNavigationBar: NavBar(4),
    );
  }
}

class ProfileScreenContainer extends StatelessWidget {
  final String text;
  final String icon;
  final Widget? onTap;
  ProfileScreenContainer(this.text, this.icon, this.onTap);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => onTap as Widget));
      },
      child: Container(
        child: Padding(
          padding: EdgeInsets.all(20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Flexible(
                child: Row(
                  children: [
                    Container(
                      child: Image.asset(icon),
                      height: 30,
                      width: 30,
                    ),
                    SizedBox(
                      width: 20,
                    ),
                    Flexible(
                      child: Text(
                        text,
                        style: TextStyle(fontSize: 15),
                      ),
                    ),
                  ],
                ),
              ),
              Icon(
                Icons.arrow_forward_ios,
                color: Colors.black45,
              ),
            ],
          ),
        ),
        width: double.infinity,
        decoration: BoxDecoration(),
      ),
    );
  }
}
