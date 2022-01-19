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

class HelperInfo extends StatelessWidget {
  final List<String> servicesList;
  HelperInfo(this.servicesList);
  List<Map<String, dynamic>> dataList = [];
  getUserDataMap(Map<String, dynamic> map) {
    dataList.add(map);
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
      'individual[first_name]': 'Victor',
      'individual[last_name]': 'Kennedy',
      'individual[dob][day]': '20',
      'individual[dob][month]': '10',
      'individual[dob][year]': '2003',
      'business_profile[mcc]': '7299',
      'individual[address][city]': 'Stockholm',
      'individual[address][line1]': 'Brahegatan 3',
      'individual[address][postal_code]': '11437',
      'individual[email]': 'vict.kenn-2022@vrg.se',
      'individual[phone]': '+46737776368',
      'tos_acceptance[date]':
          (DateTime.now().millisecondsSinceEpoch / 1000).toInt().toString(),
      'tos_acceptance[ip]': ip,
      'individual[verification][additional_document][front]':
          'https://firebasestorage.googleapis.com/v0/b/woof-ad9a6.appspot.com/o/uploads%2Fimage_picker_6E68A1D8-920F-4AFD-9220-39B81B4DBDBE-812-000006D457BE3ADE.jpg',
      'individual[verification][additional_document][back]':
          'https://firebasestorage.googleapis.com/v0/b/woof-ad9a6.appspot.com/o/uploads%2Fimage_picker_0E07F634-D055-42FE-BC83-42214425153A-812-000006D466A8B3F1.jpg'
    };
    var data = await http.post(Uri.parse(url), headers: headers, body: body);
    print(data.body);
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
