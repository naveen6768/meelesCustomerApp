import 'package:flutter/material.dart';
import './homeScreen.dart';
import 'package:provider/provider.dart';
import 'package:flutter/services.dart';
import '../providers/auth.dart';

enum AuthMode {
  Login,
  Signup,
}

class LoginScreen extends StatefulWidget {
  static const id = 'LoginScreen';

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formkey = GlobalKey<FormState>();
  final _passwordController = TextEditingController();
  var _authmode = AuthMode.Login;
  var _isLoading = false;
  final passwordnode = FocusNode();
  final confirmnode = FocusNode();
  var email = '';
  var password = '';
  Future<void> _submit() async {
    if (!_formkey.currentState.validate()) {
      return;
    } else {
      _formkey.currentState.save();
      setState(() {
        _isLoading = true;
      });
      try {
        if (_authmode == AuthMode.Login) {
          await Provider.of<Auth>(context, listen: false)
              .authlogin(email, password);
        } else {
          await Provider.of<Auth>(context, listen: false)
              .authsignup(email, password);
        }
      } on PlatformException catch (err) {
        var message = "An Error occured, Please Check your Credentials";
        if (err.message != null) message = err.message;
        Scaffold.of(context).showSnackBar(
          SnackBar(
            content: Text(message),
            backgroundColor: Theme.of(context).errorColor,
          ),
        );
        setState(() {
          _isLoading = false;
        });
      } catch (err) {
        print(err);
        setState(() {
          _isLoading = false;
        });
      }
      setState(() {
        _isLoading = false;
      });
    }
  }

  void _switchMode() {
    if (_authmode == AuthMode.Signup) {
      setState(() {
        _authmode = AuthMode.Login;
      });
    } else
      setState(() {
        _authmode = AuthMode.Signup;
      });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Authentication'),
        centerTitle: true,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 23.0, vertical: 18.0),
            child: Form(
              key: _formkey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Image(
                    image: AssetImage('images/meeles_logo.png'),
                  ),
                  SizedBox(
                    height: 5.0,
                  ),
                  Text(
                    _authmode == AuthMode.Login ? 'Login' : 'Signup',
                    style: Theme.of(context).textTheme.headline1.copyWith(
                        fontSize: 45.0,
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
                    'Enter your Email',
                    style: Theme.of(context)
                        .textTheme
                        .headline1
                        .copyWith(fontSize: 25.0, fontWeight: FontWeight.w500),
                  ),
                  const SizedBox(
                    height: 13.0,
                  ),
                  TextFormField(
                    decoration: InputDecoration(
                      fillColor: Theme.of(context).accentColor,
                      filled: true,
                      // hintText: 'email',
                      contentPadding: EdgeInsets.symmetric(
                          vertical: 10.0, horizontal: 20.0),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10.0)),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide:
                            BorderSide(color: Colors.white30, width: 1.0),
                        borderRadius: BorderRadius.all(Radius.circular(10.0)),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide:
                            BorderSide(color: Colors.black45, width: 2.0),
                        borderRadius: BorderRadius.all(Radius.circular(10.0)),
                      ),
                    ),
                    onSaved: (value) {
                      email = value;
                    },
                    validator: (val) {
                      if (val.isEmpty || !val.contains('@'))
                        return 'Invalid Email';
                    },
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
                  TextFormField(
                    decoration: InputDecoration(
                      fillColor: Theme.of(context).accentColor,
                      filled: true,
                      // hintText: 'email',
                      contentPadding: EdgeInsets.symmetric(
                          vertical: 10.0, horizontal: 20.0),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10.0)),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide:
                            BorderSide(color: Colors.white30, width: 1.0),
                        borderRadius: BorderRadius.all(Radius.circular(10.0)),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide:
                            BorderSide(color: Colors.black45, width: 2.0),
                        borderRadius: BorderRadius.all(Radius.circular(10.0)),
                      ),
                    ),
                    controller: _passwordController,
                    obscureText: true,
                    onSaved: (val) => password = val,
                    focusNode: passwordnode,
                  ),
                  if (_authmode == AuthMode.Signup)
                    const SizedBox(
                      height: 16.0,
                    ),
                  if (_authmode == AuthMode.Signup)
                    Text(
                      'Confirm your password',
                      style: Theme.of(context).textTheme.headline1.copyWith(
                          fontSize: 25.0, fontWeight: FontWeight.w500),
                    ),
                  if (_authmode == AuthMode.Signup)
                    const SizedBox(
                      height: 13.0,
                    ),
                  if (_authmode == AuthMode.Signup)
                    TextFormField(
                      decoration: InputDecoration(
                        fillColor: Theme.of(context).accentColor,
                        filled: true,
                        // hintText: 'email',
                        contentPadding: EdgeInsets.symmetric(
                            vertical: 10.0, horizontal: 20.0),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10.0)),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide:
                              BorderSide(color: Colors.white30, width: 1.0),
                          borderRadius: BorderRadius.all(Radius.circular(10.0)),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide:
                              BorderSide(color: Colors.black45, width: 2.0),
                          borderRadius: BorderRadius.all(Radius.circular(10.0)),
                        ),
                      ),
                      validator: (value) {
                        if (value != _passwordController.text)
                          return 'Password Not Match';
                      },
                      focusNode: confirmnode,
                      obscureText: true,
                    ),

                  const SizedBox(
                    height: 25.0,
                  ),
                  if (_isLoading)
                    CircularProgressIndicator()
                  else
                    RaisedButton(
                      elevation: 8.0,
                      onPressed: _submit,
                      color: Theme.of(context).primaryColor,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 30.0, vertical: 7.0),
                        child: Text(
                          _authmode == AuthMode.Login ? 'Login' : 'Signup',
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
                      onPressed: _switchMode,
                      color: Theme.of(context).primaryColor,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 82.0, vertical: 7.0),
                        child: Text(
                          _authmode == AuthMode.Login ? 'Sigup' : 'Login',
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
      ),
    );
  }
}
