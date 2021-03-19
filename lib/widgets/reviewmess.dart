import 'package:Meeles/components/globalvariables.dart';
import 'package:Meeles/providers/messDetailsData.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class ReviewPage extends StatelessWidget {
  String selfemail = FirebaseAuth.instance.currentUser.phoneNumber;
  var selfrating = {'Rating': 1.0, 'Review' : ''};
  double sr = 0;
  int no_of_ratings = 0,nor;
  double newRating;
  String newReview;
  final _key = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    String mess_email = Provider.of<MessDetailsData>(context).messphone;
  var ref = obj.collection('Mess').doc(mess_email).collection('Rating').doc(selfemail);
  
    Future<void> reviewbox()async {
      await showModalBottomSheet(
        isScrollControlled: true,
        context: context,
         builder: (context){
           return StatefulBuilder(builder: (context,setState){
             return SingleChildScrollView(
               child: Container(
                  margin: EdgeInsets.all(10),
                  padding: EdgeInsets.all(10),
                  child: Form(
                    key: _key,
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text(
                              selfrating['Rating'] != 0 ? 'Give Your Review' : 'Edit your Review',
                              style: Theme.of(context)
                                  .textTheme
                                  .headline1
                                  .copyWith(
                                    fontSize: 18.0,
                                    fontWeight: FontWeight.w600,
                                    color: Theme.of(context).primaryColor,
                                    fontFamily: 'Lato',
                                  ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 36,
                        ),
                        RatingBar.builder(
   initialRating: selfrating['Rating'],
   minRating: 1,
   direction: Axis.horizontal,
   allowHalfRating: true,
   itemCount: 5,
   itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
   itemBuilder: (context, _) => Icon(
     Icons.star,
     color: Theme.of(context).primaryColor,
   ),
   onRatingUpdate: (rating) {
    newRating = rating;
    sr = selfrating['Rating'];
    nor = no_of_ratings;
  print('1 $newRating');
  print('2 ${selfrating['Rating']}');
  print('3 $sr');
   },
),
SizedBox(height:24),
                        TextFormField(
                          initialValue: selfrating['Review'],
                          textCapitalization: TextCapitalization.sentences,
                          maxLines: 5,
                          decoration: InputDecoration(
                            labelText: 'Your Review',
                            fillColor: Theme.of(context).accentColor,
                            filled: true,

                            // hintText: 'email',
                            contentPadding: EdgeInsets.symmetric(
                                vertical: 10.0, horizontal: 20.0),
                            border: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10.0)),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: Colors.white30, width: 1.0),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10.0)),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: Colors.black45, width: 2.0),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10.0)),
                            ),
                          ),
                          onSaved: (text){
                            newReview = text;
                          },
                          //controller: title,
                        ),
                        SizedBox(height:12),
                        Container(
                          width: double.infinity,
                          child: RaisedButton(
                            //style: ButtonStyle(minimumSize: MaterialStateBorderSide.,),
                            child: Text('Submit'),
                            shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(30)),
                              elevation: 5,
                              textColor: Colors.white,
                              color: Colors.blue,
                            onPressed: () async{
                              if (_key.currentState.validate()) {
                               _key.currentState.save();
                              await ref.set({
                                'Name': '${selfemail.substring(0,7)}*******',
                                'Phone No': selfemail,
                                'Rating': newRating,
                                'Review': newReview,
                                'Date' : Timestamp.fromDate(DateTime.now()),
                               }).whenComplete(()async{
                                //  obj.runTransaction((transaction) async {
                                //  DocumentSnapshot snapshot = await transaction.get(ref.parent.parent);
                                // if(nor == 0|| (sr!=0 && nor == 1))
                                //   nor = nor +1;
                                //  double newMessRating;
                                //   // print(' old rating ${selfrating['Rating']}');
                                //   // print('Sr value $sr');
                                //   // print(' new ratin $newRating');
                                //   print('No of rating $nor');
                                //  if(sr !=0)
                                //  newMessRating = (snapshot.data()['Rating'] * nor + newRating - sr)/nor;
                                //  else
                                //  newMessRating = (snapshot.data()['Rating'] * nor + newRating)/(nor+1);
                                //  print('updated $newMessRating');
                                //  transaction.update(ref.parent.parent, {'Rating': num.parse(newMessRating.toStringAsFixed(2))});
                                 Navigator.of(context).pop();
            
                               //});
                               });
                                
                              }
                            },
                          ),
                        ),],
                    ),
                    ),
               ),);
           });
         }
         );
    }
    return Container(
      //margin: EdgeInsets.symmetric(horizontal: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Text('Customer Review', style: TextStyle(fontSize: 14,fontFamily: 'Lato',fontWeight: FontWeight.bold),),
              TextButton(onPressed: ()async{
                await reviewbox();
              }, child: Text('Post your Review'),),
            ],
          ),
          SizedBox(height:12),
          StreamBuilder(
            stream: obj.collection('Mess').doc(mess_email).collection('Rating').orderBy('Date', descending: true).snapshots(),
            builder: (BuildContext ctx, AsyncSnapshot snapshot){
              if(snapshot.hasError)
                return Text('Some Error Occur, Try Again Later');
              if(snapshot.connectionState == ConnectionState.waiting) return Center(child: CircularProgressIndicator());
              if(snapshot.data.docs.isEmpty) return Center(child: Text('Be the first to review this ServiceProvider', style: TextStyle(color: Colors.grey, fontFamily: 'Lato', fontSize: 14),),);
              no_of_ratings =snapshot.data.docs.length;
          
              return ListView(
                shrinkWrap: true,
                children: snapshot.data.docs.map<Widget>((DocumentSnapshot document){
                  if(document.id == selfemail){
                    selfrating['Rating'] = document.data()['Rating'];
                    selfrating['Review'] = document.data()['Review'];
                     print('Got rating ${document.data()['Rating']}');
                  }
                 
                  return ListTile(
                    minVerticalPadding: 0,
                    //leading: FadeInImage(placeholder: AssetImage('images/meeles_icon.png'), image: NetworkImage(document.data()['url'])),
                    title: Text('${document.data()['Name']}', style: TextStyle(fontFamily: 'Lato',fontSize: 14, fontWeight: FontWeight.bold),),
                    subtitle: Text('${document.data()['Review']}', style: TextStyle(fontFamily: 'Lato',fontSize: 12, color: Colors.grey),),
                    trailing: Text('${document.data()['Rating']}/5', style: TextStyle(fontFamily: 'Lato',fontSize: 16, fontWeight: FontWeight.bold),),
                  );
                }).toList(),);
            },),
        ],
      ),
    );
  }
}