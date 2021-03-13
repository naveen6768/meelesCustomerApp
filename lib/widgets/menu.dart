import 'package:Meeles/providers/messDetailsData.dart';
import 'package:Meeles/screens/bookingdetails_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

enum Mode { cash, wallet }

class MenuWidget extends StatefulWidget {
  String getday;
  String mess_email, dinner_end, lunch_end;
  bool isopen;

  @override
  _MenuWidgetState createState() => _MenuWidgetState();
}

class _MenuWidgetState extends State<MenuWidget> {
  Mode mode = Mode.cash;
  var currentuser = FirebaseAuth.instance.currentUser;

  var instant = FirebaseFirestore.instance.collection('Mess');

  String today = DateFormat('EEEEE', 'en_US').format(DateTime.now());

  @override
  Widget build(BuildContext context) {
    widget.mess_email = Provider.of<MessDetailsData>(context).messemail ;
    widget.lunch_end = Provider.of<MessDetailsData>(context).lunchtime ;
    widget.dinner_end = Provider.of<MessDetailsData>(context).dinnertime ;
    widget.isopen = Provider.of<MessDetailsData>(context).isopen ;
    widget.getday = Provider.of<MessDetailsData>(context).day;
    bool isallowed;
    var meelend, prebooking, payment_mode = 'Cash';
    double dif2, dif, doublemeelend, prebookTime, din_dif2, din_dif;
    var nowTime = TimeOfDay.now();
    double doublenowTime =
        nowTime.hour.toDouble() + nowTime.minute.toDouble() / 60;

    Future<void> _showMyDialog() async {
      return showDialog<void>(
        context: context,
        barrierDismissible: false, // user must tap button!
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Mode Of Payment'),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                ListTile(
                  title: const Text('Cash'),
                  leading: Radio(
                    value: Mode.cash,
                    groupValue: mode,
                    onChanged: (Mode value) {
                      print(value);
                      setState(() {
                        mode = value;
                      });
                      payment_mode = 'Wallet';
                    },
                  ),
                ),
                ListTile(
                  title: const Text('Wallet'),
                  leading: Radio(
                    value: Mode.wallet,
                    groupValue: mode,
                    onChanged: (Mode value) {
                      print(value);
                      setState(() {
                        mode = value;
                      });
                      payment_mode = 'Cash';
                    },
                  ),
                ),
              ],
            ),
            actions: <Widget>[
              FlatButton(
                child: Text('Select'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        },
      );
    }

    Future<void> _placedorder(data) async {
      String cat;
      if (data['type'] == 'Lunch') {
        if (dif2 > 0 && dif < 0)
          cat = '${data['type']} Instant';
        else
          cat = data['type'];
      } else {
        if (din_dif2 > 0 && din_dif < 0)
          cat = '${data['type']} Instant';
        else
          cat = data['type'];
      }

      //await _showMyDialog();
      var docref = await Provider.of<MessDetailsData>(context, listen: false)
          .placedorder(data, cat, 'Wallet');
      print(docref);
      Navigator.of(context).pushNamed(BookRecipt.id, arguments: docref);
    }
    print(widget.mess_email);
    print(widget.lunch_end);

