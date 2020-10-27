import 'package:flutter/material.dart';

class TextAppBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Text(
      'location',
      style: Theme.of(context).textTheme.headline1.copyWith(
            fontSize: 24.0,
            color: Colors.white,
            fontWeight: FontWeight.w300,
            letterSpacing: 10.0,
          ),
    );
  }
}
