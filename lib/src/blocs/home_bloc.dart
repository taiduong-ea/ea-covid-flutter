import 'package:eacovidflutter/src/models/country.dart';
import 'package:eacovidflutter/src/resources/repository.dart';
import 'package:rxdart/rxdart.dart';
import 'package:tuple/tuple.dart';

class HomeBloc {
  final _repository = Repository();
  final _countriesFetcher = PublishSubject<Tuple2<List<Country>, String>>();

  Observable<Tuple2<List<Country>, String>> get countries => _countriesFetcher.stream;

  fetchCountries(int offset) async {
    Tuple2<List<Country>, String> countries = await _repository.fetchCountries(offset);
    _countriesFetcher.sink.add(countries);
  }

  dispose() {
    _countriesFetcher.close();
  }
}

final homeBloc = HomeBloc();
