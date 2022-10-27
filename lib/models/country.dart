class Country {
  final String continentCode;
  final int id;
  final String name;
  final String alpha2;
  final String alpha3;

  const Country(
      {required this.continentCode,
      required this.id,
      required this.name,
      required this.alpha2,
      required this.alpha3});

  factory Country.fromJson(Map<String, dynamic> json) {
    return Country(
        continentCode: json['cc'] as String,
        id: json['id'] as int,
        name: json['name'] as String,
        alpha2: json['alpha2'] as String,
        alpha3: json['alpha3'] as String);
  }

  @override
  String toString() {
    return '{ $continentCode, $id, $name, $alpha2, $alpha3 }';
  }
}
