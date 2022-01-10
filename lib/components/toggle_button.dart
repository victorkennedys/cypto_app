import 'package:flutter/material.dart';
import 'package:woof/constants.dart';

class ToggleButtons1 extends StatefulWidget {
  @override
  _ToggleButtons1State createState() => _ToggleButtons1State();
}

class _ToggleButtons1State extends State<ToggleButtons1> {
  List<bool> isSelected = [true, false];
  @override
  Widget build(BuildContext context) {
    return ToggleButtons(
      direction: Axis.horizontal,
      isSelected: isSelected,
      fillColor: kPinkColor,
      borderRadius: BorderRadius.circular(30),
      children: [
        TogButton(),
        SizedBox(
          width: 20,
        ),
        TogButton(),
      ],
      onPressed: (int newIndex) {},
    );
  }
}

class TogButton extends StatelessWidget {
  const TogButton({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 40),
      child: Expanded(
        child: Text(
          "30 min",
          style: TextStyle(color: Colors.grey[100]),
        ),
      ),
    );
  }
}
