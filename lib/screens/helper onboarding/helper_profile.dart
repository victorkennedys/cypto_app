import 'package:flutter/material.dart';
import 'package:woof/components/input%20widgets/image_picker.dart';
import 'package:woof/constants.dart';
import 'package:woof/main.dart';

class CreateHelperProfileScreen extends StatelessWidget {
  List<String> urlList = [];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: Container(
              decoration: BoxDecoration(color: kPinkColor),
              child: Center(
                child: PickImage(MediaQuery.of(context).size.height * 0.2,
                    MediaQuery.of(context).size.height * 0.2, urlList),
              ),
            ),
          ),
          Expanded(
              flex: 2,
              child: Padding(
                padding: Woof.defaultPadding(context),
                child: Column(),
              ))
        ],
      ),
    );
  }
}
