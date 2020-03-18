import 'package:intl/intl.dart';
import 'country.dart';

class Summary {
  List<Country> countries = [];
  String date = "";

  Summary(this.countries, this.date);
  Summary.empty();

  factory Summary.fromJson(Map<String, dynamic> json) {
    var list = json['Countries'] as List;
    List<Country> countries = list.map((i) => Country.fromJson(i)).toList();
    countries.sort((b, a) =>
        a.totalConfirmed.compareTo(b.totalConfirmed)
    );
    var dateStr = json['Date'];
    DateTime dateTime = DateFormat("yyyy-MM-dd'T'HH:mm:ssZ").parse(dateStr);
    dateStr = DateFormat('yyyy-MM-dd HH:mm:ss').format(dateTime);
    return new Summary(countries, dateStr);
  }
}
