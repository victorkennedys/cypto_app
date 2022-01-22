import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:woof/components/black_and_pink_text.dart';
import 'package:woof/models/authentication_model.dart';
import 'package:woof/models/dog_owner_model.dart';
import 'package:woof/models/dog_walker_model.dart';
import 'package:woof/models/location.dart';
import 'package:woof/screens/onboarding/user_info.dart';
import 'package:woof/screens/walker%20screens/helper_home.dart';
import '../../constants.dart';
import '../home_screen.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

class OTPScreen extends StatefulWidget {
  final String phone;
  OTPScreen({required this.phone});
  @override
  _OTPScreenState createState() => _OTPScreenState();
}

class _OTPScreenState extends State<OTPScreen> {
  String verificationCode = '';

  Map<String, dynamic> userData = {};

  pinEntered(value) async {
    String phoneWithCountryCode = '+46${widget.phone}';

    try {
      await AuthenticationModel().authenticateNumber(
          verificationCode: verificationCode,
          inputCode: value,
          phone: phoneWithCountryCode);

      userAuthenticated(phoneWithCountryCode);
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.only(
            top: MediaQuery.of(context).size.height / 40,
            left: MediaQuery.of(context).size.width / 12,
            right: MediaQuery.of(context).size.width / 12,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              BlackPinkText(
                  blackText: "Ange din", pinkText: "verifikationskod"),
              SizedBox(
                height: 100,
              ),
              Column(
                children: [
                  SizedBox(
                    height: 20,
                  ),
                  PinCodeTextField(
                    appContext: context,
                    length: 6,
                    onChanged: (value) {},
                    onCompleted: (value) {
                      pinEntered(value);
                    },
                    autoDismissKeyboard: true,
                    pinTheme: PinTheme(
                        shape: PinCodeFieldShape.box,
                        borderRadius: BorderRadius.circular(5),
                        activeColor: kPinkColor,
                        selectedColor: kPinkColor,
                        inactiveColor: Colors.grey[400]),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  userAuthenticated(String phone) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool newDogOwner = await AuthenticationModel().dogOwnerExists(phone);
    bool newDogHelper = await AuthenticationModel().dogWalkerExists(phone);
    Map<String, dynamic>? userLocationData =
        await LocationModel().getLocation();

    double? longitude = userLocationData!['longitude'];
    double? latitude = userLocationData['latitude'];
    GeoPoint geoPoint = GeoPoint(latitude ?? 0, longitude ?? 0);

    Map<String, dynamic> userData = {
      'phone': phone,
      'location': geoPoint,
      'longitude': longitude ?? 0,
      'latitude': latitude ?? 0,
    };

    prefs.setString('phone', phone);

    if (newDogOwner && newDogHelper) {
      var dogOwners = FirebaseFirestore.instance.collection('dog owners');
      dogOwners.doc(phone).set(userData);

      Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(
            builder: (context) => UserEnterInfoScreen(),
          ),
          (route) => false);
    }
    if (newDogOwner == false) {
      DogOwnerModel().updateUserData(userData);
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(
          builder: (BuildContext context) => Home(),
        ),
        (route) => false,
      );
    }
    if (newDogHelper == false) {
      userData = await DogWalkerModel().getCurrentUser();
      DogWalkerModel().updateUserData(userData);
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(
          builder: (BuildContext context) => WalkerHomeScreen(userData),
        ),
        (route) => false,
      );
    }
  }

  _sendOTP() async {
    await FirebaseAuth.instance.verifyPhoneNumber(
      phoneNumber: '+46${widget.phone}',
      verificationCompleted: (phoneAuthCredential) async {
        await FirebaseAuth.instance
            .signInWithCredential(phoneAuthCredential)
            .then((value) async {
          if (value.user != null) {}
        });
      },
      verificationFailed: (error) {
        print(error.message);
      },
      codeSent: (String verificationId, int? forceResendingToken) {
        setState(() {
          verificationCode = verificationId;
        });
      },
      codeAutoRetrievalTimeout: (verificationId) {
        setState(() {
          verificationCode = verificationId;
        });
      },
      timeout: Duration(seconds: 60),
    );
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _sendOTP();
  }
}
