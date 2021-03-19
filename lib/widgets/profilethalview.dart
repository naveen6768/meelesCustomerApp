import 'package:Meeles/components/globalvariables.dart';
import 'package:Meeles/providers/messDetailsData.dart';
import 'package:Meeles/widgets/menu.dart';
import 'package:Meeles/widgets/reviewmess.dart';
import 'package:Meeles/widgets/tilemenu.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class ThaliView extends StatefulWidget {
  String getday;
  String mess_email;
  @override
  _ThaliViewState createState() => _ThaliViewState();
}

class _ThaliViewState extends State<ThaliView> {
    List<String> day = [
    'Sunday',
    'Monday',
    'Tuesday',
    'Wednesday',
    'Thursday',
    'Friday',
    'Saturday',
  ];
  String selectedDay =
      (DateFormat('EEEEE', 'en_US').format(DateTime.now())).toString();
  final ScrollController _scrollController = ScrollController();

  final double itemExtent = 90;
  void _animateScroll(int index) {
    double offset = index < 0 ? 0 : index * itemExtent;
    if (offset > _scrollController.position.maxScrollExtent) {
      offset = _scrollController.position.maxScrollExtent;
    }
    _scrollController.animateTo(offset,
        duration: Duration(milliseconds: 500), curve: Curves.easeIn);
  }

  @override
  Widget build(BuildContext context) {
    widget.mess_email = Provider.of<MessDetailsData>(context).messphone ;
    print(widget.mess_email);
    return ListView(
    shrinkWrap: true,
    physics: NeverScrollableScrollPhysics(),
    children:[
      Container(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: SizedBox(
        height: 33.0,
        child: ListView.builder(
          controller: _scrollController,
          scrollDirection: Axis.horizontal,
          itemCount: 7,
          itemBuilder: (BuildContext ctx, int index) {
            return Padding(
              padding: const EdgeInsets.only(right: 8.0),
              child: GestureDetector(
                onTap: () {
                  setState(() {
                    selectedDay = day[index];
                  });
                  _animateScroll(index);
                },
                child: Container(
                  decoration: BoxDecoration(
                    color: selectedDay == day[index]
                        ? Theme.of(context).primaryColor
                        : Colors.white,
                    borderRadius: BorderRadius.circular(15),
                    // border: Border.all(
                    //   color: Theme.of(context).primaryColor,
                    // ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      vertical: 8.0,
                      horizontal: 8.0,
                    ),
                    child: Text(
                      (day[index]).substring(0, 3),
                      style: TextStyle(
                        fontSize: 14.0,
                        fontWeight: FontWeight.w800,
                        color: selectedDay == day[index]
                            ? Colors.white
                            : Theme.of(context).primaryColor,
                      ),
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    ),
    widget.mess_email != null ?
    StreamBuilder<QuerySnapshot>(
      stream: obj.collection('Mess').doc(widget.mess_email).collection('Other Details').doc('Menu').collection(selectedDay).snapshots(),
      builder: (BuildContext ctx, AsyncSnapshot snapshot){
        if(snapshot.hasError)
        return Text('An Error Occured ! Retry');

        if(snapshot.connectionState == ConnectionState.waiting)
        return LinearProgressIndicator();

        return new ListView( 
          controller: _scrollController,
          shrinkWrap: true,
          children : 
          snapshot.data.docs.map<Widget>((DocumentSnapshot document){
            
           return TileMenu(document.data());
        }).toList(),
        );
      },
    ) : Container(),
    ],
    );
  }
}