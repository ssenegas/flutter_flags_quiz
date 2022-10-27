import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

import '../models/country.dart';

class AssetsUtils {
  static Future<List<Country>> loadJsonCountries() async {
    final jsonText =
        await rootBundle.loadString('assets/data/en/countries.json');
    return compute(_parseCountries, jsonText);
  }

  static List<Country> _parseCountries(String data) {
    final parsed = jsonDecode(data).cast<Map<String, dynamic>>();
    return parsed.map<Country>((json) => Country.fromJson(json)).toList();
  }
}
