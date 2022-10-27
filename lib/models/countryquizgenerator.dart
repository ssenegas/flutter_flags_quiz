import 'dart:math';

import 'package:flutter/cupertino.dart';

import 'country.dart';

class CountryQuizGenerator extends ChangeNotifier {
  final int _quizNumber = 0;
  int get quizNumber => _quizNumber;

  final _maxItems = 4;
  int get maxItems => _maxItems;

  final List<Country> _countries;
  List<Country> get countries => _countries;

  List<Country> quizItems = [];
  late Country correctAnswer;

  CountryQuizGenerator(this._countries);

  void setupQuizRound() {
    _countries.shuffle();
    var random = Random();
    quizItems.clear();

    for (var i = 0; i < _maxItems; i++) {
      quizItems.add(_countries[random.nextInt(_countries
          .length)]); // TODO check if one of the item is the same country
    }
    correctAnswer = quizItems[random.nextInt(quizItems.length)];
    print(toString());

    notifyListeners();
  }

  void checkAnswer(String answer) {
    bool result = (answer == correctAnswer.name);
    if (result) {}
  }

  @override
  String toString() {
    return '$quizItems\nAnswer: $correctAnswer.';
  }
}
