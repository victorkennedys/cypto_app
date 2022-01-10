import 'package:flutter/material.dart';

class DogAvatar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(
        top: MediaQuery.of(context).size.height / 12,
        right: MediaQuery.of(context).size.width / 10,
      ),
      child: ClipOval(
        child: Image.asset(
          "images/Zoe.png",
          fit: BoxFit.cover,
          height: MediaQuery.of(context).size.height / 17,
          width: MediaQuery.of(context).size.height / 17,
        ),
      ),
    );
  }
}
