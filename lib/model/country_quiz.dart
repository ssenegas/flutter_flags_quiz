import 'country.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'dart:convert';
import 'dart:math';
import 'package:flutter/services.dart';

class CountryQuiz {
  final _maxItems = 4;
  List<Country> _countries;
  List<Country> quizItems = [];
  Country correctAnswer;

  CountryQuiz() {
    this.loadJsonCountries();
  }

  void loadJsonCountries() async {
    var jsonText = await rootBundle.loadString('assets/data/en/countries.json');
    var countryObjsJson = jsonDecode(jsonText) as List;
    _countries = countryObjsJson.map((tagJson) => Country.fromJson(tagJson)).toList();
  }

  void resetQuiz() {
    _countries.shuffle();
    var random = new Random();
    if (quizItems.isNotEmpty) {
      quizItems.clear();
    }

    var randomIndex;
    for(var i = 0; i < _maxItems; i++) {
      randomIndex = random.nextInt(_countries.length);
      quizItems.add(_countries[randomIndex]);
    }
    randomIndex = random.nextInt(quizItems.length);
    correctAnswer = quizItems[randomIndex];

    quizItems.forEach(print);
    print('The correct answer is $correctAnswer.toString().');
  }
}
