import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:woof/components/app_button.dart';
import 'package:woof/components/black_and_pink_text.dart';
import 'package:woof/components/input%20widgets/form_question_text.dart';
import 'package:woof/components/input%20widgets/toggle_button.dart';
import 'package:woof/constants.dart';
import 'package:woof/screens/booking%20process/confirmed_advert.dart';

import '../../main.dart';

final _firestore = FirebaseFirestore.instance;
final _auth = FirebaseAuth.instance;
final user = _auth.currentUser;

class BookWalkScreen extends StatefulWidget {
  final List<String> dogList;
  final List<String> dogNameList;
  BookWalkScreen(this.dogList, this.dogNameList);
  static const String id = 'book_walk_screen';

  @override
  State<BookWalkScreen> createState() => _BookWalkScreenState();
}

class _BookWalkScreenState extends State<BookWalkScreen> {
  DateTime date = DateTime.now();
  TimeOfDay time = TimeOfDay.now();
  DateTime selectedDateTime = DateTime.now();
  String meetUpSpot = '';
  selectDate() async {
    DateTime? picked = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime.now(),
        lastDate: DateTime(DateTime.now().year + 1));

    if (picked != null) {
      setState(() {
        date = picked;
      });
      selectTime();
    }
  }

  selectTime() async {
    final TimeOfDay? picked =
        await showTimePicker(context: context, initialTime: TimeOfDay.now());
    if (picked != null) {
      setState(() {
        time = picked;
        selectedDateTime =
            DateTime(date.year, date.month, date.day, time.hour, time.minute);
      });
    }
  }

  List<bool> buttonSelected = [false, false];
  int length = 0;
  getWalkLength(int index) {
    setState(() {
      if (index == 0) {
        buttonSelected[0] = true;
        buttonSelected[1] = false;
        length = 30;
      } else if (index == 1) {
        buttonSelected[1] = true;
        buttonSelected[0] = false;
        length = 60;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: kAppBar,
      body: MediaQuery.removePadding(
        context: context,
        removeTop: true,
        child: Padding(
          padding: Woof.defaultPadding(context),
          child: ListView(
            /* crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start, */
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  BlackPinkText(
                      blackText: "Uppge detaljer om", pinkText: "promenaden"),
                  SizedBox(
                    height: 50,
                  ),
                  Card(
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
                        /* crossAxisAlignment: CrossAxisAlignment.start, */
                        children: [
                          FormQuestionText(widget.dogNameList.length == 1
                              ? "Hur lång promenad behöver ${widget.dogNameList[0]}?"
                              : "Hur lång promenad behöver hundarna"),
                          TogButtons(
                              getWalkLength,
                              buttonSelected,
                              "30 minuter",
                              "1 timme",
                              null,
                              2,
                              null,
                              null,
                              null),
                          FormQuestionText(widget.dogNameList.length == 1
                              ? "Vilken dag behöver ${widget.dogNameList[0]} promenad"
                              : "Vilken dag behöver hundarna promenad"),
                          DateTimePicker(
                              selectedDateTime.toString(), selectDate),
                          FormQuestionText(widget.dogNameList.length == 1
                              ? "Vart ska ${widget.dogNameList[0]} upphämtas"
                              : "Vart ska hundarna upphämtas"),
                          Container(
                            margin: EdgeInsets.only(left: 20, right: 20),
                            child: TextField(
                              decoration: kInputDecoration.copyWith(
                                  hintText: "Ange plats"),
                              onChanged: (value) {
                                meetUpSpot = value;
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 50,
                  ),
                  AppButton(
                    buttonColor: kPurpleColor,
                    buttonText: "Fortsätt",
                    textColor: kPinkColor,
                    onPressed: () {
                      _firestore.collection("adverts").add({
                        'dogs': widget.dogList,
                        'creator': user?.email ?? user?.phoneNumber,
                        'length': length,
                        'datetime': selectedDateTime,
                        'meetup spot': meetUpSpot,
                        'booking type': "promenad",
                        'helper accepted': "false"
                      });
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ConfirmedAdvert(widget.dogList,
                              length, selectedDateTime, meetUpSpot),
                        ),
                      );
                    },
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class DateTimePicker extends StatelessWidget {
  final String inputText;
  final Function onPressed;
  DateTimePicker(this.inputText, this.onPressed);
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        onPressed();
      },
      child: Container(
        margin: EdgeInsets.only(left: 20, right: 20),
        child: TextField(
          enabled: false,
          decoration: kInputDecoration.copyWith(hintText: "${inputText}"),
        ),
      ),
    );
  }
}
