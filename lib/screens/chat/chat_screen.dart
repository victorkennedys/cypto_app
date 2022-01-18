import 'package:flutter/material.dart';
import 'package:woof/components/advert/user_adverts_stream.dart';
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
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            /* BlackPinkText(blackText: "Ansökningar och", pinkText: "chatter"), */
          ],
        ),
      ),
      bottomNavigationBar: NavBar(3),
    );
  }
}
