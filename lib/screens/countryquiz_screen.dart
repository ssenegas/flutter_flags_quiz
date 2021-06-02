import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_flags_quiz_app/models/countryquizgenerator.dart';

class CountryQuizWidget extends StatefulWidget {
  @override
  _CountryQuizState createState() => _CountryQuizState();
}

class _CountryQuizState extends State<CountryQuizWidget> {

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Flag Quiz')),
      body: _buildQuiz(context),
    );
  }

  Widget _buildQuiz(BuildContext context) {
    return FutureBuilder<CountryQuizGenerator>(
        future: CountryQuizGenerator.getInstance(),
        builder: (BuildContext context, AsyncSnapshot<CountryQuizGenerator> snapshot) {
          if (snapshot.hasData) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: _getNewQuiz(snapshot.data),
              ),
            );
          } else if (snapshot.hasError) {
            return Column(
                children: <Widget>[
                  const Icon(
                    Icons.error_outline,
                    color: Colors.red,
                    size: 60,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 16),
                    child: Text('Error: ${snapshot.error}'),
                  )
                ]);
          }
        });
  }

  List<Widget> _getNewQuiz(CountryQuizGenerator quiz) {
    quiz.generate();

    List<Widget> buttons = [];
    for (var i = 0; i < quiz.quizItems.length; i++) {
      buttons.add(ButtonTheme(
        height: 20.0,
          child: ElevatedButton(
            child: new Text(quiz.quizItems[i].name),
            onPressed: () {
              checkAnswer(quiz.quizItems[i].name, quiz);
            },
          ),
      )
      );
    }

    List<Widget> widgets = [];
    widgets.add(
        Container(
        child: Image.asset('assets/flags/128x128/${quiz.correctAnswer.alpha2}.png',
          scale: 0.8,),
        ));
    widgets.add(
        GridView.count(
            padding: const EdgeInsets.all(20),
            physics: const NeverScrollableScrollPhysics(),
            mainAxisSpacing: 20.0,
            crossAxisSpacing: 20.0,
            childAspectRatio: 4,
            shrinkWrap: true,
            crossAxisCount: 2,
            primary: true,
            children: buttons)
    );
    return widgets;
  }

  void checkAnswer(String answer, CountryQuizGenerator quiz) {
    if (answer == quiz.correctAnswer.name) {
      print("Correct");
    } else {
      print("Incorrect");
    }
  }
}