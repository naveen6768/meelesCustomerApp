import 'package:Meeles/screens/messOverviewScreen.dart';
import 'package:Meeles/screens/messdetail.dart';
import 'package:flutter/material.dart';

class HomeMessTile extends StatelessWidget {
  var data;
  HomeMessTile(this.data);
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: (){
        
                      Navigator.of(context).pushNamed(MessDetail.routeName,
                          arguments: {'data':data.data(), 'isload': false});
      },
      
          child: Container(
        margin: EdgeInsets.all(10),
        height: 120,
        width: 80,
        child: Stack(
          alignment: AlignmentDirectional.bottomStart,
          children: [
          Positioned(
            child: FadeInImage(placeholder: AssetImage('images/meeles_icon.png'), image: NetworkImage(data['url']),fit: BoxFit.cover, height: 80,width: 80,),
            top: 0,
            ),
          Positioned(child: Container(
            padding: EdgeInsets.all(5),
             color: Theme.of(context).primaryColor,
             child: Text('⭐${data['Rating']} ', style: TextStyle(fontSize: 12, fontFamily: 'Lato',fontWeight: FontWeight.bold,color: Colors.white),),
             ),
             right: 4,
             bottom: 31,),
             Text('${data['Shop Name']}', style: TextStyle(fontFamily: 'Lato', fontWeight: FontWeight.bold, fontSize: 14),),
              
        ],),
      ),
    );
  }
}