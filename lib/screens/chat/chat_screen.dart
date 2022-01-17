import 'package:flutter/material.dart';
import 'package:woof/components/advert/home_my_adverts.dart';
import 'package:woof/components/black_and_pink_text.dart';
import 'package:woof/components/nav_bar.dart';
import 'package:woof/main.dart';

class ChatScreen extends StatelessWidget {
  static const String id = 'chat_screen';
  const ChatScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: Woof.defaultPadding(context),
        child: Column(
          children: [
            BlackPinkText(blackText: "Ansökningar och", pinkText: "chatter"),
            UserAdverts(),
          ],
        ),
      ),
      bottomNavigationBar: NavBar(3),
    );
  }
}
