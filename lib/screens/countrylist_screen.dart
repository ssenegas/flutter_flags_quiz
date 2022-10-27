import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../models/country.dart';

class CountryListWidget extends StatelessWidget {
  const CountryListWidget({Key? key, required this.countries})
      : super(key: key);

  final List<Country> countries;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: const Text('Countries')),
        body: CountriesList(countries: countries));
  }
}

class CountriesList extends StatelessWidget {
  const CountriesList({super.key, required this.countries});

  final List<Country> countries;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    countries.sort((a, b) => a.name.compareTo(b.name));
    return ListView(
        children: ListTile.divideTiles(
            color: Colors.blue,
            tiles: countries.map((item) => ListTile(
                  leading: Image.asset('assets/flags/64x64/${item.alpha2}.png'),
                  title: Text(
                    item.name,
                    overflow: TextOverflow.ellipsis,
                    style: theme.textTheme.headline6,
                  ),
                  subtitle: Text(
                    item.toString(),
                    overflow: TextOverflow.ellipsis,
                    style: theme.textTheme.caption,
                  ),
                ))).toList());
  }
}
