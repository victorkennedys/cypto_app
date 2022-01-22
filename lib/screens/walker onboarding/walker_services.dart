import 'package:flutter/material.dart';
import 'package:woof/components/app_button.dart';
import 'package:woof/components/black_and_pink_text.dart';
import 'package:woof/components/input%20widgets/checkbox.dart';
import 'package:woof/constants.dart';
import 'package:woof/main.dart';
import 'package:woof/screens/walker%20onboarding/walker_onboarding.dart';

class HelperServicesScreen extends StatelessWidget {
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  showSnackBar(String errorMessage, BuildContext context) {
    _scaffoldKey.currentState?.showSnackBar(
      kSnackBar(errorMessage),
    );
  }

  HelperServicesScreen({Key? key}) : super(key: key);
  List<String> servicesList = [];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      body: Padding(
        padding: WelcomeScreen.defaultPadding(context),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const BlackPinkText(
                blackText: "Vilka tjänster vill", pinkText: "du erbjuda?"),
            Column(
              children: [
                DogHelpService(
                    "images/dog-leash.png",
                    "Promenader",
                    servicesList,
                    "Ta ut hundar på promenad 30 eller 60 minuter"),
                DogHelpService("images/home.png", "Hempassning", servicesList,
                    "Ta hand om hunden hemma hos dig"),
                DogHelpService(
                    "images/route.png",
                    "Hämta och lämna",
                    servicesList,
                    "Hämta hunden på en plats promenera med den till en annan"),
                DogHelpService("images/stay-at-home.png", "Övernattning",
                    servicesList, "Hunden bor över hemma hos dig"),
              ],
            ),
            Expanded(
              child: AppButton(
                  buttonColor: kPurpleColor,
                  textColor: kPinkColor,
                  onPressed: () {
                    if (servicesList.isEmpty) {
                      showSnackBar("Du måste välja minst en tjänst", context);
                    } else {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              WalkerOnboardingScreen(servicesList),
                        ),
                      );
                    }
                  },
                  buttonText: "Fortsätt"),
            ),
          ],
        ),
      ),
    );
  }
}

class DogHelpService extends StatelessWidget {
  final String icon;
  final String text;
  final List servicesList;
  final String infoText;
  DogHelpService(this.icon, this.text, this.servicesList, this.infoText);

  callBack(bool selected) {
    selected ? servicesList.add(text) : servicesList.remove(text);
    print(servicesList);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 20),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Flexible(
                  child: Row(
                    children: [
                      Container(
                        child: Image.asset(icon),
                        height: 30,
                        width: 30,
                      ),
                      SizedBox(
                        width: 20,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            text,
                            style: TextStyle(fontSize: 15),
                          ),
                          Container(
                            width: 200,
                            child: Text(
                              infoText,
                              maxLines: 3,
                              style: TextStyle(
                                  fontSize: 12, color: Colors.black45),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                FormCheckBox(callBack),
              ],
            ),
            SizedBox(
              height: 10,
            ),
            Row(
              children: [
                Row(
                  children: [
                    Icon(
                      Icons.check,
                      color: kPinkColor,
                    ),
                    Text("Bestäm pris själv"),
                    Row(
                      children: [
                        Icon(
                          Icons.check,
                          color: kPinkColor,
                        ),
                        Text("Jobba när du vill"),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
      width: double.infinity,
      decoration: BoxDecoration(),
    );
  }
}
