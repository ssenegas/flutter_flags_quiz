import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_flags_quiz/models/country.dart';

import '../models/countryquizgenerator.dart';

class CountryQuizWidget extends StatefulWidget {
  final List<Country> countries;
  late final CountryQuizGenerator cqg;

  CountryQuizWidget({Key? key, required this.countries}) : super(key: key) {
    cqg = CountryQuizGenerator(countries);
  }

  @override
  State<StatefulWidget> createState() => _CountryQuizState();
}

class _CountryQuizState extends State<CountryQuizWidget> {
  late int score;

  @override
  void initState() {
    super.initState();
    score = 0;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Flag Quiz')),
      body: _buildQuiz(context),
    );
  }

  Widget _buildQuiz(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: _getNewQuiz(widget.cqg),
      ),
    );
  }

  List<Widget> _getNewQuiz(CountryQuizGenerator quiz) {
    quiz.setupQuizRound();

    List<Widget> buttons = [];
    for (var i = 0; i < quiz.quizItems.length; i++) {
      buttons.add(ButtonTheme(
        height: 20.0,
        child: ElevatedButton(
          child: Text(quiz.quizItems[i].name),
          onPressed: () {
            checkAnswer(quiz.quizItems[i].name, quiz);
          },
        ),
      ));
    }

    List<Widget> widgets = [];

    widgets.add(Text(
      'Score: $score',
      style: TextStyle(
        fontSize: 40,
        color: Colors.blue[300],
      ),
    ));

    widgets.add(Image.asset(
      'assets/flags/128x128/${quiz.correctAnswer.alpha2}.png',
      scale: 0.5,
    ));

    widgets.add(GridView.count(
        padding: const EdgeInsets.all(20),
        physics: const NeverScrollableScrollPhysics(),
        mainAxisSpacing: 20.0,
        crossAxisSpacing: 20.0,
        childAspectRatio: 4,
        shrinkWrap: true,
        crossAxisCount: 2,
        primary: true,
        children: buttons));

    return widgets;
  }

  void checkAnswer(String answer, CountryQuizGenerator quiz) {
    String snackBarText;
    Color color;

    bool result = (answer == quiz.correctAnswer.name);
    if (result) {
      snackBarText = "True !!";
      color = Colors.green;
      print("True");
    } else {
      snackBarText = "False !!";
      color = Colors.red;
      print("False");
    }

    final snackBar = SnackBar(
      content: Text(snackBarText),
      backgroundColor: color,
      duration: const Duration(seconds: 1),
    );

    // Find the ScaffoldMessenger in the widget tree
    // and use it to show a SnackBar.
    ScaffoldMessenger.of(context).showSnackBar(snackBar);

    if (result) {
      setState(() {
        score++;
        print("Score: $score");
      });
    }
  }
}
