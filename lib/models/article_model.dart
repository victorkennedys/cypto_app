import 'dart:convert';

import 'package:http/http.dart';

import '';

class Article {
  String title;
  String description;
  String url;

  String publishedAt;
  String content;

  Article(
      this.title, this.description, this.url, this.publishedAt, this.content);

  static getNewsArticles(String url) async {
    var response = await get(Uri.parse(url));
    if (response.statusCode == 200) {
      Map<String, dynamic> json = jsonDecode(response.body);
      List<dynamic> body = json['articles'];
      for (int i = 0; i < body.length; i++) {
        Map<String, dynamic> map = body[i];
        articleList.add(Article.fromJson(map));
      }
      return articleList;
    }
  }

  factory Article.fromJson(Map<String, dynamic> json) {
    return Article(
      json['title'] as String,
      json['description'] as String,
      json['url'] as String,
      json['publishedAt'] as String,
      json['content'] as String,
    );
  }
}

List<Article> articleList = [];
