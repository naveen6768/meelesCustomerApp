import 'package:Meeles/components/globalvariables.dart';
import 'package:Meeles/widgets/argsmess.dart';
import 'package:Meeles/widgets/futuremess.dart';
import 'package:Meeles/widgets/profilethalview.dart';
import 'package:Meeles/widgets/reviewmess.dart';
import 'package:Meeles/widgets/tabbarmesspage.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';


class MessDetail extends StatefulWidget {
  static const routeName = '/messdetails';
  @override
  _MessDetailState createState() => _MessDetailState();
}

class _MessDetailState extends State<MessDetail> {
  var document;
  bool isload;
  
  @override
  Widget build(BuildContext context) {
    var args = ModalRoute.of(context).settings.arguments as Map;
    document = args['data'];
    isload = args['isload'];
    return Scaffold(
      //appBar: AppBar(),
      body: SafeArea(
        child:SingleChildScrollView(
                  physics: ScrollPhysics(),

          child: Container(
            margin: EdgeInsets.all(2),
            padding: EdgeInsets.all(2),
            child: Column(
              children: [
                isload ? FutureMess(document) : ArgsMess(document),
                SizedBox(height:12,
               // child: Divider(thickness: 20,color: Theme.of(context).accentColor,),
                ),
                
              ]
            ),
          ),
        ),
        ),
    );
  }
}