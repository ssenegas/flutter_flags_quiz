import 'package:flutter/material.dart';
import 'package:flutter_flags_quiz/screens/countrylist_screen.dart';
import 'package:flutter_flags_quiz/screens/countryquiz_screen.dart';

import 'Utils/assets_utils.dart';
import 'models/country.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

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
      home: const FlagQuiz(),
    );
  }
}

class FlagQuiz extends StatelessWidget {
  const FlagQuiz({Key? key}) : super(key: key);

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
      home: const HomeScreen(),
    );
  }
}

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Flutter Flag Quiz'),
      ),
      body: FutureBuilder<List<Country>>(
        future: AssetsUtils.loadJsonCountries(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return const Center(
              child: Text('An error has occurred!'),
            );
          } else if (snapshot.hasData) {
            return MenuWidget(countries: snapshot.data!);
          } else {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }
}

class MenuWidget extends StatelessWidget {
  const MenuWidget({super.key, required this.countries});

  final List<Country> countries;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Image.asset(
            'assets/home.png',
            fit: BoxFit.cover,
          ),
          // A button that navigates to a named route.
          // The named route extracts the arguments
          // by itself.
          ElevatedButton(
              child: const Text("Start Quiz"),
              onPressed: () {
                enterQuiz(context);
              }),
          ElevatedButton(
              child: const Text("Countries"),
              onPressed: () {
                enterCountries(context);
              }),
        ],
      ),
    );
  }

  void enterQuiz(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) => CountryQuizWidget(countries: countries)),
    );
  }

  void enterCountries(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) => CountryListWidget(countries: countries)),
    );
  }
}
