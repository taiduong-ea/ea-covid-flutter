import 'dart:core';

class Country {
  String _name;
  int _newConfirmed;
  int _totalConfirmed;
  int _newDeaths;
  int _totalDeaths;
  int _newRecovered;
  int _totalRecovered;

  String get name => _name;
  int get newConfirmed => _newConfirmed;
  int get totalConfirmed => _totalConfirmed;
  int get newDeaths => _newDeaths;
  int get totalDeaths => _totalDeaths;
  int get newRecovered => _newRecovered;
  int get totalRecovered => _totalRecovered;

  Country(this._name, this._newConfirmed, this._totalConfirmed, this._newDeaths,
      this._totalDeaths, this._newRecovered, this._totalRecovered);

  Country.fromJson(Map<String, dynamic> json)
      : _name = json['Country'],
        _newConfirmed = json['NewConfirmed'],
        _totalConfirmed = json["TotalConfirmed"],
        _newDeaths = json["NewDeaths"],
        _totalDeaths = json["TotalDeaths"],
        _newRecovered = json["NewRecovered"],
        _totalRecovered = json["TotalRecovered"];
}
