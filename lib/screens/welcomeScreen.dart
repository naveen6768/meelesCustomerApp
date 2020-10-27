import 'package:flutter/material.dart';
import '../screens/loginScreen.dart';

class WelcomeScreen extends StatelessWidget {
  static const id = 'WelcomeScreen';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 60.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Image(
                  image: AssetImage('images/entryImage.png'),
                ),
                Text(
                  " Get the best quality food\nnear you. We always work \n      to deliver the best!",
                  style: TextStyle(
                    fontSize: 26.0,
                    fontFamily: 'Lato',
                    fontWeight: FontWeight.w700,
                  ),
                ),
                RaisedButton(
                  elevation: 4.0,
                  onPressed: () {
                    Navigator.of(context).pushReplacementNamed(LoginScreen.id);
                  },
                  color: Theme.of(context).primaryColor,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 7.0, horizontal: 30.0),
                    child: Text(
                      'Continue!',
                      style: TextStyle(
                        fontSize: 26.0,
                        fontFamily: 'Lato',
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
