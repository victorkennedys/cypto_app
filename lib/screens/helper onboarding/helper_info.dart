import 'package:flutter/material.dart';
import 'package:woof/components/app_button.dart';
import 'package:woof/components/black_and_pink_text.dart';
import 'package:woof/constants.dart';
import 'package:woof/main.dart';

class HelperInfoScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: Woof.defaultPadding(context),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            BlackPinkText(blackText: "Bli hundpassare", pinkText: "på woof"),
            AppButton(
                buttonColor: kPurpleColor,
                textColor: kPinkColor,
                onPressed: () {},
                buttonText: "Kom igång")
          ],
        ),
      ),
    );
  }
}
