import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:url_launcher/url_launcher.dart';
import 'dart:core';

class FeedbackForm extends StatefulWidget {
  static const routeName = '/feedback';

  @override
  _FeedbackFormState createState() => _FeedbackFormState();
}

class _FeedbackFormState extends State<FeedbackForm> {
  @override
  Widget build(BuildContext context) {
    final _formkey = GlobalKey<FormState>();
    String feedback = '';
    bool _isLoading = false;
    _launchURL() async {
      const url =
          'https://play.google.com/store/apps/details?id=com.angrybaaz.meelesapp';
      await launch(url);
      // if (await canLaunch(url)) {
      //   await launch(url);
      // } else {
      //   throw 'Could not launch $url';
      // }
    }

    Future<void> _submit() async {
      if (!_formkey.currentState.validate()) {
        return;
      } else {
        _formkey.currentState.save();
        setState(() {
          _isLoading = true;
        });
        try {
          await FirebaseFirestore.instance.collection('Feedback').add({
            'Name': FirebaseAuth.instance.currentUser.phoneNumber,
            'Feedback': feedback,
            'Time': DateTime.now(),
          });
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

    return Scaffold(
      appBar: AppBar(
        // title: Text(
        //   'Feedback Form',
        //   style: TextStyle(fontFamily: 'Lato'),
        // ),
        backgroundColor: Colors.white,
        elevation: 5,
        leading: IconButton(icon: Icon(Icons.arrow_back,color: Colors.black), onPressed: (){
          Navigator.of(context).pop();
        },),
      ),
      body: Container(
        margin: EdgeInsets.all(20.0),
        padding: EdgeInsets.all(20.0),
        child: Form(
          key: _formkey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 5.0,
              ),
              Text(
                'Feedback',
                style: Theme.of(context).textTheme.headline1.copyWith(
                      fontSize: 25.0,
                      fontWeight: FontWeight.w600,
                      color: Theme.of(context).primaryColor,
                      fontFamily: 'Lato',
                    ),
              ),
              SizedBox(
                height: 12.0,
              ),
              Text(
                'Help us to know your experience and improve our service',
                style: Theme.of(context).textTheme.headline2.copyWith(
                      fontSize: 17.0,
                      fontFamily: 'Lato',
                    ),
              ),
              const SizedBox(
                height: 18.0,
              ),
              Text(
                'Your Views',
                style: Theme.of(context).textTheme.headline1.copyWith(
                      fontSize: 20.0,
                      fontWeight: FontWeight.w500,
                      fontFamily: 'Lato',
                    ),
              ),
              const SizedBox(
                height: 13.0,
              ),
              TextFormField(
                maxLines: 5,
                decoration: InputDecoration(
                  fillColor: Theme.of(context).accentColor,
                  filled: true,
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
                onSaved: (value) {
                  feedback = value;
                },
                validator: (val) {
                  if (val.isEmpty) return 'Invalid Email';
                },
              ),
              SizedBox(
                height: 15,
              ),
              RaisedButton(
                elevation: 8.0,
                onPressed: _submit,
                color: Theme.of(context).primaryColor,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 30.0, vertical: 7.0),
                  child: Text(
                    'Submit',
                    style: Theme.of(context).textTheme.button.copyWith(
                          color: Colors.white,
                          fontSize: 18.0,
                          fontWeight: FontWeight.w600,
                          fontFamily: 'Lato',
                        ),
                  ),
                ),
              ),
              SizedBox(
                height: 10.0,
              ),
              Center(
                child: Container(
                  width: double.infinity,
                  child: RaisedButton(
                    elevation: 5.0,
                    onPressed: _launchURL,
                    color: Color(0xff4285F4),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20.0, vertical: 7.0),
                      child: Text(
                        'Rate Us on Google PlayStore',
                        style: Theme.of(context).textTheme.button.copyWith(
                              color: Colors.white,
                              fontSize: 18.0,
                              fontWeight: FontWeight.w600,
                              fontFamily: 'Lato',
                            ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
