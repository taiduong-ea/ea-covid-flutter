import 'package:eacovidflutter/src/blocs/home_bloc.dart';
import 'package:eacovidflutter/src/models/country.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:tuple/tuple.dart';

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  TextEditingController _searchQueryController = TextEditingController();
  RefreshController _refreshController =
      RefreshController(initialRefresh: false);

  bool _isSearching = false;
  String _searchQuery = "Search query";
  String _lastPull = "";
  String _lastUpdated = "";
  List<Country> _countries = [];
  int _countryOffset = 0;

  @override
  void initState() {
    super.initState();
    homeBloc.fetchCountries(_countryOffset);
  }

  @override
  dispose() {
    homeBloc.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        leading: _isSearching ? const BackButton() : Container(),
        title: _isSearching ? _buildSearchField() : _buildTitle(context),
        elevation: 0.0,
        actions: _buildActions(),
      ),
      body: StreamBuilder(
        stream: homeBloc.countries,
        builder: (context, AsyncSnapshot<Tuple2<List<Country>, String>> snapshot) {
          if (snapshot.hasData) {
            return _buildPage(snapshot);
          } else if (snapshot.hasError) {
            return Text(snapshot.error.toString());
          }
          return Center(child: CircularProgressIndicator());
        },
      ),
    );
  }

  void _updateData(List<Country> countries, String lastUpdated) {
    this._countries.addAll(countries);
    _countryOffset += countries.length;
    this._lastUpdated = lastUpdated;
    _updateLastPull();
  }

  Widget _buildPage(AsyncSnapshot<Tuple2<List<Country>, String>> snapshot) {
    _updateData(snapshot.data.item1, snapshot.data.item2);
    return  Column(
      children: <Widget>[
        _buildLastUpdatedHeader(),
        _buildListViewHeader(),
        Expanded(
          child: Scrollbar(
            child: SmartRefresher(
              controller: _refreshController,
              onRefresh: _onRefresh,
              onLoading: _onLoading,
              enablePullDown: true,
              enablePullUp: true,
              header: WaterDropHeader(),
              footer: _buildCustomFooter(),
              child: _buildListView(),
            ),
          )
        ),
      ]
    );
  }

  Widget _buildSearchField() {
    return TextField(
      controller: _searchQueryController,
      autofocus: true,
      decoration: InputDecoration(
        hintText: "Search Data...",
        border: InputBorder.none,
        hintStyle: TextStyle(color: Colors.white30),
      ),
      style: TextStyle(color: Colors.white, fontSize: 16.0),
      onChanged: (query) => updateSearchQuery,
    );
  }

  Widget _buildLastUpdatedHeader() {
    return Column(
      children: <Widget>[
        Container(
          width: double.infinity,
          color: Colors.lightBlue,
          padding: const EdgeInsets.fromLTRB(8, 5, 8, 5),
          child: Text(
            "Data queried at: $_lastPull",
            style: TextStyle(
              color: Colors.white,
            ),
            textAlign: TextAlign.left,
          ),
        ),
      ],
    );
  }

  Widget _buildListViewHeader() {
    return Container(
      color: Colors.lightBlueAccent,
      padding: const EdgeInsets.all(10),
      child: Row(
        children: [
          Expanded(
            child: Text(
              'Country',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.white,
              ),
            ),
          ),
          Expanded(
            child: Text(
              'Total Cases',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.white,
              ),
            ),
          ),
          Expanded(
            child: Text(
              'New Cases',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.white,
              ),
            ),
          ),
          Expanded(
            child: Text(
              'Total Deaths',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.white,
              ),
            ),
          ),
          Expanded(
            child: Text(
              'New Deaths',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.white,
              ),
            ),
          ),
          Expanded(
            child: Text(
              'Total Recovered',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildListView() {
    return ListView.separated(
      itemBuilder: (context, index) => _buildListViewItem(_countries[index]),
      separatorBuilder: (context, index) => Divider(
        height: 2,
        color: Colors.white,
      ),
      itemCount: _countries.length,
    );
  }

  Widget _buildListViewItem(Country country) {
    final formatter = new NumberFormat("#,###");
    return Padding(
      padding: EdgeInsets.all(0),
      child: Container(
        color: Colors.white,
        padding: const EdgeInsets.all(10),
        child: Row(
          children: [
            Expanded(
              child: Text(
                country.name,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.black,
                ),
              ),
            ),
            Expanded(
              child: Text(
                formatter.format(country.totalConfirmed),
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.black,
                ),
              ),
            ),
            Expanded(
              child: Text(
                '+${formatter.format(country.newConfirmed)}',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.black,
                ),
              ),
            ),
            Expanded(
              child: Text(
                '${formatter.format(country.totalDeaths)}',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.red,
                ),
              ),
            ),
            Expanded(
              child: Text(
                '+${formatter.format(country.newDeaths)}',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.red,
                ),
              ),
            ),
            Expanded(
              child: Text(
                '${formatter.format(country.totalRecovered)}',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.black,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCustomFooter() {
    return CustomFooter(
      builder: (BuildContext context, LoadStatus mode) {
        Widget body;
        if (mode == LoadStatus.loading) {
          body = CupertinoActivityIndicator();
        } else if (mode == LoadStatus.failed) {
          body = Text("Load Failed! Click retry!");
        } else if (mode == LoadStatus.canLoading) {
          body = Text("Release to load more");
        } else {
          body = Text("No more Data");
        }
        return Container(
          height: 55.0,
          child: Center(child: body),
        );
      },
    );
  }

  List<Widget> _buildActions() {
    if (_isSearching) {
      return <Widget>[
        IconButton(
          icon: const Icon(Icons.clear),
          onPressed: () {
            if (_searchQueryController == null ||
                _searchQueryController.text.isEmpty) {
              Navigator.pop(context);
              return;
            }
            _clearSearchQuery();
          },
        ),
      ];
    }

    return <Widget>[
      IconButton(
        icon: const Icon(Icons.search),
        onPressed: _startSearch,
      ),
    ];
  }

  void _startSearch() {
    ModalRoute.of(context)
        .addLocalHistoryEntry(LocalHistoryEntry(onRemove: _stopSearching));

    setState(() {
      _isSearching = true;
    });
  }

  void updateSearchQuery(String newQuery) {
    setState(() {
      _searchQuery = newQuery;
    });
  }

  void _stopSearching() {
    _clearSearchQuery();

    setState(() {
      _isSearching = false;
    });
  }

  void _clearSearchQuery() {
    setState(() {
      _searchQueryController.clear();
      updateSearchQuery("");
    });
  }

  Widget _buildTitle(BuildContext context) {
    return Text(widget.title);
  }

  void _onRefresh() async {
    _countryOffset = 0;
    _countries = [];
    await homeBloc.fetchCountries(_countryOffset);
    _refreshController.refreshCompleted();
  }

  void _onLoading() async {
    await homeBloc.fetchCountries(_countryOffset);
    _updateLastPull();
    _refreshController.loadComplete();
  }

  void _updateLastPull() {
    var now = DateTime.now();
    _lastPull = DateFormat("yyyy-MM-dd HH:mm:ss").format(now);
  }
}
