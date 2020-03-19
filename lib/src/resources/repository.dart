import 'package:eacovidflutter/src/models/country.dart';
import 'package:eacovidflutter/src/models/summary_model.dart';
import 'package:eacovidflutter/src/resources/covid_api_provider.dart';
import 'package:tuple/tuple.dart';

class Repository {
  final covidApiProvider = CovidApiProvider();

  Future<SummaryModel> getSummary() => covidApiProvider.getSummary();
  Future<Tuple2<List<Country>, String>> fetchCountries(int offset) => covidApiProvider.fetchCountries(offset);
}
