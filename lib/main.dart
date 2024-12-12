import 'package:flutter/material.dart';
import 'package:water_intake_app/screens/homepage.dart';
import 'package:water_intake_app/widget/custome_text_widgets.dart';




void main() => runApp(
      const MyApp(),
    );

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return  MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
        toolbarHeight: 100,
        elevation: 2,
        backgroundColor: Colors.blueGrey,
        title: const CustomTextWidget(
          text: 'Water Intake App',
          clr: Colors.black,
          fs: 20,
          fw: FontWeight.bold,
          ls: 1,
        ),
        centerTitle: true,
      ),
      body: const Homepage(),
      ),
    );
  }
}
