// import 'package:Meeles/providers/messDetailsData.dart';
// import 'package:flutter/material.dart';
// import 'package:qr_flutter/qr_flutter.dart';
// import 'package:provider/provider.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:intl/intl.dart';

// class BookRecipt extends StatelessWidget {
//   static const id = 'bookrecipt';
//   var bookingid;
//   BookRecipt({
//     this.bookingid,
//   });
//   Map<String, dynamic> details;
//   @override
//   Widget build(BuildContext context) {
//     bookingid = ModalRoute.of(context).settings.arguments;
//     Map<String, dynamic> docref =
//         Provider.of<MessDetailsData>(context).mess_details;
//     return Scaffold(
//       appBar: AppBar(
//         title: Text(
//           'Booking Details',
//           style: TextStyle(
//             fontFamily: 'Lato',
//           ),
//         ),
//       ),
//       body: SingleChildScrollView(
//         child: Container(
//           margin: EdgeInsets.all(20.0),
//           padding: EdgeInsets.all(10.0),
//           child: Column(
//             children: <Widget>[
//               QrImage(
//                 data: bookingid['Order Id'],
//                 version: QrVersions.auto,
//                 size: 200.0,
//               ),
//               SizedBox(
//                 height: 20,
//               ),
//               Container(
//                 width: double.infinity,
//                 padding: EdgeInsets.all(10.0),
//                 child: Text(
//                   'Details',
//                   textAlign: TextAlign.center,
//                   style: TextStyle(
//                     fontFamily: 'Lato',
//                     fontSize: 20.0,
//                     fontWeight: FontWeight.bold,
//                     color: Colors.white,
//                   ),
//                 ),
//                 decoration: BoxDecoration(
//                   color: Colors.blueAccent,
//                   borderRadius: BorderRadius.circular(10.0),
//                 ),
//               ),
//               SizedBox(
//                 height: 15,
//               ),
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 children: <Widget>[
//                   Text(
//                     'Mess Name',
//                     style: TextStyle(
//                       fontFamily: 'Lato',
//                       fontSize: 16.0,
//                       fontWeight: FontWeight.bold,
//                     ),
//                   ),
//                   Text(
//                     docref['Shop Name'],
//                     style: TextStyle(
//                       fontFamily: 'Lato',
//                       fontSize: 16.0,
//                       fontWeight: FontWeight.bold,
//                     ),
//                   ),
//                 ],
//               ),
//               SizedBox(
//                 height: 15,
//               ),
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 children: <Widget>[
//                   Text(
//                     'Meal Type',
//                     style: TextStyle(
//                       fontFamily: 'Lato',
//                       fontSize: 16.0,
//                       fontWeight: FontWeight.bold,
//                     ),
//                   ),
//                   Text(
//                     bookingid['Type'],
//                     style: TextStyle(
//                       fontFamily: 'Lato',
//                       fontSize: 16.0,
//                       fontWeight: FontWeight.bold,
//                     ),
//                   ),
//                 ],
//               ),
//               SizedBox(
//                 height: 15,
//               ),
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 children: <Widget>[
//                   Text(
//                     'Timing',
//                     style: TextStyle(
//                       fontFamily: 'Lato',
//                       fontSize: 16.0,
//                       fontWeight: FontWeight.bold,
//                     ),
//                   ),
//                   Text(
//                     bookingid['Type'] == 'Lunch'
//                         ? '${docref['Lunch Begining']} - ${docref['Lunch End']}'
//                         : '${docref['Dinner Starting']} - ${docref['Dinner End']}',
//                     style: TextStyle(
//                       fontFamily: 'Lato',
//                       fontSize: 16.0,
//                       fontWeight: FontWeight.bold,
//                     ),
//                   ),
//                 ],
//               ),
//               SizedBox(
//                 height: 15,
//               ),
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 children: <Widget>[
//                   Text(
//                     'Payment Mode',
//                     style: TextStyle(
//                       fontFamily: 'Lato',
//                       fontSize: 16.0,
//                       fontWeight: FontWeight.bold,
//                     ),
//                   ),
//                   Text(
//                     bookingid['Payment Mode'],
//                     style: TextStyle(
//                       fontFamily: 'Lato',
//                       fontSize: 16.0,
//                       fontWeight: FontWeight.bold,
//                     ),
//                   ),
//                 ],
//               ),
//               SizedBox(
//                 height: 15,
//               ),
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 children: <Widget>[
//                   Text(
//                     'Amount',
//                     style: TextStyle(
//                       fontFamily: 'Lato',
//                       fontSize: 16.0,
//                       fontWeight: FontWeight.bold,
//                     ),
//                   ),
//                   Text(
//                     'Rs. ${bookingid['Price']}',
//                     style: TextStyle(
//                       fontFamily: 'Lato',
//                       fontSize: 16.0,
//                       fontWeight: FontWeight.bold,
//                     ),
//                   ),
//                 ],
//               ),
//               SizedBox(
//                 height: 20,
//               ),
//               Container(
//                 padding: EdgeInsets.fromLTRB(20.0, 20.0, 20.0, 10.0),
//                 decoration: BoxDecoration(
//                   borderRadius: BorderRadius.circular(20.0),
//                   color: Colors.grey[200],
//                 ),
//                 child: Container(
//                   padding: EdgeInsets.fromLTRB(8.0, 8.0, 8.0, 0.0),
//                   height: 140,
//                   child: Column(
//                     children: <Widget>[
//                       Text(
//                         'Your Menu',
//                         style: TextStyle(
//                           fontFamily: 'Lato',
//                           fontSize: 20.0,
//                           fontWeight: FontWeight.w900,
//                         ),
//                       ),
//                       Row(
//                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: <Widget>[
//                           Expanded(
//                             child: Container(
//                               margin: EdgeInsets.all(10),
//                               child: Column(
//                                 crossAxisAlignment: CrossAxisAlignment.start,
//                                 children: <Widget>[
//                                   Row(
//                                     mainAxisAlignment:
//                                         MainAxisAlignment.spaceBetween,
//                                     children: <Widget>[
//                                       Text(
//                                         bookingid['Item1'],
//                                         style: TextStyle(
//                                           fontFamily: 'Lato',
//                                           fontSize: 16.0,
//                                           fontWeight: FontWeight.bold,
//                                         ),
//                                       ),
//                                       SizedBox(
//                                         width: 30,
//                                       ),
//                                       Text(
//                                         bookingid['Item2'],
//                                         style: TextStyle(
//                                           fontFamily: 'Lato',
//                                           fontSize: 16.0,
//                                           fontWeight: FontWeight.bold,
//                                         ),
//                                       ),
//                                     ],
//                                   ),
//                                   Row(
//                                     mainAxisAlignment:
//                                         MainAxisAlignment.spaceBetween,
//                                     children: <Widget>[
//                                       Text(
//                                         bookingid['Item3'],
//                                         style: TextStyle(
//                                           fontFamily: 'Lato',
//                                           fontSize: 16.0,
//                                           fontWeight: FontWeight.bold,
//                                         ),
//                                       ),
//                                       SizedBox(
//                                         width: 30,
//                                       ),
//                                       Text(
//                                         bookingid['Item4'],
//                                         style: TextStyle(
//                                           fontFamily: 'Lato',
//                                           fontSize: 16.0,
//                                           fontWeight: FontWeight.bold,
//                                         ),
//                                       ),
//                                     ],
//                                   ),
//                                   Row(
//                                     mainAxisAlignment:
//                                         MainAxisAlignment.spaceBetween,
//                                     children: <Widget>[
//                                       Text(
//                                         '${bookingid['Roti Quantity']} Roti',
//                                         style: TextStyle(
//                                           fontFamily: 'Lato',
//                                           fontSize: 16.0,
//                                           fontWeight: FontWeight.bold,
//                                         ),
//                                       ),
//                                       Text(
//                                         bookingid['Rice Type'],
//                                         style: TextStyle(
//                                           fontFamily: 'Lato',
//                                           fontSize: 16.0,
//                                           fontWeight: FontWeight.bold,
//                                         ),
//                                       ),
//                                     ],
//                                   ),
//                                   Text(
//                                     bookingid['Desert'],
//                                     style: TextStyle(
//                                       fontFamily: 'Lato',
//                                       fontSize: 16.0,
//                                       fontWeight: FontWeight.bold,
//                                     ),
//                                   ),
//                                 ],
//                               ),
//                             ),
//                           ),
//                           Container(
//                             height: 80.0,
//                             width: 80.0,
//                             decoration: BoxDecoration(
//                               borderRadius: BorderRadius.circular(20.0),
//                               image: DecorationImage(
//                                 fit: BoxFit.cover,
//                                 image: bookingid['url'] == null
//                                     ? NetworkImage(
//                                         'https://cdn.pixabay.com/photo/2016/12/26/17/28/food-1932466__340.jpg',
//                                       )
//                                     : NetworkImage(bookingid['url']),
//                               ),
//                             ),
//                           ),
//                         ],
//                       ),
//                     ],
//                   ),
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
