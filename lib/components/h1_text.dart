import 'package:flutter/material.dart';
import 'package:woof/constants.dart';

class H1Text extends StatelessWidget {
  final String blackText;
  final String pinkText;

  H1Text({required this.blackText, required this.pinkText});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: MediaQuery.of(context).size.width / 10,
        vertical: MediaQuery.of(context).size.height / 12,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            blackText,
            style: h1Text,
          ),
          Text(
            pinkText,
            style: h1Text.copyWith(color: kPinkColor),
          ),
        ],
      ),
    );
  }
}
