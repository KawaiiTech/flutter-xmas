import 'package:flutter/cupertino.dart';

@immutable
class Market {
  final String name;
  final String url;
  final DateTime startDate;

  Market({
    @required this.name,
    @required this.url,
    @required this.startDate,
  });
}
