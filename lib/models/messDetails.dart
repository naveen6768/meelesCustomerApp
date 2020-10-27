import 'package:flutter/material.dart';

class MessDetails {
  final String messId;
  final Map<String, dynamic> initialdata;
  final bool isopen;
  final bool ismonthly;
  MessDetails({
    @required this.messId,
    @required this.initialdata,
    @required this.isopen,
    @required this.ismonthly,
  });
}
