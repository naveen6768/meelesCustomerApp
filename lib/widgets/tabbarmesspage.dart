import 'package:Meeles/widgets/profilethalview.dart';
import 'package:Meeles/widgets/reviewmess.dart';
import 'package:flutter/material.dart';

class TabbarMessProfile extends StatefulWidget {
  @override
  _TabbarMessProfileState createState() => _TabbarMessProfileState();
}

class _TabbarMessProfileState extends State<TabbarMessProfile> {
  bool active = true;
  
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return 
                Container(
                  child: Column(
                    children: [
                      Row(children: [
                        InkWell(
                          onTap: (){
                            setState(() {
                              active = true;
                            });
                          },
                                            child: AnimatedContainer(
                            duration: Duration(milliseconds: 1),
                            width:width * 0.48,
                            height: 28,
                            padding: EdgeInsets.symmetric(vertical:3),
                            child: Center(child: Text('Menu', style: TextStyle(fontSize: 18,fontFamily: 'Lato',fontWeight: FontWeight.bold),)),
                            decoration: BoxDecoration(
                              border: Border(bottom: BorderSide(color: active ? Theme.of(context).primaryColor : Colors.white)),
                            ),
                            ),
                        ),
                          InkWell(
                            onTap: (){
                            setState(() {
                              active = false;
                            });
                          },
                          child: AnimatedContainer(
                            duration: Duration(milliseconds: 1),
                            width:width * 0.48,
                            height: 28,
                            padding: EdgeInsets.symmetric(vertical:3),
                            child: Center(child: Text('Review', style: TextStyle(fontSize: 18,fontFamily: 'Lato',fontWeight: FontWeight.bold),)),
                            decoration: BoxDecoration(
                              border: Border(bottom: BorderSide(color: !active ? Theme.of(context).primaryColor : Colors.white)),
                            ),
                            ),
                          ),
                      ],),
                      SizedBox(height:12),
                      active ? ThaliView():ReviewPage(),
                    ],
                  ),
                );
  }
}