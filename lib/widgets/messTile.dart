import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/messDetailsData.dart';
import '../screens/messOverviewScreen.dart';

class MessTile extends StatelessWidget {
  final int trackIndex;
  MessTile({this.trackIndex});
  @override
  Widget build(BuildContext context) {
    Provider.of<MessDetailsData>(context);
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
            Navigator.of(context)
                .pushNamed(MessOverviewScreen.id, arguments: trackIndex);
          },
          contentPadding: EdgeInsets.fromLTRB(16.0, 0.0, 16.0, 16.0),
          leading: Container(
            height: 50.0,
            width: 50.0,
            decoration: BoxDecoration(
              image: DecorationImage(
                fit: BoxFit.cover,
                image: NetworkImage(
                    'https://assets.change.org/photos/5/qv/fq/NCQvFQlTqDIeZlW-1600x900-noPad.jpg?1485459994'),
              ),
            ),
          ),
          title: Text(
            MessDetailsData()
                .loadedMessDetails
                .elementAt(trackIndex)
                .initialdata['shop_name'],
          ),
          subtitle: Text(
            MessDetailsData()
                .loadedMessDetails
                .elementAt(trackIndex)
                .initialdata['Landmark'],
          ),
          trailing: Container(
            decoration: BoxDecoration(
              color: Color(0xff27AE60),
              borderRadius: BorderRadius.circular(5),
            ),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                '4.5',
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
  }
}
