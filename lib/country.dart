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
//
//{
//"Country": "Saudi Arabia",
//"NewConfirmed": 53,
//"TotalConfirmed": 171,
//"NewDeaths": 0,
//"TotalDeaths": 0,
//"NewRecovered": 4,
//"TotalRecovered": 6
//},
