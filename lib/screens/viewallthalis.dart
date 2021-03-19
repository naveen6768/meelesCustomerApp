import 'package:Meeles/components/globalvariables.dart';
import 'package:Meeles/screens/messdetail.dart';
import 'package:Meeles/widgets/homemenutile.dart';
import 'package:flutter/material.dart';

class ThaliListScreen extends StatefulWidget {
  static const routeName = '/ThaliListScreen';
  @override
  _ThaliListScreenState createState() => _ThaliListScreenState();
}

class _ThaliListScreenState extends State<ThaliListScreen> {
  List thali = dayThaliList;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //drawer: HomeScreenDrawer(),
      appBar: AppBar(
        title: Text("Explore Thalis", style:TextStyle(fontFamily: 'Lato',fontWeight: FontWeight.bold)),
        centerTitle: false,
      ),
      body: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.only(left:10,right:10,top: 15),
         // padding: EdgeInsets.all(10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height:12),
						// Text(
						// 	'     Nearby Places for your meal:',
						// 	style: TextStyle(
						// 		color: Colors.black,
						// 		fontFamily: 'Lato',
						// 		fontSize: 16,
						// 		fontWeight: FontWeight.bold,
						// 	),
						// ),
            // SizedBox(height:12),
              TextFormField(
                textCapitalization: TextCapitalization.words,
                decoration: InputDecoration(
                  prefixIcon: Icon(Icons.search, color: Theme.of(context).primaryColor,),
                  border: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(60)),gapPadding: 0)),
                  onChanged: (val){
                       List op = [];
                  //   List st = [];
                      for(int i =0 ; i<homeMesslist.length; i++){
                        if(homeMesslist[i]['Shop Name'].contains(val))
                          op.add(homeMesslist[i]);
                  }
                  // for(int i = 0; i<dayThaliList.length;i++)
                  //   if(dayThaliList[i]['Item1'].contains(val) || dayThaliList[i]['Item2'].contains(val) || dayThaliList[i]['Item3'].contains(val) || dayThaliList[i]['Item4'].contains(val) || dayThaliList[i]['Food_Type'].contains(val) || dayThaliList[i]['Desert'].contains(val))
                  //         st.add(dayThaliList[i]);
                    
                  setState(() {
                    thali = op;
                  });
                  }
              ),
              SizedBox(height:12),
              GridView(
                physics: ScrollPhysics(),
                shrinkWrap: true,
                gridDelegate:const SliverGridDelegateWithMaxCrossAxisExtent(
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
        maxCrossAxisExtent: 200,
        childAspectRatio: 1,
      ),
      //itemCount: mess.length,
      children: thali.map((element){
        // return InkWell(
        //   onTap: (){
        //     Navigator.of(context).pushNamed(MessDetail.routeName,
        //                   arguments: {'data': element.data(), 'isload': false});
        //   },
        //           child: GridTile(
        //     child: FadeInImage(height: 140, width: 200,placeholder: AssetImage('images/meeles_icon.png'), image: NetworkImage(element['url']),fit: BoxFit.cover,),
        //     footer: Container(
        //       width: double.infinity,
        //       color: Colors.white,
        //       height: 25,
        //       child: Text(element['Shop Name'],
        //           style: TextStyle(fontFamily: 'Lato', fontSize: 14,fontWeight: FontWeight.bold,),
        //       ),
        //     ),
        //     ),
        // );
        return InkWell(
          onTap: (){
        Navigator.of(context).pushNamed(MessDetail.routeName,arguments:{'data': element.reference.parent.parent.parent.parent,'isload': true});            
          },
                  child: GridTile(
            child: FadeInImage(height: 140, width: 200,placeholder: AssetImage('images/meeles_icon.png'), image: NetworkImage(element['url']),fit: BoxFit.cover,), 
            header: Container(
              padding: EdgeInsets.all(5),
               color: Theme.of(context).primaryColor,
               child: Text('₹ ${element['Price']}/- ',style: TextStyle(fontSize: 14, fontFamily: 'Lato',fontWeight: FontWeight.w900,color: Colors.white),),
               ),
               footer: Container(
                 padding: EdgeInsets.all(5),
                 color: Colors.white,
                 child: Text('${element['Item1']}, ${element['Item2']}, ${element['Roti Quantity']} Roti, ${element['Rice Type']} Rice and ${element['Desert']}',
                  style: TextStyle(fontFamily: 'Lato', fontSize: 14,fontWeight: FontWeight.bold,),
                  ),
               ),
          ),
        );
      }).toList(),
                ),
            ],
          ),
        ),),
    );
  }
}