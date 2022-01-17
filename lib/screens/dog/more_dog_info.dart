import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:woof/components/app_button.dart';
import 'package:woof/components/black_and_pink_text.dart';
import 'package:woof/components/input%20widgets/checkbox.dart';
import 'package:woof/components/input%20widgets/form_question_text.dart';
import 'package:woof/components/input%20widgets/toggle_button.dart';
import 'package:woof/constants.dart';
import 'package:woof/main.dart';

class AddDogInfo extends StatefulWidget {
  final String name;
  final String docId;
  AddDogInfo(this.name, this.docId);

  @override
  State<AddDogInfo> createState() => _AddDogInfoState();
}

class _AddDogInfoState extends State<AddDogInfo> {
  bool leashTrained = false;
  bool goodWithDogs = false;
  bool goodWithPeople = false;
  bool goodWithKids = false;
  bool pottyTrained = false;
  leashCallback(bool selected) {
    setState(() {
      selected ? leashTrained = true : leashTrained = false;
    });
  }

  goodWithDogsCallBack(bool selected) {
    setState(() {
      selected ? goodWithDogs = true : goodWithDogs = false;
    });
  }

  goodWithPeopleCallBack(bool selected) {
    setState(() {
      selected ? goodWithPeople = true : goodWithPeople = false;
    });
  }

  goodWithKidsCallBack(bool selected) {
    setState(() {
      selected ? goodWithKids = true : goodWithKids = false;
    });
  }

  pottyTrainedCallBack(bool selected) {
    setState(() {
      selected ? pottyTrained = true : pottyTrained = false;
    });
  }

  List<bool> leashButtonSelected = [false, false];

  changeLeashButton(int index) {
    setState(() {
      print(index);
      if (index == 0) {
        leashButtonSelected[0] = true;
        leashButtonSelected[1] = false;
        leashTrained = true;
      }
      if (index == 1) {
        leashButtonSelected[0] = false;
        leashButtonSelected[1] = true;
        leashTrained = false;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: kAppBar,
      extendBodyBehindAppBar: true,
      body: Container(
        height: MediaQuery.of(context).size.height * 0.9,
        child: MediaQuery.removePadding(
          context: context,
          child: Padding(
            padding: Woof.defaultPadding(context),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                BlackPinkText(blackText: "Mer info om", pinkText: widget.name),
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    /* ToggleButtonQuestion("${widget.name} går bra i koppel?",
                        changeLeashButton, leashButtonSelected), */

                    CheckBoxQuestion(
                        "${widget.name} går bra i koppel?", leashCallback),
                    CheckBoxQuestion("${widget.name} trivs med andra hundar?",
                        goodWithDogsCallBack),
                    CheckBoxQuestion("${widget.name} passar bra med människor?",
                        goodWithPeopleCallBack),
                    CheckBoxQuestion("${widget.name} passar bra med barn?",
                        goodWithKidsCallBack),
                    CheckBoxQuestion(
                        "${widget.name} är rumsren?", pottyTrainedCallBack),
                  ],
                ),
                AppButton(
                    buttonColor: kPurpleColor,
                    textColor: kPinkColor,
                    onPressed: () {
                      onPressed();
                    },
                    buttonText: "Klar")
              ],
            ),
          ),
        ),
      ),
    );
  }

  onPressed() {
    FirebaseFirestore.instance.collection('dogs').doc(widget.docId).update({
      'leash trained': leashTrained,
      'good with other dogs': goodWithDogs,
      'good with people': goodWithPeople,
      'good with kids': goodWithKids,
      'potty trained': pottyTrained
    }).catchError((e) => print(e));
  }
}

class CheckBoxQuestion extends StatelessWidget {
  final String text;
  final Function callBack;
  CheckBoxQuestion(this.text, this.callBack);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        FormQuestionText(text),
        FormCheckBox(callBack),
      ],
    );
  }
}

class ToggleButtonQuestion extends StatelessWidget {
  final String questionText;
  final Function callback;
  final List<bool> buttonSelected;
  ToggleButtonQuestion(this.questionText, this.callback, this.buttonSelected);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(questionText),
        TogButtons(
            callback, buttonSelected, "ja", "nej", null, 2, null, null, null),
      ],
    );
  }
}
