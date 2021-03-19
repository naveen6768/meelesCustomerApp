import 'package:Meeles/screens/messdetail.dart';
import 'package:flutter/material.dart';

class MenuTile extends StatelessWidget {
  var data,ref;
  MenuTile(this.data,this.ref);
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: (){
        Navigator.of(context).pushNamed(MessDetail.routeName,arguments:{'data': ref.parent.parent.parent.parent,'isload': true});
      },
          child: Container(
        margin: EdgeInsets.all(10),
        height: 200,
        width: 200,
        decoration: BoxDecoration(
          boxShadow: [
                  BoxShadow(
                    color: Colors.grey,
                    offset: Offset(0.0, 1.0), //(x,y)
                    blurRadius: 6.0,
                  ),
                ],
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
        ),
        child: Stack(
          children: [
            Positioned(
              child:FadeInImage(height: 140, width: 200,placeholder: AssetImage('images/meeles_icon.png'), image: NetworkImage(data['url']),fit: BoxFit.cover,), ),
            Positioned(child: Container(
            padding: EdgeInsets.all(5),
             color: Theme.of(context).primaryColor,
             child: Text('₹ ${data['Price']}/- ', style: TextStyle(fontSize: 14, fontFamily: 'Lato',fontWeight: FontWeight.w900,color: Colors.white),),
             ),
             right: 10,
             bottom: 50,),
            Positioned(
              child: Text('${data['Item1']}, ${data['Item2']}, ${data['Roti Quantity']} Roti, ${data['Rice Type']} Rice and ${data['Desert']}',
              style: TextStyle(fontFamily: 'Lato', fontSize: 14,fontWeight: FontWeight.bold,),
              ),
              top: 150,
              left: 5,
              right: 5,
              ),
          ],
        ),
      ),
    );
  }
}