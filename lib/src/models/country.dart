import 'dart:core';

class Country {
  String _name;
  int _newConfirmed;
  int _totalConfirmed;
  int _newDeaths;
  int _totalDeaths;
  int _totalRecovered;

  String get name => _name;
  int get newConfirmed => _newConfirmed;
  int get totalConfirmed => _totalConfirmed;
  int get newDeaths => _newDeaths;
  int get totalDeaths => _totalDeaths;
  int get totalRecovered => _totalRecovered;

  Country(this._name, this._newConfirmed, this._totalConfirmed, this._newDeaths,
      this._totalDeaths, this._totalRecovered);

  Country.fromJson(Map<String, dynamic> json)
      : _name = json['country'],
        _newConfirmed = json['todayCases'],
        _totalConfirmed = json["cases"],
        _newDeaths = json["todayDeaths"],
        _totalDeaths = json["deaths"],
        _totalRecovered = json["recovered"];
}

//"country": "China",
//"cases": 80967,
//"todayCases": 39,
//"deaths": 3248,
//"todayDeaths": 3,
//"recovered": 71150,
//"active": 6569,
//"critical": 2136,
//"casesPerOneMillion": 56
//},
