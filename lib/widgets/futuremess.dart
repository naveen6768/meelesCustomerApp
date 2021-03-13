import 'package:Meeles/widgets/argsmess.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class FutureMess extends StatelessWidget {
  var ref;
  FutureMess(this.ref);
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: ref.get(),
      builder: (BuildContext ctx, AsyncSnapshot snapshot){
        if(snapshot.hasError)
        return Text('Something went wrong, Please try again');
        if(snapshot.connectionState == ConnectionState.waiting)
        return LinearProgressIndicator(valueColor: new AlwaysStoppedAnimation(Theme.of(context).primaryColor));
        return ArgsMess(snapshot.data.data());
      }
      );
  }
}