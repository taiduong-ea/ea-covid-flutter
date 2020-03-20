import 'country.dart';

class SummaryModel {
  List<Country> _countries = [];
  String _date = "";

  List<Country> get countries => _countries;
  String get date => _date;

  SummaryModel(this._countries, this._date);
  SummaryModel.empty();

  factory SummaryModel.fromJson(List<dynamic> json) {
    List<Country> countries = json.map((i) => Country.fromJson(i)).toList();
    countries.sort((b, a) =>
        a.totalConfirmed.compareTo(b.totalConfirmed)
    );
    var dateStr =  "";
    return new SummaryModel(countries, dateStr);
  }
}
