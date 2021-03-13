import 'package:Meeles/components/globalvariables.dart';
import 'package:Meeles/providers/messDetailsData.dart';
import 'package:Meeles/widgets/tabbarmesspage.dart';
import 'package:flutter/material.dart';
import 'package:dotted_line/dotted_line.dart';
import 'package:maps_launcher/maps_launcher.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';


class ArgsMess extends StatefulWidget {
  var data;

  ArgsMess(this.data);

  @override
  _ArgsMessState createState() => _ArgsMessState();
}

class _ArgsMessState extends State<ArgsMess>  {

  @override
  Widget build(BuildContext context) {
    Provider.of<MessDetailsData>(context,listen: false).setmessvalue(widget.data['Email'], widget.data['Lunch End'] , widget.data['Dinner End'], widget.data['Open Whole Day']);
    return SafeArea(
          child: SingleChildScrollView(
            child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
          IconButton(icon: Icon(Icons.arrow_back,color: Colors.black),onPressed: (){ Navigator.of(context).pop(); messdata = null; Provider.of<MessDetailsData>(context,listen:false).setmessvalue(null, null, null, null);},),
          Expanded(child: Container(),),
          IconButton(icon: Icon(Icons.call,color: Colors.black,), onPressed: ()async{
            await launch('tel:+91${widget.data['Phone no.']}');
          },),
          TextButton(onPressed: (){
            if(widget.data['coordinates'] != null)
            MapsLauncher.launchCoordinates(widget.data['coordinates'].latitude, widget.data['coordinates'].longitude);
          },
           child: Text('Direction', style: TextStyle(color: Colors.black, fontFamily: 'Lato',fontWeight: FontWeight.bold,fontSize: 14),))
        ],),
        SizedBox(height: 3,),
        Container(
          margin: EdgeInsets.all(5),
          padding: EdgeInsets.all(5),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('${widget.data['Shop Name']}', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w900, fontFamily: 'Lato'),),
                  Container(
            padding: EdgeInsets.all(5),
             color: Theme.of(context).primaryColor,
             child: Text('⭐${widget.data['Rating']} ', style: TextStyle(fontSize: 14, fontFamily: 'Lato',fontWeight: FontWeight.bold,color: Colors.white),),
             ),
                ],
              ),
              SizedBox(height:8),
              Text('FSSAI No: ${widget.data['FSSAI NO']}', style: TextStyle(fontSize: 14, fontFamily: 'Lato',color: Colors.grey),),
              SizedBox(height:2),
              Text('${widget.data['Address']}. ', style: TextStyle(fontSize: 14, fontFamily: 'Lato',color: Colors.grey),),
              SizedBox(height: 20),
              DottedLine(
  direction: Axis.horizontal,
  lineLength: double.infinity,
  lineThickness: 1.0,
  dashLength: 2.0,
  dashColor: Colors.black,
  dashRadius: 0.0,
  dashGapLength: 2.0,
  dashGapColor: Colors.transparent,
  dashGapRadius: 0.0,
),
SizedBox(height:4),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Column(
                  children: [
                    Text('Lunch', style: TextStyle(fontSize: 14, fontFamily: 'Lato',color: Colors.grey),),
                    Text('${widget.data['Lunch Begining']} - ${widget.data['Lunch End']}', style: TextStyle(fontSize: 14, fontFamily: 'Lato',color: Colors.black45),),
                  ],
                ),
                Column(
                  children: [
                    Text('Dinner', style: TextStyle(fontSize: 14, fontFamily: 'Lato',color: Colors.grey),),
                    Text('${widget.data['Dinner Starting']} - ${widget.data['Dinner End']}', style: TextStyle(fontSize: 14, fontFamily: 'Lato',color: Colors.black45),),
                  ],
                ),
            ],),
            SizedBox(height:4),
            DottedLine(
  direction: Axis.horizontal,
  lineLength: double.infinity,
  lineThickness: 1.0,
  dashLength: 2.0,
  dashColor: Colors.black,
  dashRadius: 0.0,
  dashGapLength: 2.0,
  dashGapColor: Colors.transparent,
  dashGapRadius: 0.0,
),
            ],
          ),
          ),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(children: [
              for(int i = 0; i<4; i++)
                  if(widget.data['note${i}'] != null)
                    Container(
                      width: (MediaQuery.of(context).size.width) * 0.5,
                      margin: EdgeInsets.all(5),
                      padding: EdgeInsets.all(10),
                      height: 55,
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey[600]),
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.white,
                      ),
                      child: Text('${widget.data['note${i}']}',style: TextStyle(fontFamily: 'Lato',color: Colors.grey[600],fontSize: 14),),
                    ),
              
            ],),
          ),
          SizedBox(height: 12),
          TabbarMessProfile(),
            ]
          ),
      ),
    );
  }
}