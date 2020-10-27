import 'package:flutter/material.dart';
import 'package:meelesCustomerApp/screens/homeScreen.dart';

class LoginScreen extends StatelessWidget {
  static const id = 'LoginScreen';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 23.0, vertical: 18.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Image(
                //   image: AssetImage('images/meeles_logo.png'),
                // ),
                SizedBox(
                  height: 5.0,
                ),
                Text(
                  'Login',
                  style: Theme.of(context).textTheme.headline1.copyWith(
                      fontSize: 62.0,
                      // fontWeight: FontWeight.w600,
                      color: Theme.of(context).primaryColor),
                ),
                SizedBox(
                  height: 12.0,
                ),
                Text(
                  'To eat the best quality food near you',
                  style: Theme.of(context)
                      .textTheme
                      .headline2
                      .copyWith(fontSize: 17.0),
                ),
                const SizedBox(
                  height: 20.0,
                ),
                Text(
                  'Enter your email',
                  style: Theme.of(context)
                      .textTheme
                      .headline1
                      .copyWith(fontSize: 25.0, fontWeight: FontWeight.w500),
                ),
                const SizedBox(
                  height: 13.0,
                ),
                TextField(
                  decoration: InputDecoration(
                    fillColor: Theme.of(context).accentColor,
                    filled: true,
                    // hintText: 'email',
                    contentPadding:
                        EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10.0)),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.white30, width: 1.0),
                      borderRadius: BorderRadius.all(Radius.circular(10.0)),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.black45, width: 2.0),
                      borderRadius: BorderRadius.all(Radius.circular(10.0)),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 16.0,
                ),
                Text(
                  'Enter your password',
                  style: Theme.of(context)
                      .textTheme
                      .headline1
                      .copyWith(fontSize: 25.0, fontWeight: FontWeight.w500),
                ),
                const SizedBox(
                  height: 13.0,
                ),
                TextField(
                  decoration: InputDecoration(
                    fillColor: Theme.of(context).accentColor,
                    filled: true,
                    // hintText: 'email',
                    contentPadding:
                        EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10.0)),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.white30, width: 1.0),
                      borderRadius: BorderRadius.all(Radius.circular(10.0)),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.black45, width: 2.0),
                      borderRadius: BorderRadius.all(Radius.circular(10.0)),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 25.0,
                ),
                RaisedButton(
                  elevation: 8.0,
                  onPressed: () {
                    Navigator.of(context).pushReplacementNamed(HomeScreen.id);
                  },
                  color: Theme.of(context).primaryColor,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 30.0, vertical: 7.0),
                    child: Text(
                      'Login',
                      style: Theme.of(context).textTheme.button.copyWith(
                          color: Colors.white,
                          fontSize: 25.0,
                          fontWeight: FontWeight.w600),
                    ),
                  ),
                ),
                SizedBox(
                  height: 22.0,
                ),
                Center(
                  child: RaisedButton(
                    elevation: 5.0,
                    onPressed: () {},
                    color: Color(0xff4285F4),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20.0, vertical: 7.0),
                      child: Text(
                        'Sign In with Google',
                        style: Theme.of(context).textTheme.button.copyWith(
                              color: Colors.white,
                              fontSize: 25.0,
                              fontWeight: FontWeight.w600,
                            ),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 20.0,
                ),
                Center(
                  child: RaisedButton(
                    elevation: 5.0,
                    onPressed: () {},
                    color: Theme.of(context).primaryColor,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 82.0, vertical: 7.0),
                      child: Text(
                        'Register',
                        style: Theme.of(context).textTheme.button.copyWith(
                              color: Colors.white,
                              fontSize: 25.0,
                              fontWeight: FontWeight.w600,
                            ),
                      ),
                    ),
                  ),
                ),
                // SizedBox(
                //   height: 15.0,
                // ),
                Center(
                  child: FlatButton(
                    onPressed: null,
                    child: Text(
                      'Partner with us',
                      style: Theme.of(context).textTheme.headline4.copyWith(
                            fontWeight: FontWeight.w800,
                            color: Theme.of(context).primaryColor,
                            fontSize: 20.0,
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
