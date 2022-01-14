import 'package:flutter/material.dart';
import 'package:woof/components/app_button.dart';
import 'package:woof/components/black_and_pink_text.dart';
import 'package:woof/components/form_question_text.dart';
import 'package:woof/components/input_field.dart';
import 'package:woof/components/toggle_button.dart';
import 'package:woof/constants.dart';

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
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 21),
                          child: Container(
                            height: 50,
                            width: double.infinity,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              border:
                                  Border.all(color: Colors.black45, width: 1),
                            ),
                            child: Row(
                              children: [
                                Flexible(
                                  child: Container(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 7, vertical: 7),
                                    child: Image.asset('images/dog.png'),
                                  ),
                                ),
                                Flexible(
                                  child: Text("Lägg till din hund"),
                                ),
                              ],
                            ),
                          ),
                        ),
                        TogButtons(setNumberOfDogs, buttonSelected, "1", "2")
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
