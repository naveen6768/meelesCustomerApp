import 'package:Meeles/providers/messDetailsData.dart';
import 'package:Meeles/screens/bookingdetails_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class MenuWidget extends StatelessWidget {
  String getday;
  String mess_email, dinner_end, lunch_end;
  bool isopen;
  var currentuser = FirebaseAuth.instance.currentUser;
  MenuWidget({
    this.getday,
    this.mess_email,
    this.dinner_end,
    this.lunch_end,
    this.isopen,
  });
  var instant = FirebaseFirestore.instance.collection('Mess');
  String today = DateFormat('EEEEE', 'en_US').format(DateTime.now());
  @override
  Widget build(BuildContext context) {
    bool isallowed;
    var meelend, prebooking;
    int bookings;
    double dif2, dif, doublemeelend, prebookTime;
    var nowTime = TimeOfDay.now();
    double doublenowTime =
        nowTime.hour.toDouble() + nowTime.minute.toDouble() / 60;

    Future<void> _placedorder(data) async {
      var docref = await Provider.of<MessDetailsData>(context, listen: false)
          .placedorder(data);
      print(docref);
      Navigator.of(context).pushNamed(BookRecipt.id, arguments: docref);
    }

    getbookings(type) async {
      bookings = await instant
          .doc(mess_email)
          .collection('Other Details')
          .doc('Booking')
          .collection(DateFormat.yMMMMEEEEd().format(DateTime.now()))
          .where('Type', isEqualTo: type)
          .get()
          .then((value) {
        return value.size;
      });
    }

    return Container(
      height: 450,
      child: StreamBuilder<QuerySnapshot>(
        stream: instant
            .doc(mess_email)
            .collection('Other Details')
            .doc('Menu')
            .collection(getday)
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
              if (document.data()['type'] == 'Lunch') {
                meelend = TimeOfDay(
                    hour: int.parse(lunch_end.split(":")[0]),
                    minute: int.parse(lunch_end.split(":")[1].split(" ")[0]));
                getbookings('Lunch');
              } else {
                meelend = TimeOfDay(
                    hour: int.parse(dinner_end.split(":")[0]),
                    minute: int.parse(dinner_end.split(":")[1].split(" ")[0]));
                getbookings('Dinner');
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
              print(
                  "$lunch_end $dinner_end ${document.data()['Prebook Time']}");
              print(TimeOfDay.now());
              if (isopen) {
                if (dif < 0) {
                  isallowed = true;
                } else
                  isallowed = false;
              } else if (dif2 < 0 && document.data()['Seats'] > bookings)
                isallowed = true;
              else if (dif2 < 0 && document.data()['Instant'] != 0)
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
                      if (today == getday && isallowed)
                        FlatButton(
                          minWidth: double.infinity,
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
                    ],
                  ),
                ),
              );
            }).toList(),
          );
        },
      ),
    );
  }
}
