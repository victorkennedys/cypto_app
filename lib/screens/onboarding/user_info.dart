import 'package:flutter/material.dart';
import 'package:woof/components/app_button.dart';
import 'package:woof/components/black_and_pink_text.dart';
import 'package:woof/components/form_question_text.dart';
import 'package:woof/components/input_field.dart';
import 'package:woof/constants.dart';
import 'package:woof/components/add_dog_to_profile.dart';

class UserEnterInfoScreen extends StatefulWidget {
  final bool newUser;
  UserEnterInfoScreen({required this.newUser});

  @override
  State<UserEnterInfoScreen> createState() => _UserEnterInfoScreenState();
}

class _UserEnterInfoScreenState extends State<UserEnterInfoScreen> {
  String name = '';

  setName(value) {
    setState(() {
      name = value;
    });
  }

  List<bool> buttonSelected = [false, false];
  int numberOfDogs = 0;

  setNumberOfDogs(int index) {
    setState(() {
      if (index == 0) {
        buttonSelected[0] = true;
        buttonSelected[1] = false;
        numberOfDogs = 1;
      } else if (index == 1) {
        buttonSelected[1] = true;
        buttonSelected[0] = false;
        numberOfDogs = 2;
      }
    });
  }

  List<AddDogWidget> addDogWidgetList = [AddDogWidget()];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.only(
            top: MediaQuery.of(context).size.height / 40,
            left: MediaQuery.of(context).size.width / 12,
            right: MediaQuery.of(context).size.width / 12,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Flexible(
                  child: BlackPinkText(
                      blackText: "Välkommen till", pinkText: "woof")),
              Flexible(
                flex: 3,
                child: Card(
                  elevation: 8.0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Container(
                    width: double.infinity,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        FormQuestionText("Vad heter du?"),
                        InputField("Ange ditt namn", true, setName),
                        FormQuestionText("Hur många hundar har du?"),
                        Column(
                          children: [
                            Column(
                              children: addDogWidgetList,
                            ),
                            Center(
                              child: GestureDetector(
                                onTap: () {
                                  if (addDogWidgetList[
                                          addDogWidgetList.length - 1]
                                      .dogData
                                      .isNotEmpty) {
                                    setState(() {
                                      addDogWidgetList.add(
                                        AddDogWidget(),
                                      );
                                    });
                                  }
                                },
                                child: Text("Lägg till en till hund"),
                              ),
                            )
                          ],
                        ),

                        /* TogButtons(setNumberOfDogs, buttonSelected, "1", "2") */
                      ],
                    ),
                  ),
                ),
              ),
              Flexible(
                  child: AppButton(
                      buttonColor: kPurpleColor,
                      textColor: kPinkColor,
                      onPressed: () {},
                      buttonText: "Klar"))
            ],
          ),
        ),
      ),
    );
  }
}