class Country {
  String continentCode;
  int id;
  String name;
  String alpha2;
  String alpha3;

  Country(this.continentCode, this.id, this.name, this.alpha2, this.alpha3);

  factory Country.fromJson(dynamic json) {
    return Country(json['cc'] as String, json['id'] as int, json['name'] as String, json['alpha2'] as String, json['alpha3'] as String);
  }

  @override
  String toString() {
    return '{ ${this.continentCode}, ${this.id}, ${this.name}, ${this.alpha2}, ${this.alpha3} }';
  }
}