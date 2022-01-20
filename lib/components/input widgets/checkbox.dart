import 'package:flutter/material.dart';

import '../../constants.dart';

class FormCheckBox extends StatefulWidget {
  final Function callBack;
  const FormCheckBox(this.callBack, {Key? key}) : super(key: key);
  @override
  State<FormCheckBox> createState() => _FormCheckBoxState();
}

class _FormCheckBoxState extends State<FormCheckBox> {
  bool isSelected = false;
  selectionSetter() {
    if (isSelected == false) {
      setState(() {
        isSelected = true;
        widget.callBack(true);
      });
    } else {
      setState(() {
        isSelected = false;
        widget.callBack(false);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        selectionSetter();
      },
      child: Container(
        child: Icon(
          Icons.check,
          color: isSelected ? kPurpleColor : Colors.transparent,
        ),
        decoration: BoxDecoration(
          border: Border.all(color: Colors.black45),
          borderRadius: BorderRadius.circular(10),
        ),
      ),
    );
  }
}
