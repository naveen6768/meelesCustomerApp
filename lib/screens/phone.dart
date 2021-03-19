import 'package:Meeles/providers/auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:pinput/pin_put/pin_put.dart';
import 'package:provider/provider.dart';

class PhoneScreen extends StatefulWidget {
  @override
  _PhoneScreenState createState() => _PhoneScreenState();
}

class _PhoneScreenState extends State<PhoneScreen> {
  BoxDecoration get _pinPutDecoration {
    return BoxDecoration(
      border: Border.all(color: Colors.black),
      borderRadius: BorderRadius.circular(15.0),
    );
  }  
  final _key = GlobalKey<FormState>(), _key2 = GlobalKey<FormState>();
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  TextEditingController phone = new TextEditingController(),_pinPutController = new TextEditingController() ;
  FocusNode _pinPutFocusNode = new FocusNode();
  var id;
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    void setFocus(context){
      FocusScope.of(context).requestFocus(_pinPutFocusNode);
    }

    Future otp(_phonenumber, context) async {
      String code;
      await FirebaseAuth.instance.verifyPhoneNumber(
        phoneNumber: '+91${_phonenumber}',
        verificationCompleted: (PhoneAuthCredential credential) async {
          print('verification');
          await Provider.of<Auth>(context, listen: false).phonelogin(credential);
          Navigator.of(context).pop();
        },
        verificationFailed: (FirebaseAuthException e) {
          if (e.code == 'invalid-phone-number') {
            _scaffoldKey.currentState.showSnackBar(
              SnackBar(
                content: Text('Invalid Phone Number'),
                backgroundColor: Colors.red,
              ),
            );
            Navigator.of(context).pop();
          }
        },
        codeSent: (String verificationId, int resendToken) async {
          print('entered');
          
            id = verificationId;
          
          print(id);
        },
        timeout: const Duration(seconds: 120),
        codeAutoRetrievalTimeout: (String verificationId) {
          _scaffoldKey.currentState.showSnackBar(
            SnackBar(
              content: Text('Timeout'),
              backgroundColor: Colors.red,
            ),
          );
          Navigator.of(context).pop();
        },
      );
      await showDialog(
          context: context,
          builder: (BuildContext context) {
            setFocus(context);
            return AlertDialog(
              title: Text('Enter your OTP'),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                      'We have sent you an OTP on your Mobile No. ${_phonenumber}'),
                  SizedBox(
                    height: 12,
                  ),
                  PinPut(
                    key: _key2,
                    fieldsCount: 6,
                    onChanged: (cd){
                      code = cd;
                    },
                    validator: (val) {
                      if (val.length != 6) return 'Enter The OTP';
                    },
                    textStyle: TextStyle(color: Colors.black),
                    focusNode: _pinPutFocusNode,
                    controller: _pinPutController,
                    submittedFieldDecoration: _pinPutDecoration.copyWith(
                      borderRadius: BorderRadius.circular(20.0),
                      border: Border.all(
                        color: Colors.black,
                      ),
                    ),
                    selectedFieldDecoration: _pinPutDecoration,
                    followingFieldDecoration: _pinPutDecoration.copyWith(
                      borderRadius: BorderRadius.circular(5.0),
                      border: Border.all(
                        color: Colors.black,
                      ),
                    ),
                  ),
                  
                ],
              ),
              actions: [
                FlatButton(
                  onPressed: () async {
                    print('entered resend');
                    await FirebaseAuth.instance.verifyPhoneNumber(
                      phoneNumber: '+91${_phonenumber}',
                      verificationCompleted:
                          (PhoneAuthCredential credential) async {
                        print('verification');
                        await Provider.of<Auth>(context, listen: false)
                            .phonelogin(credential);
                        Navigator.of(context).pop();
                      },
                      verificationFailed: (FirebaseAuthException e) {
                        if (e.code == 'invalid-phone-number') {
                          print('The provided phone number is not valid.');
                        }
                      },
                      codeSent: (String verificationId, int resendToken) async {
                        print('entered');
                        
                          id = verificationId;
                        
                        print(id);
                      },
                      timeout: const Duration(seconds: 120),
                      codeAutoRetrievalTimeout: (String verificationId) {
                        print('Time-out');
                      },
                    );
                  },
                  child: Text(
                    'Resend',
                    style: TextStyle(fontFamily: 'Lato', color: Colors.blue),
                  ),
                ),
                RaisedButton(
                  onPressed: () async {
                     PhoneAuthCredential phoneAuthCredential = PhoneAuthProvider.credential(
                      verificationId: id,
                      smsCode: code,
                    );
                    await Provider.of<Auth>(context, listen: false)
                        .phonelogin(phoneAuthCredential);
                        FocusScope.of(context).unfocus();
                    Navigator.of(context).pop();
                  },
                  child: Text(
                    'Verify',
                    style: TextStyle(
                      color: Colors.white,
                      fontFamily: 'Lato',
                    ),
                  ),
                  color: Colors.black,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(18.0),
                      side: BorderSide(color: Colors.white)),
                ),
              ],
            );
          });
    }

    return Scaffold(
      key: _scaffoldKey,
      body: Container(
          height: height,
          width: width,
          padding: EdgeInsets.all(15),
          decoration: BoxDecoration(image: DecorationImage(
            colorFilter: new ColorFilter.mode(Colors.white.withOpacity(0.6), BlendMode.dstATop),
            image: AssetImage('images/thali.jpg'), fit: BoxFit.cover),),
    child: Center(
      child: Form(
        key: _key,
              child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Login', style: TextStyle(fontFamily: 'Lato',color: Colors.white, fontSize: 24, fontWeight: FontWeight.w900),),
            SizedBox(height: 12),
            TextFormField(
              controller: phone,
              keyboardType: TextInputType.number,
              maxLength: 10,
              
              decoration: InputDecoration(
                labelText: 'Phone No.',
                labelStyle: TextStyle(fontFamily: 'Lato', color: Colors.black,),
                fillColor: Colors.white,
                filled: true,
                enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(20)),borderSide: BorderSide(color: Colors.white)),
                focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(20)),borderSide: BorderSide(color: Colors.white)),
                border: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(20)), borderSide: BorderSide(color: Colors.white))
              ),
            ),
            //SizedBox(height:6),
            ElevatedButton(
              onPressed: (){
                print(phone.text);
                //Provider.of<Auth>(context,listen: false).messphone(phone.text);
                otp(phone.text, context);
                //Navigator.of(context).push(_createRoute());
              },
             child: Text('Send OTP'), style: ElevatedButton.styleFrom(primary: Theme.of(context).primaryColor,),),
          ],
        ),
      ),
      ),
          ),
      );
  }
}