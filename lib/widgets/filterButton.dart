import 'package:flutter/material.dart';

class FilterButton extends StatelessWidget {
  final String buttonTitle;
  final Icon buttonIcon;
  final Function buttonOnPressed;
  FilterButton({this.buttonIcon, this.buttonTitle, this.buttonOnPressed});

  @override
  Widget build(BuildContext context) {
    return RaisedButton(
      elevation: 3.0,
      onPressed: buttonOnPressed,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            buttonIcon,
            SizedBox(
              width: 5.0,
            ),
            Text(buttonTitle)
          ],
        ),
      ),
    );
  }
}
