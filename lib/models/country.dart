import 'dart:core';

class Country {
  final String name;
  final int newConfirmed;
  final int totalConfirmed;
  final int newDeaths;
  final int totalDeaths;
  final int newRecovered;
  final int totalRecovered;

  Country(this.name, this.newConfirmed, this.totalConfirmed, this.newDeaths,
      this.totalDeaths, this.newRecovered, this.totalRecovered);

  Country.fromJson(Map<String, dynamic> json)
      : name = json['Country'],
        newConfirmed = json['NewConfirmed'],
        totalConfirmed = json["TotalConfirmed"],
        newDeaths = json["NewDeaths"],
        totalDeaths = json["TotalDeaths"],
        newRecovered = json["NewRecovered"],
        totalRecovered = json["TotalRecovered"];
}
