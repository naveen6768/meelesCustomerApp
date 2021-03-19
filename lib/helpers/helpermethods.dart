import 'package:Meeles/components/globalvariables.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
class HelperMethods{

  Future data()async{
    await  FirebaseFirestore.instance
        .collectionGroup('Sunday')
        .where('Food_Type', isEqualTo : 'Veg')
        .get()
        .then((QuerySnapshot querySnapshot) {
      querySnapshot.docs.forEach((doc) async {
        print(doc.id);
       await doc.reference.parent.parent.get().then((DocumentSnapshot documentSnapshot) {
      if (documentSnapshot.exists) {
        print(documentSnapshot['Menu']);
      }
    });
        print(doc.reference);
        print(doc["Item1"]);
      });
    });
  }

  String type(){
    DateTime time = DateTime.now();
	if( time.hour > 0 && time.hour < 17)
		return 'Lunch';
    else return 'Dinner';
	
  }

  Future<List> messprofiles(landmark)async{
    //print(homeMesslist);
      if(homeMesslist == null)
       homeMesslist =  await obj
						  				.collection('Mess')
						  				.where('Landmark', isEqualTo: landmark)
						  				.orderBy('Rating', descending: true)
						  				.get().then((value) => value.docs);

        //print(homeMesslist[0].data());
        //print(homeMesslist[1]['Shop Name']);
        homeMesslist.shuffle();
        return homeMesslist;
      
  }

  Future<List> thalilist(day,landmark)async{
    //print(homeMesslist);
      if(dayThaliList == null)
       dayThaliList =  await obj
						  				.collectionGroup(day)
						  				.where('Area', isEqualTo: landmark)
						  				.get().then((value) => value.docs);

        dayThaliList.shuffle();
        return dayThaliList;
      
  }

  Future getmess(ref)async{
      if(messdata == null){
        messdata = await ref.get().then((DocumentSnapshot doc){return doc;});
        //print(messdata.data());
      }
      return messdata;
  }
}