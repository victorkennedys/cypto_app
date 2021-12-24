import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart';

class NewsCard extends StatelessWidget {
  final String name;

  NewsCard(this.name);
  @override
  static const String newsKey = "5a8b2b1a798b4b94a1d46f0a5689f36c";

  List<Map> content = [];
  getNewsData() async {
    var response = await get(Uri.parse(
        "https://newsapi.org/v2/everything?q=$name&from=2021-12-24&sortBy=popularity&apiKey=$newsKey"));
    if (response.statusCode == 200) {
      List values;
      values = jsonDecode(response.body)["articles"];

      for (int i = 0; i < 5; i++) {
        Map<String, dynamic> map = values[i];
        print(map);
      }
    } else {
      print("error");
    }
  }

  Widget build(BuildContext context) {
    return DraggableScrollableSheet(
      initialChildSize: 0.22,
      minChildSize: 0.22,
      builder: (context, controller) => Container(
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(25),
              topRight: Radius.circular(25),
            )),
        child: ListView(
          controller: controller,
          children: [
            FlatButton(
                onPressed: () {
                  getNewsData();
                },
                child: Text(
                  "Get data",
                  style: TextStyle(color: Colors.black),
                ))
          ],
        ),
      ),
    );
  }
}
