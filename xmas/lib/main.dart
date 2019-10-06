import 'package:flare_flutter/flare_actor.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:xmas/market.dart';
import 'package:xmas/market_repository.dart';
import 'package:xmas/theme.dart' as theme;

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: theme.theme,
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return buildScaffold();
  }

  @override
  void initState() {
    super.initState();
    selectedDate = initialDate;
    MarketRepository().getMarkets().then((markets) {
      setState(() {
        this.markets = markets;
      });
    });
  }

  DateTime selectedDate;
  List<Market> markets = [];

  Widget buildScaffold() {
    return Scaffold(
      body: Column(
        children: <Widget>[
          _buildHeader(),
          _buildDatePicker(),
//          _buildMarketDisplay(),
        ],
      ),
    );
  }

  Widget _buildDatePicker() {
    return Container(
      height: 100,
      child: PageView.builder(
        itemBuilder: (context, position) {
          return Row(
            children: <Widget>[
              SizedBox.fromSize(
                size: Size.fromWidth(16),
              ),
              _buildDateCard(position, 0),
              _buildDateCard(position, 1),
              _buildDateCard(position, 2),
              _buildDateCard(position, 3),
              _buildDateCard(position, 4),
              SizedBox.fromSize(
                size: Size.fromWidth(16),
              ),
            ],
          );
        },
      ),
    );
  }

  final initialDate = DateTime(2019, 11, 1);
  final monthFormat = DateFormat('MMM');
  final dayOfWeekFormat = DateFormat('EEE');

  Widget _buildDateCard(int position, int i) {
    final date = initialDate.add(Duration(days: position * 5 + i));
    final isSelected = selectedDate == date;
    return Expanded(
      child: Card(
        color: isSelected ? theme.colorRed : Colors.white,
        child: InkWell(
          onTap: () {
            setState(() {
              selectedDate = date;
            });
          },
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              Text(
                monthFormat.format(date),
                style: TextStyle(
                    fontSize: 12,
                    color: isSelected ? Colors.white : Colors.black),
              ),
              Text(
                date.day.toString(),
                style: TextStyle(
                    fontSize: 16,
                    color: isSelected ? Colors.white : Colors.black),
              ),
              Text(
                dayOfWeekFormat.format(date),
                style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: isSelected ? Colors.white : Colors.black),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Stack _buildHeader() {
    return Stack(
      children: <Widget>[
        Image.asset('assets/background.png'),
        Container(
          height: 270,
          child: FlareActor(
            "assets/snow.flr",
            alignment: Alignment.topCenter,
            fit: BoxFit.fill,
            animation: "snow",
          ),
        ),
        SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Center(
              child: Text(
                'Weihnachtsmarkt',
                style: theme.headerTextStyle,
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildMarketDisplay() {
    final marketsOnDate = markets.where(_isMarketOnDate).toList();
    marketsOnDate.sort((a, b) => b.startDate.compareTo(a.startDate));
    return Expanded(
      child: ListView.builder(
        padding: EdgeInsets.all(16),
        itemCount: marketsOnDate.length,
        itemBuilder: (context, position) {
          return Card(
              child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              marketsOnDate[position].name,
              style: theme.marketTextStyle,
            ),
          ));
        },
      ),
    );
  }

  bool _isMarketOnDate(Market market) {
    var startDate = market.startDate;
    return startDate.isAtSameMomentAs(selectedDate) ||
        startDate.isBefore(selectedDate);
  }
}
