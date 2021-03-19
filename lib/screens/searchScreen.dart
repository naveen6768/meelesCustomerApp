import 'package:Meeles/components/globalvariables.dart';
import 'package:Meeles/screens/messdetail.dart';
import 'package:Meeles/widgets/homeScreenDrawer.dart';
import 'package:flutter/material.dart';

class SearchScreen extends StatefulWidget {
  static const routeName = '/searchScreen';
  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {

  List mess = [];
  List food =[];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //drawer: HomeScreenDrawer(),
      appBar: AppBar(
        title: Text("Search Page", style:TextStyle(fontFamily: 'Lato',fontWeight: FontWeight.bold)),
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
						Text(
							'     Nearby Places for your meal:',
							style: TextStyle(
								color: Colors.black,
								fontFamily: 'Lato',
								fontSize: 16,
								fontWeight: FontWeight.bold,
							),
						),
            SizedBox(height:12),
              TextFormField(
                textCapitalization: TextCapitalization.words,
                decoration: InputDecoration(
                  prefixIcon: Icon(Icons.search, color: Theme.of(context).primaryColor,),
                  border: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(60)),gapPadding: 0)),
                  onChanged: (val){
                      List op = [];
                      List st = [];
                      for(int i =0 ; i<homeMesslist.length; i++){
                        if(homeMesslist[i]['Shop Name'].contains(val))
                          op.add(homeMesslist[i]);
                  }
                  for(int i = 0; i<dayThaliList.length;i++)
                    if(dayThaliList[i]['Item1'].contains(val) || dayThaliList[i]['Item2'].contains(val) || dayThaliList[i]['Item3'].contains(val) || dayThaliList[i]['Item4'].contains(val) || dayThaliList[i]['Food_Type'].contains(val) || dayThaliList[i]['Desert'].contains(val))
                          st.add(dayThaliList[i]);
                    
                  setState(() {
                    mess = op;
                    food = st;
                  });
                  }
              ),
              if(mess != [])
              ListView(
                shrinkWrap: true,
                physics: ScrollPhysics(),
              children : mess.map((element){
                  return InkWell(
                    onTap: (){
                      Navigator.of(context).pushNamed(MessDetail.routeName,
                          arguments: {'data':element.data(), 'isload': false});
                    },
                  child: Container(
      width: double.infinity,
      padding: EdgeInsets.all(10),
      child: Row(
       // mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            height: 50,
            width: 50,
            child: FadeInImage(placeholder: AssetImage('images/meeles_icon.png'), image: NetworkImage(element['url']),fit: BoxFit.cover,)),
            SizedBox(width:12),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(element['Shop Name'],style: TextStyle(fontWeight: FontWeight.bold,fontFamily: 'Lato',fontSize: 16),),
              SizedBox(height:6),
              Text(element['Address'],overflow: TextOverflow.ellipsis, style: TextStyle(fontSize: 14,fontFamily: 'Lato',fontWeight: FontWeight.normal, color: Colors.grey),),
            ],
            ),
          
      ],),
    ),
                  );
              }).toList(),),

              if(food != [])
              ListView(
                physics: ScrollPhysics(),
                shrinkWrap: true,
              children : food.map((element){
                  return InkWell(
                    onTap: (){
                      Navigator.of(context).pushNamed(MessDetail.routeName,arguments:{'data': element.reference.parent.parent.parent.parent,'isload': true});
                    },
                  child: Container(
      width: double.infinity,
      padding: EdgeInsets.all(10),
      child: Row(
       // mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            height: 50,
            width: 50,
            child: FadeInImage(placeholder: AssetImage('images/meeles_icon.png'), image: NetworkImage(element['url']),fit: BoxFit.cover,)),
            SizedBox(width:12),
          Text('${element['Item1']}, ${element['Item2']}, ${element['Item3']}, ${element['Item4']},',style: TextStyle(fontWeight: FontWeight.bold,fontFamily: 'Lato',fontSize: 16),),
          
      ],),
    ),
                  );
              }).toList(),),

            ],
          ),
        ),),
    );
  }
}