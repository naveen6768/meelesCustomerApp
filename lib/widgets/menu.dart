import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class MenuWidget extends StatelessWidget {
  String getday;
  String mess_email;
  var currentuser = FirebaseAuth.instance.currentUser;
  MenuWidget({
    this.getday,
    this.mess_email,
  });
  var instant = FirebaseFirestore.instance.collection('Mess');

  @override
  Widget build(BuildContext context) {
    final heightOne = MediaQuery.of(context).size.height;

    Future<void> _placedorder(String type) async {
      var docref = await instant
          .doc(mess_email)
          .collection('Other Details')
          .doc('Booking')
          .collection(DateFormat.yMMMMEEEEd().format(DateTime.now()))
          .add({
            'Name': 'Parveen',
            'Phone No': '1234567890',
            'Photo':
                'https://png.pngtree.com/png-vector/20190827/ourlarge/pngtree-avatar-png-image_1700114.jpg',
            'Type': type,
            'Food Taken': false,
            'Payment Mode': 'Cash'
          })
          .then((value) => value.id)
          .catchError((error) {
            var message = "An Error occured, Please Check your Credentials";
            if (error.message != null) message = error.message;
            Scaffold.of(context).showSnackBar(
              SnackBar(
                content: Text(message),
                backgroundColor: Theme.of(context).errorColor,
              ),
            );
          });
      print(docref);
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
                                image: NetworkImage(
                                  'https://cdn.pixabay.com/photo/2016/12/26/17/28/food-1932466__340.jpg',
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      FlatButton(
                        minWidth: double.infinity,
                        onPressed: () {
                          _placedorder(document.data()['type']);
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
