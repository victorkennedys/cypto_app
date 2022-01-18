import 'package:flutter/material.dart';
import 'package:woof/components/black_and_pink_text.dart';
import 'package:woof/constants.dart';
import 'package:woof/main.dart';
import 'package:woof/screens/helper%20onboarding/helper_profile.dart';
import 'package:woof/screens/helper%20onboarding/id_verification.dart';
import 'package:woof/screens/helper%20onboarding/user_profile_info.dart';
import 'package:woof/screens/profile_screen.dart';

class HelperInfo extends StatelessWidget {
  final List<String> servicesList;
  HelperInfo(this.servicesList);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: kAppBar,
      body: Padding(
        padding: Woof.defaultPadding(context),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            BlackPinkText(
                blackText: "Registrera dig som", pinkText: "Hundhjälpare"),
            SizedBox(
              height: 50,
            ),
            Text(
              "Bygg din profil",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            Divider(),
            HelperInfoCategory(
              "Information om dig",
              "images/user.png",
              HelperProfileInfo(),
            ),
            HelperInfoCategory(
              "Verifiera din identitet",
              "images/identification.png",
              IdVerificationScreen(),
            ),
            HelperInfoCategory(
              "Skapa din profil",
              "images/dog-leash.png",
              CreateHelperProfileScreen(),
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
  HelperInfoCategory(this.text, this.icon, this.onTap);

  @override
  State<HelperInfoCategory> createState() => _HelperInfoCategoryState();
}

class _HelperInfoCategoryState extends State<HelperInfoCategory> {
  Map<String, dynamic> data = {};

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        data = await Navigator.push(context,
            MaterialPageRoute(builder: (context) => widget.onTap as Widget));
        setState(() {
          data;
        });
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
                    SizedBox(
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
                  ? Icon(
                      Icons.arrow_forward_ios,
                      color: Colors.black45,
                    )
                  : Icon(
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
