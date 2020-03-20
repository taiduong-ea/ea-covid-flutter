import 'dart:async';
import 'dart:convert';
import 'package:eacovidflutter/src/models/country.dart';
import 'package:eacovidflutter/src/models/summary_model.dart';
import 'package:http/http.dart' show Client;
import 'package:tuple/tuple.dart';

class CovidApiProvider {
  String _baseUrl = "https://coronavirus-19-api.herokuapp.com";
  Client _client = Client();
  SummaryModel _summaryModel = SummaryModel.empty();

  Future<Tuple2<List<Country>, String>> fetchCountries(int offset) async {
    if (offset == 0) {
      _summaryModel = await getSummary();
    } else {
      await Future.delayed(Duration(milliseconds: 500));
    }
    return new Tuple2(_getCountries(offset), _summaryModel.date);
  }

  Future<SummaryModel> getSummary() async {
    final String url = _baseUrl + '/countries';
    final response = await _client.get(url);
    if (response.statusCode == 200) {
      var parsed = json.decode(response.body);
      return SummaryModel.fromJson(parsed);
    } else {
      throw Exception('Unable to fetch summary from the REST API');
    }
  }

  List<Country> _getCountries(int offset) {
    if (offset >= _summaryModel.countries.length) return [];
    var end = offset + 20 > _summaryModel.countries.length
        ? _summaryModel.countries.length
        : offset + 20;
    return _summaryModel.countries.getRange(offset, end).toList();
  }
}
