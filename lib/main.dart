import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:sprung/sprung.dart';
import 'package:woof/screens/adverts/dashboard.dart';
import 'package:woof/screens/chat/chat_screen.dart';
import 'package:woof/screens/dog/my_dogs.dart';
import 'package:woof/screens/home_screen.dart';
import 'package:woof/screens/onboarding/login_screen.dart';
import 'package:woof/screens/booking%20process/pick_dog_screen.dart';
import 'package:woof/screens/onboarding/otp.dart';
import 'package:woof/screens/onboarding/signup_screen.dart';
import 'package:woof/screens/onboarding/user_info.dart';
import 'package:woof/screens/profile_screen.dart';
import 'constants.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(Woof());
}

class Woof extends StatelessWidget {
  static defaultPadding(context) {
    return EdgeInsets.only(
      left: MediaQuery.of(context).size.width / 12,
      right: MediaQuery.of(context).size.width / 12,
      top: MediaQuery.of(context).size.height / 10,
    );
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: WelcomeScreen.id,
      routes: {
        WelcomeScreen.id: (context) => WelcomeScreen(),
        LoginScreen.id: (context) => LoginScreen(),
        RegistrationScreen.id: (context) => RegistrationScreen(),
        Home.id: (context) => Home(),
        MyDogs.id: (context) => MyDogs(),
        PickDogScreen.id: (context) => PickDogScreen(),
        AdvertsScreen.id: (context) => AdvertsScreen(),
        ProfileScreen.id: (context) => ProfileScreen(),
        UserEnterInfoScreen.id: (context) => UserEnterInfoScreen(),
        ChatScreen.id: (context) => ChatScreen(),
      },
    );
  }
}

class WelcomeScreen extends StatefulWidget {
  static const String id = 'welcome_screen';

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  TextEditingController phoneController = TextEditingController();
  bool expanded = false;

  onTap() {
    setState(() {
      expanded = true;
    });
  }

  onEditingComplete() {}

  onSubmitted(String value) {
    if (value.characters.length >= 9) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => OTPScreen(phone: phoneController.text),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      extendBodyBehindAppBar: true,
      backgroundColor: expanded ? kPinkColor : kBgColor,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Card(
            elevation: 8.0,
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20), topRight: Radius.circular(20)),
            ),
            child: AnimatedContainer(
              curve: Sprung.criticallyDamped,
              duration: Duration(milliseconds: 1500),
              width: MediaQuery.of(context).size.width,
              height: expanded
                  ? MediaQuery.of(context).size.height * 0.56
                  : MediaQuery.of(context).size.height * 0.2,
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text(
                          "Ange ditt",
                          style: kH1Text.copyWith(fontSize: 20),
                        ),
                        Text(
                          " telefonnummer",
                          style:
                              kH1Text.copyWith(fontSize: 20, color: kPinkColor),
                        )
                      ],
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    Expanded(
                      child: Container(
                        child: Column(
                          children: [
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Flexible(
                                  flex: 2,
                                  child: Row(
                                    children: [
                                      Container(
                                        width: 30,
                                        height: 20,
                                        child: Image.asset(
                                            "images/sweden-flag.png"),
                                      ),
                                      Padding(
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 10),
                                        child: Text(
                                          "+46",
                                          style: kH1Text.copyWith(fontSize: 15),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                PhoneInput(
                                    onTapCallback: onTap,
                                    onSubmittedCallback: onSubmitted,
                                    onEditingCompleteCallback:
                                        onEditingComplete,
                                    phoneController: phoneController),
                              ],
                            ),
                            /* phoneCompleted
                                ? OTPScreen(phone: phoneController.text)
                                : Container(), */
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class PhoneInput extends StatelessWidget {
  final Function onTapCallback;
  final Function onSubmittedCallback;
  final Function onEditingCompleteCallback;
  final TextEditingController phoneController;
  PhoneInput(
      {required this.onTapCallback,
      required this.onSubmittedCallback,
      required this.onEditingCompleteCallback,
      required this.phoneController});

  @override
  Widget build(BuildContext context) {
    return Flexible(
      flex: 5,
      child: TextField(
        textInputAction: TextInputAction.done,
        onTap: () => onTapCallback(),
        onEditingComplete: () => onEditingCompleteCallback(),
        onSubmitted: (value) => onSubmittedCallback(value),
        maxLength: 9,
        style: TextStyle(color: Colors.black),
        enabled: true,
        keyboardType:
            TextInputType.numberWithOptions(decimal: false, signed: true),
        decoration: kInputDecoration.copyWith(
          fillColor: Colors.white,
          filled: true,
          hintText: "## #### ## ##",
          border: UnderlineInputBorder(),
        ),
        controller: phoneController,
      ),
    );
  }
}


/* class FadeRoute extends PageRouteBuilder {
  final Widget page;
  FadeRoute({this.page})
      : super(
          pageBuilder: (
            BuildContext context,
            Animation<double> animation,
            Animation<double> secondaryAnimation,
          ) =>
              page,
          transitionsBuilder: (
            BuildContext context,
            Animation<double> animation,
            Animation<double> secondaryAnimation,
            Wi */