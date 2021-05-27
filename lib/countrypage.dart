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
  void initState() {
    super.initState();
    this.loadJsonCountries();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Countries')),
      body: _buildList(),
    );
  }

  Widget _buildList() {
    return ListView.separated(
      itemCount: countries == null ? 0 : countries.length,
      separatorBuilder: (context, index) => const Divider(),
      itemBuilder: _buildListItem,
    );
  }

  Widget _buildListItem(BuildContext context, int index) {
    final theme = Theme.of(context);
    return ListTile(
        leading: Image.asset('assets/flags/64x64/${countries[index].alpha2}.png'),
        title: Text(countries[index].name,
          overflow: TextOverflow.ellipsis,
          style: theme.textTheme.headline6,
        ),
        subtitle: Text(countries[index].toString(),
          overflow: TextOverflow.ellipsis,
          style: theme.textTheme.caption,
        ),
    );
  }
}
