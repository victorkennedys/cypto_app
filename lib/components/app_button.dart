import 'package:flutter/material.dart';
import 'package:woof/constants.dart';
import 'package:google_fonts/google_fonts.dart';

class AppButton extends StatelessWidget {
  final Color buttonColor;
  final Color textColor;
  final dynamic onPressed;

  AppButton(
      {required this.buttonColor,
      required this.textColor,
      required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        decoration: BoxDecoration(
          color: kPurpleColor,
          borderRadius: BorderRadius.circular(20),
        ),
        width: MediaQuery.of(context).size.width * 0.9,
        height: MediaQuery.of(context).size.height * 0.08,
        child: MaterialButton(
          onPressed: onPressed,
          child: Text(
            "Kom igång!",
            style: GoogleFonts.montserrat(
              color: kPinkColor,
              fontSize: 18,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ),
    );
  }
}
