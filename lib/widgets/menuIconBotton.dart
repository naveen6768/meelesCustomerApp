import 'package:flutter/material.dart';

class MenuIconButton extends StatelessWidget {
  final Function onPressed;
  MenuIconButton({this.onPressed});
  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: Icon(
        Icons.menu,
        color: Colors.white,
        size: 30.0,
      ),
      onPressed: onPressed,
    );
  }
}
