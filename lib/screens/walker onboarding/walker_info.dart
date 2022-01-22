import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:woof/components/app_button.dart';
import 'package:woof/components/black_and_pink_text.dart';
import 'package:woof/components/input%20widgets/form_question_text.dart';
import 'package:woof/components/input%20widgets/input_field.dart';
import 'package:woof/constants.dart';
import 'package:woof/main.dart';

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

getEmail(String value) {
  String email = value;
  dataMap.addAll({'email': email});
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
        padding: WelcomeScreen.defaultPadding(context),
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
                        FormQuestionText("Email"),
                        InputField("Email", true, getEmail, null),
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
                      height: 80,
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
    print(dataMap);
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

      Navigator.pop(context, dataMap);
    } else {
      if (dataMap.length <= 6) {
        showSnackBar("Fyll i alla fält", context);
        return;
      }
      if (dataMap.containsKey('first name') == false) {
        showSnackBar("Ange ditt namn", context);
        return;
      }
      if (dataMap.containsKey('last name') == false) {
        showSnackBar("Ange ditt efternamn", context);
        return;
      }
      if (dataMap.containsKey('adress') == false) {
        showSnackBar("Ange din adress", context);
        return;
      }
      if (dataMap.containsKey('city') == false) {
        showSnackBar("Ange din stad", context);
        return;
      }
      if (dataMap.containsKey('post number') == false) {
        showSnackBar("Ange ditt postnummer", context);
        return;
      }
      if (dataMap.containsKey('day') == false) {
        showSnackBar("Ange din födelsedag", context);
        return;
      }
      if (dataMap.containsKey('month') == false) {
        showSnackBar("Ange din födelsemånad", context);
        return;
      }
      if (dataMap.containsKey('year') == false) {
        showSnackBar("Ange ditt födelseår", context);
        return;
      }
    }
  }

  showSnackBar(String errorMessage, BuildContext context) {
    _scaffoldKey.currentState?.showSnackBar(
      kSnackBar(errorMessage),
    );
  }
}
