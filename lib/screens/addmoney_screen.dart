// import 'package:flutter/material.dart';

// class AddMoney extends StatelessWidget {
//   static const routeName = '/addmoney';
//   @override
//   Widget build(BuildContext context) {
//     final _formkey = GlobalKey<FormState>();
//     var amount;
//     return AlertDialog(
//       title: Text('Enter The Amount'),
//       content: Form(
//         key: _formkey,
//         child: TextFormField(
//           decoration: InputDecoration(
//             fillColor: Theme.of(context).accentColor,
//             filled: true,
//             // hintText: 'email',
//             contentPadding:
//                 EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
//             border: OutlineInputBorder(
//               borderRadius: BorderRadius.all(Radius.circular(10.0)),
//             ),
//             enabledBorder: OutlineInputBorder(
//               borderSide: BorderSide(color: Colors.white30, width: 1.0),
//               borderRadius: BorderRadius.all(Radius.circular(10.0)),
//             ),
//             focusedBorder: OutlineInputBorder(
//               borderSide: BorderSide(color: Colors.black45, width: 2.0),
//               borderRadius: BorderRadius.all(Radius.circular(10.0)),
//             ),
//           ),
//           keyboardType: TextInputType.number,
//           onSaved: (value) {
//             amount = int.parse(value);
//           },
//           validator: (val) {
//             if (val.isEmpty || val == 0) return 'Enter The Amount Please';
//           },
//         ),
//       ),
//       actions: <Widget>[
//         FlatButton(
//           child: Text('Proceed'),
//           onPressed: () {
//             if (_formkey.currentState.validate()) print('$amount');
//             Navigator.of(context).pop();
//           },
//         )
//       ],
//     );
//   }
// }
