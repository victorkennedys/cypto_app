import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:woof/components/app_button.dart';
import 'package:woof/components/black_and_pink_text.dart';
import 'package:woof/components/input%20widgets/form_question_text.dart';
import 'package:woof/components/input%20widgets/input_field.dart';
import 'package:woof/constants.dart';
import 'package:woof/main.dart';
import 'package:intl/intl.dart';

final _auth = FirebaseAuth.instance;
final User? user = _auth.currentUser;

Map<String, dynamic> dataMap = {};
final _scaffoldKey = GlobalKey<ScaffoldState>();

getFirstName(String value) {
  String firstName = value;
  dataMap.addAll({'first name': firstName});
}

getLastName(String value) {
  String lastName = value;
  dataMap.addAll({'last name': lastName});
}

getAdress(String value) {
  String adress = value;
  dataMap.addAll({'adress': adress});
}

getCity(String value) {
  String city = value;
  dataMap.addAll({'city': city});
}

getPostNumber(String value) {
  String postNumber = value;
  dataMap.addAll({'post number': postNumber});
}

getDay(String value) {
  int day = int.parse(value);
  dataMap.addAll({'day': day});
}

getMonth(String value) {
  int month = int.parse(value);

  dataMap.addAll({'month': month});
}

getYear(String value) {
  int year = int.parse(value);

  dataMap.addAll({'year': year});
}

class HelperProfileInfo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      key: _scaffoldKey,
      appBar: kAppBar,
      extendBodyBehindAppBar: true,
      body: Padding(
        padding: Woof.defaultPadding(context),
        child: MediaQuery.removePadding(
          context: context,
          removeTop: true,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                height: MediaQuery.of(context).size.height * 0.9,
                child: ListView(
                  /*  crossAxisAlignment: CrossAxisAlignment.start, */
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        BlackPinkText(blackText: "Ange din", pinkText: "info"),
                        FormQuestionText("Namn"),
                        Row(
                          children: [
                            Flexible(
                              child: InputField(
                                  "Förnamn", true, getFirstName, null),
                            ),
                            Flexible(
                              child: InputField(
                                  "Efternamn", true, getLastName, null),
                            ),
                          ],
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            FormQuestionText("Adress"),
                            InputField("Adress", true, getAdress, null),
                            SizedBox(
                              height: 20,
                            ),
                            Row(
                              children: [
                                Flexible(
                                  child:
                                      InputField("Stad", true, getCity, null),
                                ),
                                Flexible(
                                  child: InputField(
                                      "Postnummer", true, getPostNumber, null),
                                ),
                              ],
                            ),
                          ],
                        ),
                        FormQuestionText("Ålder"),
                        Row(
                          children: [
                            Flexible(
                              child: InputField("D", true, getDay, true),
                            ),
                            Flexible(
                              child: InputField("M", true, getMonth, true),
                            ),
                            Flexible(
                              child: InputField("Å", true, getYear, true),
                            ),
                          ],
                        ),
                      ],
                    ),
                    Container(
                      height: 250,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          AppButton(
                              buttonColor: kPurpleColor,
                              textColor: kPinkColor,
                              onPressed: () {
                                popFunction(context);
                              },
                              buttonText: "Klar"),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  popFunction(BuildContext context) {
    if (dataMap.containsKey('first name') &&
        dataMap.containsKey('last name') &&
        dataMap.containsKey('adress') &&
        dataMap.containsKey('city') &&
        dataMap.containsKey('post number') &&
        dataMap.containsKey('day') &&
        dataMap.containsKey('month') &&
        dataMap.containsKey('year')) {
      DateTime birthDay =
          DateTime.utc(dataMap['year'], dataMap['month'], dataMap['day']);

      dataMap.addAll({'birthday': birthDay});
      dataMap.remove('day');
      dataMap.remove('month');
      dataMap.remove('year');

      Navigator.pop(context, dataMap);
    } else if (dataMap.containsKey('first name') != false) {
      print("....");
      showSnackBar("Ange ditt namn", context);
    }
    ;
  }

  showSnackBar(String errorMessage, BuildContext context) {
    _scaffoldKey.currentState?.showSnackBar(
      kSnackBar(errorMessage),
    );
  }
}
