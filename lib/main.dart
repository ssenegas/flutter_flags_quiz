import 'package:flutter/material.dart';

import 'model/countryquizgenerator.dart';
import 'screen/countrylist.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Flags Quiz',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: HomeScreen(),
    );
  }
}

class HomeScreen extends StatelessWidget {

  CountryQuizGenerator quiz = new CountryQuizGenerator();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Flutter Flags Quiz'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
              child: Image.asset(
                'assets/home.png',
                fit: BoxFit.cover,
              ),
            ),
            // A button that navigates to a named route.
            // The named route extracts the arguments
            // by itself.
            ElevatedButton (
                child: Text("Start Quiz"),
                onPressed: () {
                  enterQuiz(context);
                }),
            ElevatedButton (
                child: Text("Countries"),
                onPressed: () {
                  enterCountries(context);
                }),
          ],
        ),
      ),
    );
  }

  void enterQuiz(BuildContext context) {
    quiz.generate();
  }

  void enterCountries(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => CountryList()),
    );
  }
}
