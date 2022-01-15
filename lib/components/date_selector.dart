import 'package:flutter/material.dart';

import '../constants.dart';

class DateSelector extends StatefulWidget {
  final Function callBack;
  DateSelector(this.callBack);
  @override
  State<DateSelector> createState() => _DateSelectorState();
}

class _DateSelectorState extends State<DateSelector> {
  DateTime? birthDay;

  selectDate() async {
    DateTime? picked = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(2000),
        lastDate: DateTime.now());

    if (picked != null) {
      setState(() {
        birthDay = picked;
      });
      widget.callBack(birthDay);
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        selectDate();
      },
      child: Container(
        margin: EdgeInsets.only(right: 20),
        child: TextField(
          enabled: false,
          decoration:
              kInputDecoration.copyWith(hintText: "${birthDay.toString()}"),
        ),
      ),
    );
  }
}
