import 'package:flutter/material.dart';
import '../providers/messDetailsData.dart';

class MessOverviewScreen extends StatelessWidget {
  static const id = 'MessOverviewScreen';
  final List startingTrack = MessDetailsData().loadedMessDetails;
  @override
  Widget build(BuildContext context) {
    final int trackIndex = ModalRoute.of(context).settings.arguments;
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          startingTrack.elementAt(trackIndex).initialdata['shop_name'],
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(
              height: 10.0,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              child: Row(
                // mainAxisAlignment: MainAxisAlignment.spac,
                children: [
                  Text('Name:'),
                  SizedBox(
                    width: 7.0,
                  ),
                  Text(startingTrack
                      .elementAt(trackIndex)
                      .initialdata['shop_name'])
                ],
              ),
            ),
            SizedBox(
              height: 10.0,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              child: Row(
                children: [
                  Text('Location:'),
                  SizedBox(
                    width: 7.0,
                  ),
                  Text(startingTrack
                      .elementAt(trackIndex)
                      .initialdata['Landmark'])
                ],
              ),
            ),
            SizedBox(
              height: 10.0,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              child: Row(
                children: [
                  Text('Rating:'),
                  SizedBox(
                    width: 7.0,
                  ),
                  Text(
                    '4.2',
                    // style: TextStyle(fontSize: 20),
                  )
                ],
              ),
            ),
            // Row(children: [
            //   Text('Timings:'),Text('')
            // ],),
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
                      backgroundImage: NetworkImage(
                        'https://png.pngtree.com/png-vector/20190827/ourlarge/pngtree-avatar-png-image_1700114.jpg',
                      ),
                    ),
                    SizedBox(
                      width: 20.0,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          startingTrack
                              .elementAt(trackIndex)
                              .initialdata['shop_name'],
                          style: TextStyle(
                            fontSize: 20.0,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                        SizedBox(height: 10.0),
                        Text(
                          '8009726785',
                          style: TextStyle(
                            fontSize: 16.0,
                            fontWeight: FontWeight.w500,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    )
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
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  children: [
                    GestureDetector(
                      onTap: () {},
                      child: Container(
                        decoration: BoxDecoration(
                          color: Color(0xff27AE60),
                          borderRadius: BorderRadius.circular(18.0),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                            vertical: 8.0,
                            horizontal: 10.0,
                          ),
                          child: Text(
                            'Sun',
                            style: TextStyle(
                              fontSize: 20.0,
                              fontWeight: FontWeight.w800,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 8.0,
                    ),
                    FlatButton(
                      color: Color(0xff27AE60),
                      onPressed: () {},
                      child: Text('Mon'),
                    ),
                    FlatButton(
                      color: Color(0xff27AE60),
                      onPressed: () {},
                      child: Text('Tue'),
                    ),
                    FlatButton(
                      color: Color(0xff27AE60),
                      onPressed: () {},
                      child: Text('Wed'),
                    ),
                    FlatButton(
                      color: Color(0xff27AE60),
                      onPressed: () {},
                      child: Text('Thu'),
                    ),
                    FlatButton(
                      color: Color(0xff27AE60),
                      onPressed: () {},
                      child: Text('Fri'),
                    ),
                    FlatButton(
                      color: Color(0xff27AE60),
                      onPressed: () {},
                      child: Text('Sat'),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
