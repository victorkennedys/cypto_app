import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:woof/components/black_and_pink_text.dart';
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
  final TextEditingController _authController = TextEditingController();
  String verificationCode = '';

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  pinEntered(value) async {
    String phoneWithCountryCode = '+46${widget.phone}';
    var dogOwners = FirebaseFirestore.instance.collection('dog owners');

    bool newUser = true;

    String userDocId = '';

    await dogOwners
        .where('phone', isEqualTo: phoneWithCountryCode)
        .get()
        .then((QuerySnapshot querySnapshot) {
      if (querySnapshot.docs.length == 0) {
        newUser = true;
      } else {
        newUser = false;
      }
    });

    try {
      await FirebaseAuth.instance
          .signInWithCredential(PhoneAuthProvider.credential(
              verificationId: verificationCode, smsCode: _authController.text))
          .then((response) async {
        if (response.user != null) {
          if (newUser == true) {
            dogOwners
                .doc(phoneWithCountryCode)
                .set({'phone': phoneWithCountryCode});
            userDocId = phoneWithCountryCode;

            LocationPermission permission;
            permission = await Geolocator.requestPermission();

            Navigator.of(context).pushNamedAndRemoveUntil(
                UserEnterInfoScreen.id, (Route<dynamic> route) => false);
          }
          if (newUser == false) {
            Navigator.of(context).pushNamedAndRemoveUntil(
                Home.id, (Route<dynamic> route) => false);
          }
        }
      });
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
                    controller: _authController,
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
