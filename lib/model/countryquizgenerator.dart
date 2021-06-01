import 'country.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'dart:convert';
import 'dart:math';
import 'package:flutter/services.dart';

class CountryQuizGenerator {
  final _maxItems = 4;
  List<Country> _countries;
  List<Country> quizItems = [];
  Country correctAnswer;

  CountryQuizGenerator() {
    this.loadJsonCountries();
  }

  Future<String> getJson() {
    return rootBundle.loadString('assets/data/en/countries.json');
  }

  void loadJsonCountries() async {
    var countryObjectsJson = jsonDecode(await getJson()) as List;
    _countries = countryObjectsJson.map((json) => Country.fromJson(json)).toList();
  }

  void generate() {
    _countries.shuffle();
    var random = new Random();
    if (quizItems.isNotEmpty) {
      quizItems.clear();
    }

    for(var i = 0; i < _maxItems; i++) {
      quizItems.add(_countries[random.nextInt(_countries.length)]);
    }
    correctAnswer = quizItems[random.nextInt(quizItems.length)];

    print(this.toString());
  }

  @override
  String toString() {
    return quizItems.toString() + '\nAnswer: $correctAnswer.';
  }
}
