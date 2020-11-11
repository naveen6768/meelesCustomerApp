import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../screens/messOverviewScreen.dart';
import 'package:provider/provider.dart';
import '../providers/messDetailsData.dart';

class MessTile extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    String show = Provider.of<MessDetailsData>(context).showshop;
    String landmark = Provider.of<MessDetailsData>(context).landarea;
    var users;
    if (show != 'Both')
      users = FirebaseFirestore.instance
          .collection('Mess')
          .where('Landmark', isEqualTo: landmark)
          .where('Service Type', isEqualTo: show);
    else
      users = FirebaseFirestore.instance
          .collection('Mess')
          .where('Landmark', isEqualTo: landmark);
    return StreamBuilder<QuerySnapshot>(
        stream: users.snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError) {
            return AlertDialog(
              title: Text('An Error Occured'),
              content: Text('Something went Wrong'),
              actions: <Widget>[
                FlatButton(
                  child: Text('Okay'),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                )
              ],
            );
          }
          if (snapshot.connectionState == ConnectionState.waiting) {
            return CircularProgressIndicator(
              semanticsLabel: "Sabr Karo",
            );
          }

          return new ListView(
            children: snapshot.data.docs.map((DocumentSnapshot document) {
              return Container(
                height: 90.0,
                child: Card(
                  margin: EdgeInsets.symmetric(
                    vertical: 8.0,
                    horizontal: 15.0,
                  ),
                  elevation: 6.0,
                  child: ListTile(
                    onTap: () {
                      Navigator.of(context).pushNamed(MessOverviewScreen.id,
                          arguments: document.data());
                      Provider.of<MessDetailsData>(context, listen: false)
                          .getmess(document.data());
                    },
                    contentPadding: EdgeInsets.fromLTRB(16.0, 0.0, 16.0, 16.0),
                    leading: Container(
                      height: 50.0,
                      width: 50.0,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          fit: BoxFit.cover,
                          image: document.data()['url'] == null
                              ? NetworkImage(
                                  'https://assets.change.org/photos/5/qv/fq/NCQvFQlTqDIeZlW-1600x900-noPad.jpg?1485459994')
                              : NetworkImage(document.data()['url']),
                        ),
                      ),
                    ),
                    title: Text(
                      document.data()['Shop Name'],
                    ),
                    subtitle: Text(document.data()['Address']),
                    trailing: Container(
                      decoration: BoxDecoration(
                        color: Color(0xff27AE60),
                        borderRadius: BorderRadius.circular(5),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          '${document.data()['Rating']}',
                          style: TextStyle(
                            fontWeight: FontWeight.w800,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              );
            }).toList(),
          );
        });
  }
}
