import 'dart:convert';
import 'package:eacovidflutter/models/summary.dart';
import 'package:http/http.dart' as http;
import 'dart:core';

Future<Summary> getCountries() async {
  final String url = 'https://api.covid19api.com/summary';
  final response = await http.get(url);
  if (response.statusCode == 200) {
    var parsed = json.decode(response.body);
    return Summary.fromJson(parsed);
  } else {
    throw Exception('Unable to fetch summary from the REST API');
  }
}
