import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:woof/components/app_button.dart';
import 'package:woof/constants.dart';
import 'package:woof/screens/home_screen.dart';
import 'package:woof/screens/onboarding/otp.dart';
import '../../components/black_and_pink_text.dart';

class LoginScreen extends StatefulWidget {
  static const String id = 'login_screen';

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _auth = FirebaseAuth.instance;

  bool _isChecked = false;

  TextEditingController _phoneController = TextEditingController();

  TextEditingController _passwordController = TextEditingController();

  loginWithEmailAndPassword() async {
    String email = _phoneController.text;

    String passWord = _passwordController.text;
    try {
      if (email != null && passWord != null) {
        final user = await _auth.signInWithEmailAndPassword(
            email: email, password: passWord);
        if (user != null) {
          Navigator.pushNamed(context, Home.id);
        }
      }
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0.0,
      ),
      backgroundColor: kBgColor,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.only(
            top: MediaQuery.of(context).size.height / 40,
            left: MediaQuery.of(context).size.width / 12,
            right: MediaQuery.of(context).size.width / 12,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              BlackPinkText(
                blackText: "Logga in på",
                pinkText: "Woof",
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height / 10,
              ),
              TextField(
                textInputAction: TextInputAction.go,
                decoration: kInputDecoration.copyWith(
                    hintText: "Ange ditt nummer",
                    prefix: Padding(
                      padding: EdgeInsets.only(right: 4),
                      child: Text("+46"),
                    )),
                controller: _phoneController,
                maxLength: 10,
                keyboardType: TextInputType.number,
              ),
              /* SizedBox(
                height: MediaQuery.of(context).size.height / 40,
              ),
              TextField(
                decoration:
                    kInputDecoration.copyWith(hintText: "Ange lösenord"),
                obscureText: true,
                controller: _passwordController,
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height / 40,
              ),
              /* Row(
                children: [
                  Container(
                    child: Checkbox(
                      activeColor: Colors.white,
                      value: _isChecked,
                      onChanged: (value) {
                        
                      },
                      autofocus: true,
                      checkColor: kPinkColor,
                    ),
                  ),
                  Text("Kom ihåg mig"),
                ],
              ), */ */
              SizedBox(
                height: MediaQuery.of(context).size.height / 40,
              ),
              AppButton(
                buttonColor: kPurpleColor,
                textColor: kPinkColor,
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          OTPScreen(phone: _phoneController.text),
                    ),
                  );
                },
                buttonText: "Logga in",
              )
            ],
          ),
        ),
      ),
    );
  }
}
