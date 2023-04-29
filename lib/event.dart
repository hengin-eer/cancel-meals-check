import 'package:flutter/material.dart';

class Event {
  final String title;
  bool isChecked;
  DateTime date;

  Event(this.title, this.isChecked, this.date);

  @override
  String toString() => title;
}
