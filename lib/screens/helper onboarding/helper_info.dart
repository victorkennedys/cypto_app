import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:woof/components/app_button.dart';
import 'package:woof/components/black_and_pink_text.dart';
import 'package:woof/constants.dart';
import 'package:woof/main.dart';
import 'package:woof/models/stripe_model.dart';
import 'package:woof/screens/helper%20onboarding/helper_profile.dart';
import 'package:woof/screens/helper%20onboarding/id_verification.dart';
import 'package:woof/screens/helper%20onboarding/user_profile_info.dart';
import 'package:woof/screens/helper%20screens/helper_home.dart';

final _auth = FirebaseAuth.instance;

class HelperInfo extends StatelessWidget {
  final List<String> servicesList;
  HelperInfo(this.servicesList);

  Map<String, dynamic> dataMap = {};
  getUserDataMap(Map<String, dynamic> map) {
    for (var entries in map.entries) {
      final key = entries.key;
      final value = entries.value;
      dataMap.addAll({key: value});
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: kAppBar,
      body: Padding(
        padding: Woof.defaultPadding(context),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                BlackPinkText(
                    blackText: "Registrera dig som", pinkText: "Hundhjälpare"),
                const SizedBox(
                  height: 50,
                ),
                const Text(
                  "Bygg din profil",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                const Divider(),
                HelperInfoCategory("Information om dig", "images/user.png",
                    HelperProfileInfo(), getUserDataMap),
                HelperInfoCategory(
                    "Verifiera din identitet",
                    "images/identification.png",
                    IdVerificationScreen(),
                    getUserDataMap),
                HelperInfoCategory("Skapa din profil", "images/dog-leash.png",
                    CreateHelperProfileScreen(), getUserDataMap),
                HelperInfoCategory(
                    "Ta emot betalningar",
                    "images/credit-card (1).png",
                    CreateHelperProfileScreen(),
                    getUserDataMap),
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 20.0),
              child: AppButton(
                  buttonColor: kPurpleColor,
                  textColor: kPinkColor,
                  onPressed: () async {
                    StripeModel().registrationDone(
                      _auth.currentUser,
                      dataMap,
                    );

                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => HelperHomeScreen(),
                      ),
                    );
                  },
                  buttonText: "Klar"),
            ),
          ],
        ),
      ),
    );
  }
}

class HelperInfoCategory extends StatefulWidget {
  final String text;
  final String icon;
  final Widget onTap;
  final Function callBack;
  HelperInfoCategory(this.text, this.icon, this.onTap, this.callBack);

  @override
  State<HelperInfoCategory> createState() => _HelperInfoCategoryState();
}

class _HelperInfoCategoryState extends State<HelperInfoCategory> {
  Map<String, dynamic> data = {};

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        data = await Navigator.push(
            context, MaterialPageRoute(builder: (context) => widget.onTap));
        setState(() {
          data;
        });
        widget.callBack(data);
      },
      child: Container(
        child: Padding(
          padding: EdgeInsets.all(20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Flexible(
                child: Row(
                  children: [
                    Container(
                      child: Image.asset(widget.icon),
                      height: 30,
                      width: 30,
                    ),
                    const SizedBox(
                      width: 20,
                    ),
                    Flexible(
                      child: Text(
                        widget.text,
                        style: TextStyle(fontSize: 15),
                      ),
                    ),
                  ],
                ),
              ),
              data.isEmpty
                  ? const Icon(
                      Icons.arrow_forward_ios,
                      color: Colors.black45,
                    )
                  : const Icon(
                      Icons.check,
                      color: Colors.green,
                    )
            ],
          ),
        ),
        width: double.infinity,
        decoration: BoxDecoration(),
      ),
    );
  }
}
