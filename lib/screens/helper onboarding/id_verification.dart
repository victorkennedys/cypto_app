import 'package:flutter/material.dart';
import 'package:woof/components/app_button.dart';
import 'package:woof/constants.dart';

class IdVerificationScreen extends StatelessWidget {
  Future<void> onfido() async {
    try {} catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          AppButton(
              buttonColor: kPurpleColor,
              textColor: kPinkColor,
              onPressed: () {},
              buttonText: 'verifiera')
        ],
      ),
    );
  }
}
