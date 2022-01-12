import 'package:flutter/material.dart';
import 'package:woof/constants.dart';

class InputField extends StatelessWidget {
  //Add callback funtion for onchanged!
  final String hintText;
  final bool enabled;
  final dynamic variable;
  InputField(this.hintText, this.enabled, this.variable);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(left: 20, right: 20),
      child: TextField(
        enabled: enabled,
        decoration: kInputDecoration.copyWith(hintText: "${hintText}"),
      ),
    );
  }
}
