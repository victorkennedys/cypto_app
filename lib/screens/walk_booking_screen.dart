import 'package:flutter/material.dart';
import 'package:woof/components/app_button.dart';
import 'package:woof/components/black_and_pink_text.dart';
import 'package:woof/components/form_question_text.dart';
import 'package:woof/components/toggle_button.dart';
import 'package:woof/constants.dart';
import 'package:flutter/cupertino.dart';

class BookWalkScreen extends StatefulWidget {
  static const String id = 'book_walk_screen';

  @override
  State<BookWalkScreen> createState() => _BookWalkScreenState();
}

class _BookWalkScreenState extends State<BookWalkScreen> {
  DateTime date = DateTime.now();
  selectDate() async {
    DateTime? picked = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime.now(),
        lastDate: DateTime(DateTime.now().year + 1));

    if (picked != null) {
      setState(() {
        date = picked;
        print(date);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.only(
            left: MediaQuery.of(context).size.width / 12,
            right: MediaQuery.of(context).size.width / 12,
            top: MediaQuery.of(context).size.height / 40,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Flexible(
                flex: 2,
                child: BlackPinkText(
                    blackText: "Uppge detaljer om", pinkText: "promenaden"),
              ),
              Flexible(
                flex: 1,
                child: SizedBox(),
              ),
              Flexible(
                flex: 7,
                child: Card(
                  elevation: 8.0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(30)),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        FormQuestionText("Hur lång promenad behöver Zoe?"),
                        TogButtons(),
                        FormQuestionText("När behöver Zoe sin promenad"),
                        GestureDetector(
                          onTap: () {
                            selectDate();
                          },
                          child: Container(
                            margin: EdgeInsets.only(left: 20, right: 20),
                            child: TextField(
                              enabled: false,
                              decoration: kInputDecoration.copyWith(
                                  hintText: "${date.toString()}"),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Flexible(
                flex: 2,
                child: Container(),
              ),
              Flexible(
                  flex: 1,
                  child: AppButton(
                    buttonColor: kPurpleColor,
                    buttonText: "Fortsätt",
                    textColor: kPinkColor,
                    onPressed: () {},
                  ))
            ],
          ),
        ),
      ),
    );
  }
}
