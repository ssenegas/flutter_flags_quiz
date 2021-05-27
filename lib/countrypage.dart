import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:async' show Future;
import 'package:flutter/services.dart' show rootBundle;
import 'dart:convert';
import 'package:flutter/services.dart';

import 'country.dart';

class CountryPage extends StatefulWidget {
  @override
  CountryPageState createState() => new CountryPageState();
}

class CountryPageState extends State<CountryPage> {

  List<Country> countries;

  Future<String> loadJsonCountries() async {
    var jsonText = await rootBundle.loadString('assets/data/en/countries.json');
    var countryObjsJson = jsonDecode(jsonText) as List;
    setState(() => countries = countryObjsJson.map((tagJson) => Country.fromJson(tagJson)).toList());
    return 'Success!';
  }

  @override
  void initState(){
    this.loadJsonCountries();
  }

  @override
  Widget build(BuildContext context) {
    this.loadJsonCountries();
    return Scaffold(
        appBar: AppBar(title: Text('Countries'),),
        body: ListView.builder(
            itemCount: countries == null ? 0 : countries.length,
            itemBuilder: (BuildContext context, int index) {
              return Card(
                  child: Padding(
                    padding: EdgeInsets.symmetric(vertical: 2.0),
                    child: new Row(
                        children: <Widget>[
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 5.0),
                            child: Image(
                              fit: BoxFit.fitHeight,
                              alignment: Alignment.centerLeft,
                              image: AssetImage('assets/flags/64x64/${countries[index].alpha2}.png'),
                            ),
                          ),
                          new SizedBox(
                            width: 5.0,
                          ),
                          Container(
                              padding: EdgeInsets.symmetric(vertical: 0.5, horizontal: 1.0),
                              margin: EdgeInsets.all(2.0),
                              child: Text(countries[index].name,
                                style: TextStyle(
                                    fontSize: 16.0,
                                    fontWeight: FontWeight.w600
                                ),
                              )
                          )
                        ]),
                  ));
            }
        ));
  }
}
