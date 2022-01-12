import 'package:flutter/material.dart';
import 'package:woof/constants.dart';

class BlackPinkText extends StatelessWidget {
  final String blackText;
  final String pinkText;

  BlackPinkText({required this.blackText, required this.pinkText});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          blackText,
          style: kH1Text,
        ),
        Text(
          pinkText,
          style: kH1Text.copyWith(color: kPinkColor),
        ),
      ],
    );
  }
}