    return SingleChildScrollView(
          child: Container(
        height: 450,
        child: StreamBuilder<QuerySnapshot>(
          stream: instant
              .doc(widget.mess_email)
              .collection('Other Details')
              .doc('Menu')
              .collection(widget.getday)
              .snapshots(includeMetadataChanges: true),
          builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> menushot) {
            if (menushot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            }
            if (menushot.data.docs.isEmpty) return Text('Aaj Kuch nhi Banraha');
            return ListView(
              shrinkWrap: true,
              physics: ScrollPhysics(),
              children: menushot.data.docs.map((QueryDocumentSnapshot document) {
                print(document.data());
                if (document.data()['type'] == 'Lunch') {
                  meelend = TimeOfDay(
                      hour: int.parse(widget.lunch_end.split(":")[0]),
                      minute: int.parse(
                          widget.lunch_end.split(":")[1].split(" ")[0]));
                } else {
                  meelend = TimeOfDay(
                      hour: int.parse(widget.dinner_end.split(":")[0]),
                      minute: int.parse(
                          widget.dinner_end.split(":")[1].split(" ")[0]));
                }
                prebooking = TimeOfDay(
                    hour:
                        int.parse(document.data()['Prebook Time'].split(":")[0]),
                    minute: int.parse(document
                        .data()['Prebook Time']
                        .split(":")[1]
                        .split(" ")[0]));
                doublemeelend =
                    meelend.hour.toDouble() + meelend.minute.toDouble() / 60;
                prebookTime = prebooking.hour.toDouble() +
                    prebooking.minute.toDouble() / 60;

                if (document.data()['Prebook Time'].split(" ")[1] == 'PM')
                  dif2 = doublenowTime - prebookTime - 12;
                else
                  dif2 = doublenowTime - prebookTime;
                dif = doublenowTime - doublemeelend - 12;

                if (document.data()['type'] == 'Dinner') {
                  din_dif = dif;
                  din_dif2 = dif2;
                }
                if (widget.isopen) {
                  if (dif < 0) {
                    isallowed = true;
                  } else
                    isallowed = false;
                } else if (dif2 < 0)
                  isallowed = true;
                else if (dif < 0)
                  isallowed = true;
                else
                  isallowed = false;

                return new Container(
                  margin: EdgeInsets.fromLTRB(16, 32, 16, 0),
                  padding: EdgeInsets.fromLTRB(20.0, 20.0, 20.0, 10.0),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20.0),
                    color: Colors.grey[200],
                  ),
                  child: Container(
                    padding: EdgeInsets.fromLTRB(8.0, 8.0, 8.0, 0.0),
                    height: 181,
                    child: Column(
                      children: <Widget>[
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Text(
                              document.data()['type'],
                              style: TextStyle(
                                fontFamily: 'Lato',
                                fontSize: 20.0,
                                fontWeight: FontWeight.w900,
                              ),
                            ),
                            Text(
                              'Price:  ${document.data()['Price']}',
                              style: TextStyle(
                                color: Colors.green,
                                fontFamily: 'Lato',
                                fontWeight: FontWeight.w900,
                                fontSize: 18.0,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Expanded(
                              child: Container(
                                margin: EdgeInsets.all(10),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: <Widget>[
                                        Text(
                                          document.data()['Item1'],
                                          style: TextStyle(
                                            fontFamily: 'Lato',
                                            fontSize: 16.0,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        SizedBox(
                                          width: 30,
                                        ),
                                        Text(
                                          document.data()['Item2'],
                                          style: TextStyle(
                                            fontFamily: 'Lato',
                                            fontSize: 16.0,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ],
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: <Widget>[
                                        Text(
                                          document.data()['Item3'],
                                          style: TextStyle(
                                            fontFamily: 'Lato',
                                            fontSize: 16.0,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        SizedBox(
                                          width: 30,
                                        ),
                                        Text(
                                          document.data()['Item4'],
                                          style: TextStyle(
                                            fontFamily: 'Lato',
                                            fontSize: 16.0,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ],
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: <Widget>[
                                        Text(
                                          '${document.data()['Roti Quantity']} Roti',
                                          style: TextStyle(
                                            fontFamily: 'Lato',
                                            fontSize: 16.0,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        Text(
                                          document.data()['Rice Type'],
                                          style: TextStyle(
                                            fontFamily: 'Lato',
                                            fontSize: 16.0,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ],
                                    ),
                                    Text(
                                      document.data()['Desert'],
                                      style: TextStyle(
                                        fontFamily: 'Lato',
                                        fontSize: 16.0,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Container(
                              height: 80.0,
                              width: 80.0,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20.0),
                                image: DecorationImage(
                                  fit: BoxFit.cover,
                                  image: document.data()['url'] == null
                                      ? NetworkImage(
                                          'https://cdn.pixabay.com/photo/2016/12/26/17/28/food-1932466__340.jpg',
                                        )
                                      : NetworkImage(document.data()['url']),
                                ),
                              ),
                            ),
                          ],
                        ),
                        if (today == widget.getday && isallowed)
                          StreamBuilder<DocumentSnapshot>(
                              stream: instant
                                  .doc(widget.mess_email)
                                  .collection('Booking')
                                  .doc(DateFormat.yMMMMEEEEd()
                                      .format(DateTime.now()))
                                  .snapshots(),
                              builder: (BuildContext context,
                                  AsyncSnapshot<DocumentSnapshot> snapshot) {
                                if (snapshot.connectionState ==
                                    ConnectionState.waiting) {
                                  return FlatButton(
                                    minWidth: double.infinity,
                                    onPressed: () {},
                                    child: Text(
                                      'Loading Status',
                                      style: TextStyle(
                                        color: Colors.red,
                                        fontFamily: 'Lato',
                                        fontWeight: FontWeight.w900,
                                      ),
                                    ),
                                  );
                                }
                                Map<String, dynamic> data = snapshot.data.data();
                                if (data == null ||
                                    data['${document.data()['type']}'] == 999) {
                                  return Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: <Widget>[
                                      FlatButton(
                                        onPressed: () {
                                          _placedorder(document.data());
                                        },
                                        child: Text(
                                          'Book Now',
                                          style: TextStyle(
                                            color: Colors.green,
                                            fontFamily: 'Lato',
                                            fontWeight: FontWeight.w900,
                                          ),
                                        ),
                                      ),
                                      Text(
                                        'Seats Available',
                                        style: TextStyle(
                                          fontFamily: 'Lato',
                                          fontSize: 16.0,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ],
                                  );
                                } else {
                                  if (dif2 < 0) {
                                    if (data[document.data()['type']] == 0)
                                      return FlatButton(
                                        minWidth: double.infinity,
                                        onPressed: () {},
                                        child: Text(
                                          'Seats Full',
                                          style: TextStyle(
                                            color: Colors.red,
                                            fontFamily: 'Lato',
                                            fontWeight: FontWeight.w900,
                                          ),
                                        ),
                                      );
                                    else
                                      return Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                        children: <Widget>[
                                          FlatButton(
                                            onPressed: () {
                                              _placedorder(document.data());
                                            },
                                            child: Text(
                                              'Book Now',
                                              style: TextStyle(
                                                color: Colors.green,
                                                fontFamily: 'Lato',
                                                fontWeight: FontWeight.w900,
                                              ),
                                            ),
                                          ),
                                          Text(
                                            'Seats left: ${data[document.data()['type']]}',
                                            style: TextStyle(
                                              fontFamily: 'Lato',
                                              fontSize: 16.0,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ],
                                      );
                                  } else if (data[
                                          '${document.data()['type']} Instant'] ==
                                      0)
                                    return FlatButton(
                                      minWidth: double.infinity,
                                      onPressed: () {},
                                      child: Text(
                                        'Seats Full',
                                        style: TextStyle(
                                          color: Colors.red,
                                          fontFamily: 'Lato',
                                          fontWeight: FontWeight.w900,
                                        ),
                                      ),
                                    );
                                  else
                                    return Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      children: <Widget>[
                                        FlatButton(
                                          onPressed: () {
                                            _placedorder(document.data());
                                          },
                                          child: Text(
                                            'Book Now',
                                            style: TextStyle(
                                              color: Colors.green,
                                              fontFamily: 'Lato',
                                              fontWeight: FontWeight.w900,
                                            ),
                                          ),
                                        ),
                                        Text(
                                          'Seats left: ${data['${document.data()['type']} Instant']}',
                                          style: TextStyle(
                                            fontFamily: 'Lato',
                                            fontSize: 16.0,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ],
                                    );
                                }
                              })
                        else if (today == widget.getday)
                          FlatButton(
                            minWidth: double.infinity,
                            onPressed: () {},
                            child: Text(
                              'Time Over',
                              style: TextStyle(
                                color: Colors.red,
                                fontFamily: 'Lato',
                                fontWeight: FontWeight.w900,
                              ),
                            ),
                          ),
                      ],
                    ),
                  ),
                );
              }).toList(),
            );
          },
        ),
      ),
    );
  }
}
