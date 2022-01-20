import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:woof/components/black_and_pink_text.dart';
import 'package:woof/models/authentication_model.dart';
import 'package:woof/screens/helper%20screens/helper_home.dart';
import 'package:woof/screens/onboarding/user_info.dart';
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

  pinEntered(value) async {
    String phoneWithCountryCode = '+46${widget.phone}';
    bool newDogOwner =
        await AuthenticationModel().dogOwnerExists(phoneWithCountryCode);
    bool newDogHelper =
        await AuthenticationModel().dogWalkerExists(phoneWithCountryCode);

    try {
      await AuthenticationModel().authenticateNumber(
          verificationCode: verificationCode,
          inputCode: value,
          newUser: newDogOwner,
          newWalker: newDogHelper,
          phone: phoneWithCountryCode);

      await Geolocator.requestPermission();

      if (newDogOwner && newDogHelper) {
        Navigator.of(context).pushNamedAndRemoveUntil(
            UserEnterInfoScreen.id, (Route<dynamic> route) => false);
      }
      if (newDogOwner == false) {
        Navigator.of(context)
            .pushNamedAndRemoveUntil(Home.id, (Route<dynamic> route) => false);
      }
      if (newDogHelper == false) {
        Navigator.of(context).pushNamedAndRemoveUntil(
            WalkerHomeScreen.id, (Route<dynamic> route) => false);
      }
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

  _verifyPhone() async {
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
    _verifyPhone();
  }
}
