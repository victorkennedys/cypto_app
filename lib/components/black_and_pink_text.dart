import 'package:flutter/material.dart';
import 'package:woof/constants.dart';

class BlackPinkText extends StatelessWidget {
  final String blackText;
  final String pinkText;
  final dynamic bottomPaddingHigh;

  BlackPinkText(
      {required this.blackText,
      required this.pinkText,
      this.bottomPaddingHigh});

  @override
  Widget build(BuildContext context) {
    return /* Padding(
      padding: EdgeInsets.only(
        left: MediaQuery.of(context).size.width / 10,
        right: MediaQuery.of(context).size.width / 10,
        top: MediaQuery.of(context).size.height / 12,
        bottom: bottomPaddingHigh != true
            ? MediaQuery.of(context).size.height / 20
            : MediaQuery.of(context).size.height / 150,
      ),
      child: */
        Column(
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
    /* ); */
  }
}
