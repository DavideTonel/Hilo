import 'package:flutter/material.dart';
import 'package:roadsyouwalked_app/pages/HomeFeedPage.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'RoadsYouWalked',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: HomeFeedpage(),
    );
  }
}
