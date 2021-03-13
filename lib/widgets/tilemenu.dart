import 'package:flutter/material.dart';

class TileMenu extends StatelessWidget {
  var data;
  TileMenu(this.data);
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Flexible(
            flex: 3,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('${data['type']} Thali',style: TextStyle(fontWeight: FontWeight.bold,fontFamily: 'Lato',fontSize: 16),),
                          SizedBox(height:6),
                          Text('₹ ${data['Price']}', style: TextStyle(fontSize: 14,fontFamily: 'Lato',fontWeight: FontWeight.bold, color: Colors.grey),),
                          SizedBox(height:3),
                          Text('${data['Item1']}, ${data['Item2']}, ${data['Item3']}, ${data['Item4']}, ${data['Roti Quantity']} Roti, ${data['Rice Type']} Rice, ${data['Desert']} ',style: TextStyle(fontSize: 14,fontFamily: 'Lato',fontWeight: FontWeight.normal, color: Colors.grey),),
                        ],
            ),
          ),
          Flexible(
            flex: 2,
                      child: Container(
                        height: 150,
                        width: 200,
                        child: FadeInImage(placeholder: AssetImage('images/meeles_icon.png'), image: NetworkImage(data['url']),fit: BoxFit.fitWidth,)),
          ),
      ],),
    );
      
  }
}