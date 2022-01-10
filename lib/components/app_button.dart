import 'package:flutter/material.dart';
import 'package:woof/constants.dart';

class AppButton extends StatelessWidget {
  final Color buttonColor;
  final Color textColor;
  final dynamic onPressed;
  final String buttonText;

  AppButton(
      {required this.buttonColor,
      required this.textColor,
      required this.onPressed,
      required this.buttonText});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        decoration: BoxDecoration(
          color: buttonColor,
          borderRadius: BorderRadius.circular(20),
        ),
        width: MediaQuery.of(context).size.width * 0.85,
        height: MediaQuery.of(context).size.height * 0.07,
        child: MaterialButton(
          onPressed: onPressed,
          child: Text(buttonText,
              style: kButtonTextStyle.copyWith(color: textColor)),
        ),
      ),
    );
  }
}
