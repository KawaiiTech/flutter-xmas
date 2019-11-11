import 'package:csv/csv.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:xmas/market.dart';

class MarketRepository {
  Future<List<Market>> getMarkets() async {
    final input = await rootBundle.loadString('assets/berlin.csv');
    final fields = const CsvToListConverter().convert(input);
    print(fields);
    return fields.map((row) => _toMarket(row)).toList();
  }
}

final format = DateFormat("dd.MM.yyyy");

Market _toMarket(List<dynamic> row) {
  print(row);
  return Market(
    name: row[0],
    url: row[1],
    startDate: format.parse(row[2].substring(3)),
  );
}
