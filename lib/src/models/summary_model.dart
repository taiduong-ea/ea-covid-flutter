import 'package:intl/intl.dart';
import 'country.dart';

class SummaryModel {
  List<Country> _countries = [];
  String _date = "";

  List<Country> get countries => _countries;
  String get date => _date;

  SummaryModel(this._countries, this._date);
  SummaryModel.empty();

  factory SummaryModel.fromJson(Map<String, dynamic> json) {
    var list = json['Countries'] as List;
    List<Country> countries = list.map((i) => Country.fromJson(i)).toList();
    countries.sort((b, a) =>
        a.totalConfirmed.compareTo(b.totalConfirmed)
    );
    var dateStr = json['Date'];
    DateTime dateTime = DateFormat("yyyy-MM-dd'T'HH:mm:ssZ").parse(dateStr);
    dateStr = DateFormat('yyyy-MM-dd HH:mm:ss').format(dateTime);
    return new SummaryModel(countries, dateStr);
  }
}
