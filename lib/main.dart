import 'package:flutter/material.dart';
import 'package:hacker_news_app/pages/main_page.dart';
import 'package:hacker_news_app/pages/main_page_controller.dart';
import 'package:hacker_news_app/util/color_helper.dart';

void main() {
  MainPageController mainPageController = MainPageController();
  runApp(MyApp(
    mainPageController: mainPageController,
  ));
}

class MyApp extends StatelessWidget {
  final MainPageController mainPageController;

  const MyApp({Key? key, required this.mainPageController}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Hacker news',
      theme: ThemeData(
        primarySwatch: ColorHelper.getMaterialColor(const Color(0xff1d2939)),
      ),
      home: MainPage(
        mainPageController,
      ),
    );
  }
}
