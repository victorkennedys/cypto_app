import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:woof/components/app_button.dart';
import 'package:woof/components/black_and_pink_text.dart';
import 'package:woof/constants.dart';
import 'package:woof/main.dart';
import 'package:woof/screens/helper%20onboarding/helper_profile.dart';
import 'package:woof/screens/helper%20onboarding/id_verification.dart';
import 'package:woof/screens/helper%20onboarding/user_profile_info.dart';
import 'package:http/http.dart' as http;
import 'package:network_info_plus/network_info_plus.dart';

final _firestore = FirebaseFirestore.instance;
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
            HelperInfoCategory("Information om dig", "images/user.png",
                HelperProfileInfo(), getUserDataMap),
            HelperInfoCategory(
                "Verifiera din identitet",
                "images/identification.png",
                IdVerificationScreen(),
                getUserDataMap),
            HelperInfoCategory("Skapa din profil", "images/dog-leash.png",
                CreateHelperProfileScreen(), getUserDataMap),
            AppButton(
                buttonColor: kPurpleColor,
                textColor: kPinkColor,
                onPressed: () async {
                  stripeConnect();
                },
                buttonText: "Klar")
          ],
        ),
      ),
    );
  }

  stripeConnect() async {
    final currentUser = _auth.currentUser;
    String? ip = await NetworkInfo().getWifiIP();

    String url = 'https://api.stripe.com/v1/accounts';
    Map<String, String> headers = {
      'Authorization': "Bearer $stripeSecretKey",
    };
    Map body = {
      'type': 'custom',
      'country': 'SE',
      'email': 'vict.kenn-2022@vrg.se',
      'capabilities[card_payments][requested]': 'true',
      'capabilities[transfers][requested]': 'true',
      'business_type': 'individual',
      'individual[first_name]': dataMap['first name'],
      'individual[last_name]': dataMap['last name'],
      'individual[dob][day]': dataMap['day'].toString(),
      'individual[dob][month]': dataMap['month'].toString(),
      'individual[dob][year]': dataMap['year'].toString(),
      'business_profile[mcc]': '7299',
      'individual[address][city]': dataMap['city'],
      'individual[address][line1]': dataMap['adress'],
      'individual[address][postal_code]': dataMap['post number'],
      'individual[email]': dataMap['email'],
      'individual[phone]': currentUser!.phoneNumber.toString(),
      'tos_acceptance[date]':
          (DateTime.now().millisecondsSinceEpoch / 1000).toInt().toString(),
      'tos_acceptance[ip]': ip,
      /* 'individual[verification][additional_document][front]':
          'https://firebasestorage.googleapis.com/v0/b/woof-ad9a6.appspot.com/o/uploads%2Fimage_picker_6E68A1D8-920F-4AFD-9220-39B81B4DBDBE-812-000006D457BE3ADE.jpg',
      'individual[verification][additional_document][back]':
          'https://firebasestorage.googleapis.com/v0/b/woof-ad9a6.appspot.com/o/uploads%2Fimage_picker_0E07F634-D055-42FE-BC83-42214425153A-812-000006D466A8B3F1.jpg' */
    };
    var data = await http.post(Uri.parse(url), headers: headers, body: body);

    var decodedData = jsonDecode(data.body);
    final stripeAccountId = decodedData['id'];

    final dogOwnersCollection = await _firestore
        .collection('dog owners')
        .doc(currentUser.phoneNumber)
        .get();

    /* Map<String, dynamic>? currentFireBaseUser = dogOwnersCollection.data();
    for (final entry in currentFireBaseUser!.entries) {
      
      dataMap.addAll({entry.key: entry.value});
    } */

    // add more data to userData, such as adress input etc.

    dataMap.addAll({"stripe account id": stripeAccountId});
    print(dataMap);

    _firestore
        .collection('dog walkers')
        .doc(currentUser.phoneNumber)
        .set(dataMap);
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
