import 'package:flutter/material.dart';
import 'package:woof/components/black_and_pink_text.dart';
import 'package:woof/components/input%20widgets/checkbox.dart';
import 'package:woof/main.dart';

class HelperInfoScreen extends StatelessWidget {
  List servicesList = [];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: Woof.defaultPadding(context),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            BlackPinkText(
                blackText: "Vilka tjänster vill", pinkText: "du erbjuda?"),
            DogHelpService("images/dog-leash.png", "Promenader", servicesList,
                "Ta ut hundar på promenad 30 eller 60 minuter"),
            DogHelpService("images/home.png", "Hempassning", servicesList,
                "Ta ut hundar på promenad 30 eller 60 minuter"),
            DogHelpService("images/route.png", "Hämta och lämna", servicesList,
                "Ta ut hundar på promenad 30 eller 60 minuter"),
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
        padding: EdgeInsets.all(20),
        child: Row(
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
                          style: TextStyle(fontSize: 12, color: Colors.black45),
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
      ),
      width: double.infinity,
      decoration: BoxDecoration(),
    );
  }
}
