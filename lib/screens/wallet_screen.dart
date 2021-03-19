// import 'package:Meeles/screens/addmoney_screen.dart';
// import 'package:flutter/material.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:intl/intl.dart';
// import 'package:razorpay_flutter/razorpay_flutter.dart';
// import 'package:toast/toast.dart';

// class Wallet extends StatefulWidget {
//   static const routeName = '/wallet';

//   @override
//   _WalletState createState() => _WalletState();
// }

// class _WalletState extends State<Wallet> {
//   var currentuser = FirebaseAuth.instance.currentUser;
//   var instant = FirebaseFirestore.instance
//       .collection('Customer')
//       .doc(FirebaseAuth.instance.currentUser.email);
//   var razorpay = Razorpay();

//   TextEditingController textEditingController = new TextEditingController();

//   @override
//   void initState() {
//     super.initState();

//     razorpay = new Razorpay();

//     razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, handlerPaymentSuccess);
//     razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, handlerErrorFailure);
//     razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, handlerExternalWallet);
//   }

//   @override
//   void dispose() {
//     // TODO: implement dispose
//     super.dispose();
//     razorpay.clear();
//   }

//   void openCheckout() {
//     var options = {
//       "key": "rzp_test_StoQ4zVpXefSqB",
//       "amount": num.parse(textEditingController.text) * 100,
//       "name": "Sample App",
//       "description": "Payment for the some random product",
//       "prefill": {
//         "contact": "2323232323",
//         "email": FirebaseAuth.instance.currentUser.email,
//       },
//       "external": {
//         "wallets": ["paytm"]
//       }
//     };

//     try {
//       razorpay.open(options);
//     } catch (e) {
//       print(e.toString());
//     }
//   }

//   void handlerPaymentSuccess(PaymentSuccessResponse response) {
//     print("Pament success ${response}");
//     FirebaseFirestore.instance.runTransaction((transaction) async {
//       DocumentSnapshot snapshot = await transaction.get(instant);

//       if (!snapshot.exists) {
//         throw Exception("User does not exist!");
//       }

//       int newFollowerCount =
//           snapshot.data()['Balance'] + num.parse(textEditingController.text);

//       transaction.update(instant, {'Balance': newFollowerCount});

//       return newFollowerCount;
//     }).then((value) async {
//       await instant.collection('Transactions').add({
//         'Amount': num.parse(textEditingController.text),
//         'Date': DateFormat.yMd().add_jm().format(new DateTime.now()),
//         'Receiver': 'Added to Wallet',
//         'Type': 'Credit',
//       });
//       print(DateFormat.yMd().add_jm().format(new DateTime.now()));
//       print(value);
//     }).catchError((error) => print("Failed to update user followers: $error"));

//     Toast.show("Pament success", context);
//   }

//   void handlerErrorFailure(PaymentFailureResponse response) {
//     print("Pament error $response");
//     Toast.show("Pament error", context);
//   }

//   void handlerExternalWallet(ExternalWalletResponse response) {
//     print("External Wallet $response");
//     Toast.show("External Wallet", context);
//   }

//   @override
//   Widget build(BuildContext context) {
//     final _formkey = GlobalKey<FormState>();
//     var amount;

//     Future<void> _showMyDialog() async {
//       return showDialog<void>(
//         context: context,
//         barrierDismissible: false, // user must tap button!
//         builder: (BuildContext context) {
//           return AlertDialog(
//             title: Text('Enter The Amount'),
//             content: Form(
//               key: _formkey,
//               child: TextFormField(
//                 controller: textEditingController,
//                 decoration: InputDecoration(
//                   fillColor: Theme.of(context).accentColor,
//                   filled: true,
//                   // hintText: 'email',
//                   contentPadding:
//                       EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
//                   border: OutlineInputBorder(
//                     borderRadius: BorderRadius.all(Radius.circular(10.0)),
//                   ),
//                   enabledBorder: OutlineInputBorder(
//                     borderSide: BorderSide(color: Colors.white30, width: 1.0),
//                     borderRadius: BorderRadius.all(Radius.circular(10.0)),
//                   ),
//                   focusedBorder: OutlineInputBorder(
//                     borderSide: BorderSide(color: Colors.black45, width: 2.0),
//                     borderRadius: BorderRadius.all(Radius.circular(10.0)),
//                   ),
//                 ),
//                 keyboardType: TextInputType.number,
//                 onSaved: (value) {
//                   amount = value;
//                 },
//                 validator: (val) {
//                   if (val.isEmpty || val == 0) return 'Enter The Amount Please';
//                 },
//               ),
//             ),
//             actions: <Widget>[
//               FlatButton(
//                 child: Text('Proceed'),
//                 onPressed: () {
//                   if (_formkey.currentState.validate()) {
//                     _formkey.currentState.save();
//                     print('$amount');
//                     openCheckout();
//                   }

//                   Navigator.of(context).pop();
//                 },
//               ),
//             ],
//           );
//         },
//       );
//     }

