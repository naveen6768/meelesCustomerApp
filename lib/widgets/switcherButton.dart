import 'package:flutter/material.dart';

class SwitcherButton extends StatefulWidget {
  @override
  _SwitcherButtonState createState() => _SwitcherButtonState();
}

class _SwitcherButtonState extends State<SwitcherButton> {
  bool isSwitched = false;
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'Mess',
              style: Theme.of(context)
                  .textTheme
                  .headline1
                  .copyWith(fontSize: 23.0),
            ),
            Switch(
              value: isSwitched,
              onChanged: (value) {
                setState(() {
                  isSwitched = value;
                  print(isSwitched);
                });
              },
              // inactiveThumbColor: Colors.blue,
              // inactiveTrackColor: Colors.lightBlueAccent,
              activeTrackColor: Colors.lightGreenAccent,
              activeColor: Colors.green,
            ),
            Text(
              'Tiffin',
              style: Theme.of(context)
                  .textTheme
                  .headline1
                  .copyWith(fontSize: 23.0),
            ),
          ],
        ),
      ),
    );
  }
}
