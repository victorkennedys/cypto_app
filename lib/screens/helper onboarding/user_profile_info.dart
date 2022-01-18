import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:woof/components/input%20widgets/form_question_text.dart';
import 'package:woof/components/input%20widgets/input_field.dart';
import 'package:woof/constants.dart';
import 'package:woof/main.dart';

final _auth = FirebaseAuth.instance;
final User? user = _auth.currentUser;

class HelperProfileInfo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: kAppBar,
      extendBodyBehindAppBar: true,
      body: Padding(
        padding: Woof.defaultPadding(context),
        child: Column(
          children: [
            Row(
              children: [
                Flexible(
                  child: InputField("Förnamn", true, () {}),
                ),
                Flexible(
                  child: InputField("Efternamn", true, () {}),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
