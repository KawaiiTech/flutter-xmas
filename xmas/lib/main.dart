import 'package:flutter/material.dart';
import 'package:xmas/market.dart';
import 'package:xmas/market_repository.dart';
import 'package:xmas/regions.dart';
import 'package:flare_flutter/flare_actor.dart';
import 'package:xmas/theme.dart' as theme;

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
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

  Scaffold buildScaffoldOld() {
    return Scaffold(
      appBar: AppBar(
        title: Text('Weihnachtsmarkt'),
      ),
      body: FutureBuilder(
        future: MarketRepository().getMarkets(Region.bayern),
        builder: (context, snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.none:
              return Container();
              break;
            case ConnectionState.waiting:
              return Container();
              break;
            case ConnectionState.active:
              return Container();
              break;
            case ConnectionState.done:
              final List<Market> markets = snapshot.data;
              return ListView.builder(
                  itemCount: markets.length,
                  itemBuilder: (context, position) {
                    return Text(markets[position].name);
                  });
              break;
            default:
              return Container();
              break;
          }
        },
      ),
    );
  }

  Widget buildScaffold() {
    return Scaffold(
      body: Column(
        children: <Widget>[
          _buildHeader(),
        ],
      ),
    );
  }

  Stack _buildHeader() {
    return Stack(
      children: <Widget>[
        Image.asset('assets/background.png'),
        Container(
          height: 300,
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
        )),
      ],
    );
  }
}
