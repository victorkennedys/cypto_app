import 'package:flutter/material.dart';
import 'package:woof/constants.dart';

class InputField extends StatelessWidget {
  //Add callback funtion for onchanged!
  final String hintText;
  final bool enabled;
  final Function setVariable;
  final bool? numberInput;
  InputField(this.hintText, this.enabled, this.setVariable, this.numberInput);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(right: 20),
      child: TextField(
        keyboardType:
            numberInput != null ? TextInputType.number : TextInputType.text,
        enabled: enabled,
        decoration: kInputDecoration.copyWith(
            hintText: "${hintText}",
            hintStyle: TextStyle(
              fontSize: 14,
            )),
        onChanged: (value) {
          setVariable(value);
        },
      ),
    );
  }
}
