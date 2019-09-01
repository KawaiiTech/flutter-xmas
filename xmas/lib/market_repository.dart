import 'dart:convert';
import 'dart:io';

import 'package:flutter/services.dart';
import 'package:xmas/market.dart';
import 'package:xmas/regions.dart';
import 'package:csv/csv.dart';
import 'package:intl/intl.dart';

class MarketRepository {
  Future<List<Market>> getMarkets(Region region) async {
    final input = await rootBundle.loadString('assets/bayern.csv');
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
    startDate: format.parse(row[2].substring(3))
  );
}
