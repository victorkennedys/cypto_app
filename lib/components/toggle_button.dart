import 'package:flutter/material.dart';
import 'package:woof/constants.dart';

class TogButtons extends StatefulWidget {
  final Function callback;
  final List<bool> buttonSelected;
  final String button1Text;
  final String button2Text;
  final String? button3Text;
  final int numberOfButtons;
  final AssetImage? icon1;
  final AssetImage? icon2;
  final AssetImage? icon3;

  TogButtons(
      this.callback,
      this.buttonSelected,
      this.button1Text,
      this.button2Text,
      this.button3Text,
      this.numberOfButtons,
      this.icon1,
      this.icon2,
      this.icon3);
  @override
  _TogButtonsState createState() => _TogButtonsState();
}

class _TogButtonsState extends State<TogButtons> {
  getButtonsList() {
    if (widget.numberOfButtons == 2) {
      List<TogButton> buttonsList = [
        TogButton(
          widget.button1Text,
          widget.buttonSelected[0] ? kPinkColor : Colors.black38,
          widget.icon1,
        ),
        TogButton(
          widget.button2Text,
          widget.buttonSelected[1] ? kPinkColor : Colors.black38,
          widget.icon2,
        ),
      ];
      return buttonsList;
    }
    if (widget.numberOfButtons == 3) {
      List<TogButton> buttonsList = [
        TogButton(
          widget.button1Text,
          widget.buttonSelected[0] ? kPinkColor : Colors.black38,
          widget.icon1 ?? null,
        ),
        TogButton(
          widget.button2Text,
          widget.buttonSelected[1] ? kPinkColor : Colors.black38,
          widget.icon2 ?? null,
        ),
        TogButton(
          widget.button3Text!,
          widget.buttonSelected[2] ? kPinkColor : Colors.black38,
          widget.icon3 ?? null,
        ),
      ];
      return buttonsList;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ToggleButtons(
        constraints: BoxConstraints.expand(
            height: MediaQuery.of(context).size.height * 0.05,
            width: MediaQuery.of(context).size.width *
                (1 / widget.numberOfButtons) *
                0.8),
        splashColor: Colors.transparent,
        fillColor: Colors.transparent,
        selectedBorderColor: Colors.transparent,
        borderRadius: BorderRadius.circular(30),
        borderColor: Colors.transparent,
        onPressed: (int index) {
          widget.callback(index);
        },
        isSelected: widget.buttonSelected,
        children: getButtonsList(),
      ),
    );
  }
}

class TogButton extends StatelessWidget {
  final String text;
  final Color borderColor;
  final AssetImage? icon;

  TogButton(this.text, this.borderColor, this.icon);

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
      child: Center(
        child: Column(
          children: [
            icon != null ? icon as Widget : SizedBox(),
            Text(text,
                style: kButtonTextStyle.copyWith(
                    color: Colors.black,
                    fontSize: 14,
                    fontWeight: FontWeight.w200)),
          ],
        ),
      ),
    );
  }
}
