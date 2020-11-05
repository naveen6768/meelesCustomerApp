import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';

class BookRecipt extends StatelessWidget {
  static const id = 'bookrecipt';
  var bookingid;
  BookRecipt({
    this.bookingid,
  });
  @override
  Widget build(BuildContext context) {
    bookingid = ModalRoute.of(context).settings.arguments;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Booking Details',
          style: TextStyle(
            fontFamily: 'Lato',
          ),
        ),
      ),
      body: Center(
        child: QrImage(
          data: bookingid,
          version: QrVersions.auto,
          size: 200.0,
        ),
      ),
    );
  }
}
