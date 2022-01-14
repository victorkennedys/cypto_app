import 'package:flutter/material.dart';
import 'package:woof/constants.dart';

class TogButtons extends StatefulWidget {
  final String button1Text;
  final String button2Text;
  final Function function;
  final List<bool> buttonSelected;
  TogButtons(
      this.function, this.buttonSelected, this.button1Text, this.button2Text);
  @override
  _TogButtonsState createState() => _TogButtonsState();
}

class _TogButtonsState extends State<TogButtons> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: ToggleButtons(
        splashColor: Colors.transparent,
        fillColor: Colors.transparent,
        selectedBorderColor: Colors.transparent,
        borderRadius: BorderRadius.circular(30),
        borderColor: Colors.transparent,
        onPressed: (int index) {
          widget.function(index);
        },
        isSelected: widget.buttonSelected,
        children: [
          TogButton(widget.button1Text,
              widget.buttonSelected[0] ? kPinkColor : Colors.black38),
          TogButton(widget.button2Text,
              widget.buttonSelected[1] ? kPinkColor : Colors.black38),
        ],
      ),
    );
  }
}

class TogButton extends StatelessWidget {
  final String text;
  final Color borderColor;

  TogButton(this.text, this.borderColor);
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 5),
      decoration: BoxDecoration(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(30),
        border: Border.all(
            color: borderColor, width: borderColor == kPinkColor ? 2 : 1),
      ),
      width: MediaQuery.of(context).size.width * 0.32,
      height: MediaQuery.of(context).size.height * 0.05,
      child: Center(
        child: Text(text,
            style: kButtonTextStyle.copyWith(
                color: Colors.black,
                fontSize: 14,
                fontWeight: FontWeight.w200)),
      ),
    );
  }
}
