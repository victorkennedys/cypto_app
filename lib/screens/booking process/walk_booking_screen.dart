import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:woof/components/app_button.dart';
import 'package:woof/components/black_and_pink_text.dart';
import 'package:woof/components/form_question_text.dart';
import 'package:woof/components/toggle_button.dart';
import 'package:woof/constants.dart';
import 'package:woof/screens/booking%20process/confirmed_advert.dart';

final _firestore = FirebaseFirestore.instance;
final _auth = FirebaseAuth.instance;
final user = _auth.currentUser;

class BookWalkScreen extends StatefulWidget {
  final List<String> dogList;
  BookWalkScreen(this.dogList);
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
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0.0,
      ),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.only(
            left: MediaQuery.of(context).size.width / 12,
            right: MediaQuery.of(context).size.width / 12,
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
                        TogButtons(getWalkLength, buttonSelected),
                        FormQuestionText("Vilken dag Zoe sin promenad"),
                        DateTimePicker(selectedDateTime.toString(), selectDate),
                        FormQuestionText("Vart ska Zoe upphämtas?"),
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
                    onPressed: () {
                      _firestore.collection("adverts").add({
                        'dogs': widget.dogList,
                        'creator': user?.email,
                        'length': length,
                        'datetime': selectedDateTime,
                        'meetup spot': meetUpSpot,
                        'booking type': "promenad",
                      });
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ConfirmedAdvert(widget.dogList,
                              length, selectedDateTime, meetUpSpot),
                        ),
                      );
                    },
                  ))
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
