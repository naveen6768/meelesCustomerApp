import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class MenuWidget extends StatelessWidget {
  String getday;
  String mess_email;
  var currentuser = FirebaseAuth.instance.currentUser;
  CollectionReference daymenu;
  MenuWidget({
    this.getday,
    this.mess_email,
  });

  @override
  Widget build(BuildContext context) {
    final heightOne = MediaQuery.of(context).size.height;
    return Container(
      height: 450,
      child: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection('Mess')
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
              print(heightOne);
              return new Card(
                elevation: 8.0,
                child: Container(
                  padding: EdgeInsets.all(10.0),
                  height: heightOne * 0.16,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Center(
                        child: Chip(
                          label: Padding(
                            padding: const EdgeInsets.only(bottom: 4.0),
                            child: Text(
                              document.data()['type'],
                              style: TextStyle(
                                fontFamily: 'Lato',
                                fontSize: 22.0,
                              ),
                            ),
                          ),
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Container(
                            height: 50.0,
                            width: 100.0,
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
                          Expanded(
                            child: Container(
                              width: double.infinity,
                              padding: EdgeInsets.all(8.0),
                              child: Text(
                                  '${document.data()['Item1']}  ${document.data()['Item2']}  ${document.data()['Item3']}  ${document.data()['Item4']}  Roti\'s : ${document.data()['Roti Quantity']}  ${document.data()['Rice Type']}  ${document.data()['Desert']}'),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 5.0,
                      ),
                      RaisedButton(
                        onPressed: () {
                          // Navigator.of(context)
                          // .pushNamed(Updatemenu.routeName);
                        },
                        child: Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: Text(
                            'Update',
                            style: TextStyle(
                              fontFamily: 'Lato',
                              color: Colors.white,
                              fontWeight: FontWeight.w900,
                            ),
                          ),
                        ),
                        color: Theme.of(context).primaryColor,
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