//     return Scaffold(
//       appBar: AppBar(
//         title: Text(
//           'Wallet',
//           style: TextStyle(
//             fontFamily: 'Lato',
//           ),
//         ),
//       ),
//       body: Column(
//         children: <Widget>[
//           Container(
//             margin: EdgeInsets.all(20),
//             padding: EdgeInsets.all(20),
//             height: 250,
//             width: double.infinity,
//             decoration: BoxDecoration(
//               color: Colors.yellow[200],
//             ),
//             child: Column(
//               mainAxisAlignment: MainAxisAlignment.start,
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Text(
//                   'Available Balance',
//                   style: TextStyle(
//                     fontFamily: 'Lato',
//                     fontSize: 18.0,
//                     fontWeight: FontWeight.bold,
//                     textBaseline: TextBaseline.alphabetic,
//                   ),
//                 ),
//                 SizedBox(
//                   height: 75,
//                 ),
//                 StreamBuilder<DocumentSnapshot>(
//                   stream: instant.snapshots(includeMetadataChanges: true),
//                   builder: (BuildContext context,
//                       AsyncSnapshot<DocumentSnapshot> snapshot) {
//                     if (snapshot.hasError) return Text('NaN');

//                     if (snapshot.connectionState == ConnectionState.waiting) {
//                       return LinearProgressIndicator();
//                     }

//                     Map<String, dynamic> data = snapshot.data.data();
//                     return Row(
//                       mainAxisAlignment: MainAxisAlignment.end,
//                       children: [
//                         Text(
//                           '${data['Balance']}',
//                           textAlign: TextAlign.right,
//                           style: TextStyle(
//                             fontFamily: 'Lato',
//                             fontWeight: FontWeight.bold,
//                             fontSize: 30,
//                           ),
//                         ),
//                       ],
//                     );
//                   },
//                 ),
//                 SizedBox(
//                   height: 25,
//                 ),
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   children: [
//                     RaisedButton(
//                       elevation: 8.0,
//                       onPressed: () {
//                         _showMyDialog();
//                         //Navigator.of(context).pushNamed(AddMoney.routeName);
//                       },
//                       color: Theme.of(context).primaryColor,
//                       shape: RoundedRectangleBorder(
//                         borderRadius: BorderRadius.circular(30),
//                       ),
//                       child: Padding(
//                         padding: const EdgeInsets.symmetric(
//                             horizontal: 10.0, vertical: 7.0),
//                         child: Text(
//                           'Add Money',
//                           style: Theme.of(context).textTheme.button.copyWith(
//                                 color: Colors.white,
//                                 fontSize: 18.0,
//                                 fontWeight: FontWeight.w600,
//                                 fontFamily: 'Lato',
//                               ),
//                         ),
//                       ),
//                     ),
//                     RaisedButton(
//                       elevation: 8.0,
//                       onPressed: () {},
//                       color: Theme.of(context).primaryColor,
//                       shape: RoundedRectangleBorder(
//                         borderRadius: BorderRadius.circular(30),
//                       ),
//                       child: Padding(
//                         padding: const EdgeInsets.symmetric(
//                             horizontal: 10.0, vertical: 7.0),
//                         child: Text(
//                           'Choose Plan',
//                           style: Theme.of(context).textTheme.button.copyWith(
//                                 color: Colors.white,
//                                 fontSize: 18.0,
//                                 fontWeight: FontWeight.w600,
//                                 fontFamily: 'Lato',
//                               ),
//                         ),
//                       ),
//                     ),
//                   ],
//                 )
//               ],
//             ),
//           ),
//           Text(
//             'Transactions',
//             style: TextStyle(
//                 fontFamily: 'Lato', fontSize: 20, fontWeight: FontWeight.bold),
//           ),
//           StreamBuilder<QuerySnapshot>(
//               stream: FirebaseFirestore.instance
//                   .collection('Customer')
//                   .doc(currentuser.email)
//                   .collection('Transactions')
//                   .orderBy('Date', descending: false)
//                   .snapshots(),
//               builder: (BuildContext context,
//                   AsyncSnapshot<QuerySnapshot> snapshot) {
//                 if (snapshot.connectionState == ConnectionState.waiting) {
//                   return Center(child: CircularProgressIndicator());
//                 }
//                 if (snapshot.data.docs.isEmpty)
//                   return Text(
//                     'No Transaction till now',
//                     style: TextStyle(
//                       fontFamily: 'Lato',
//                       fontSize: 18,
//                     ),
//                   );
//                 return ListView(
//                   shrinkWrap: true,
//                   physics: ScrollPhysics(),
//                   children:
//                       snapshot.data.docs.map((QueryDocumentSnapshot document) {
//                     return ListTile(
//                       title: Text(
//                         '${document.data()['Receiver']}',
//                         style: TextStyle(fontFamily: 'Lato'),
//                       ),
//                       subtitle: Text(
//                         '${document.data()['Date']}',
//                         style: TextStyle(fontFamily: 'Lato'),
//                       ),
//                       trailing: Text(
//                         document.data()['Type'] == 'Debit'
//                             ? '- ${document.data()['Amount']}'
//                             : '+ ${document.data()['Amount']}',
//                         style: TextStyle(
//                           fontFamily: 'Lato',
//                           fontSize: 22,
//                           fontWeight: FontWeight.bold,
//                           color: document.data()['Type'] == 'Debit'
//                               ? Colors.red
//                               : Colors.green,
//                         ),
//                       ),
//                     );
//                   }).toList(),
//                 );
//               }),
//         ],
//       ),
//     );
//   }
// }
