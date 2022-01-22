import 'package:flutter/material.dart';
import 'package:woof/components/black_and_pink_text.dart';
import 'package:woof/main.dart';

class WalkerHomeScreen extends StatelessWidget {
  Map<String, dynamic> userData;
  WalkerHomeScreen(this.userData);
  static const String id = 'walker_home_screen';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      body: Padding(
        padding: WelcomeScreen.defaultPadding(context),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            BlackPinkText(blackText: "Hej", pinkText: userData['first name'])
          ],
        ),
      ),
    );
  }
}
