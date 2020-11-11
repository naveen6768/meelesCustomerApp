import 'package:Meeles/widgets/menu.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'dart:core';
import 'package:intl/intl.dart';

class MessOverviewScreen extends StatefulWidget {
  static const id = 'MessOverviewScreen';

  @override
  _MessOverviewScreenState createState() => _MessOverviewScreenState();
}

class _MessOverviewScreenState extends State<MessOverviewScreen> {
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
    final Map<String, dynamic> trackIndex =
        ModalRoute.of(context).settings.arguments;
    return new Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          // startingTrack.elementAt(trackIndex).initialdata['shop_name'],
          trackIndex['Shop Name'],
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            SizedBox(
              height: 10.0,
            ),
            Card(
              color: Colors.blueAccent,
              elevation: 5.0,
              child: Container(
                padding: EdgeInsets.symmetric(
                  horizontal: 10.0,
                ),
                height: 110.0,
                // color: Theme.of(context).primaryColor,
                child: Row(
                  // mainAxisSize: MainAxisSize.min,
                  children: [
                    CircleAvatar(
                      radius: 35.0,
                      backgroundImage: trackIndex['url'] == null
                          ? NetworkImage(
                              'https://cdn.pixabay.com/photo/2016/12/26/17/28/food-1932466__340.jpg',
                            )
                          : NetworkImage(trackIndex['url']),
                    ),
                    SizedBox(
                      width: 20.0,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          trackIndex['Shop Name'],
                          style: TextStyle(
                            fontSize: 20.0,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                        SizedBox(height: 10.0),
                        Text(
                          trackIndex['Address'],
                          overflow: TextOverflow.ellipsis,
                          maxLines: 1,
                          softWrap: false,
                          style: TextStyle(
                            fontSize: 16.0,
                            fontWeight: FontWeight.w500,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(
              height: 10.0,
              width: double.infinity * 0.97,
              child: Divider(
                color: Colors.black54,
                // thickness: 0.9,
                // height: ,
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: SizedBox(
                height: 40.0,
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
                                ? Colors.green
                                : Colors.white,
                            borderRadius: BorderRadius.circular(8),
                            border: Border.all(
                              color: Theme.of(context).primaryColor,
                            ),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                              vertical: 8.0,
                              horizontal: 10.0,
                            ),
                            child: Text(
                              (day[index]).substring(0, 3),
                              style: TextStyle(
                                fontSize: 20.0,
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
            MenuWidget(
              getday: selectedDay,
              mess_email: trackIndex['Email'],
              dinner_end: trackIndex['Dinner End'],
              lunch_end: trackIndex['Lunch End'],
              isopen: trackIndex['Open Whole Day'],
            ),
          ],
        ),
      ),
    );
  }
}
