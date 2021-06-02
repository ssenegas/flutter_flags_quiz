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

  static Future<CountryQuizGenerator> getInstance() async {
    var countries = await getCountries();
    return new CountryQuizGenerator(countries);
  }

  static Future<String> getJson() {
    return rootBundle.loadString('assets/data/en/countries.json');
  }

  static Future<List<Country>> getCountries() async {
    var countryObjectsJson = jsonDecode(await getJson()) as List;
    return countryObjectsJson.map((json) => Country.fromJson(json)).toList();
  }

  CountryQuizGenerator(this._countries);

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
