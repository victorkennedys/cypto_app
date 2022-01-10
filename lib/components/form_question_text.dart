import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class FormQuestionText extends StatelessWidget {
  final String question;
  FormQuestionText(this.question);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 21, vertical: 21),
      child: Text(
        question,
        style:
            GoogleFonts.montserrat(fontSize: 16, fontWeight: FontWeight.w400),
      ),
    );
  }
}
