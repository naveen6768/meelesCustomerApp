import 'package:Meeles/components/globalvariables.dart';
import 'package:Meeles/helpers/helpermethods.dart';
import 'package:Meeles/models/messDetails.dart';
import 'package:Meeles/providers/auth.dart';
import 'package:Meeles/providers/messDetailsData.dart';
import 'package:Meeles/widgets/homeScreenDrawer.dart';
import 'package:Meeles/widgets/homemenutile.dart';
import 'package:Meeles/widgets/homemesstile.dart';
import 'package:Meeles/widgets/textAppBar.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class MainScreen extends StatefulWidget {
	static const routeName = '/mainscreen';
	@override
	_MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
	GlobalKey<ScaffoldState> _drawerKey = GlobalKey();
	final ScrollController _scrollController = ScrollController();
  String day = DateFormat.EEEE().format(DateTime.now());
	String time;
  // void initState(){
  //   HelperMethods().data();
  // }
	 @override
	Widget build(BuildContext context) {
		double width = MediaQuery.of(context).size.width;
		String landmark = Provider.of<MessDetailsData>(context).landarea;
    print(day);
		time = HelperMethods().type();
		return Scaffold(
			key: _drawerKey,
			appBar: AppBar(
				title: TextAppBar(),
				centerTitle: false,
				backgroundColor: Theme.of(context).accentColor,
				// leading: IconButton(
				//   icon: Icon(Icons.list, color: Colors.black,),
				//   onPressed: (){

				//                 _drawerKey.currentState.openDrawer();
				//   },
				// ),
        actions: [
          TextButton(child : Text('Logout'), onPressed: (){
            Provider.of<Auth>(context,listen: false).authlogout();
          },)
        ],
			),
			//drawer: HomeScreenDrawer(),
			body: Container(
        color: Colors.white70,
				margin: EdgeInsets.symmetric(vertical: 15, horizontal: 10),
				child: ListView(
					shrinkWrap: true,
					//crossAxisAlignment: CrossAxisAlignment.start,
					children: [
            FutureBuilder<QuerySnapshot>(
              future: obj.collection('Sliders').get(),
              builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot){
                if(snapshot.hasError)
                return Container(height: 0,width: 0);
                if(snapshot.connectionState == ConnectionState.waiting)
                return Container(height: 150,width: double.infinity,);

                else 
                return CarouselSlider(
  options: CarouselOptions(
      height: 150,
      aspectRatio: 2,
      viewportFraction: 1,
      initialPage: 0,
      enableInfiniteScroll: true,
      reverse: false,
      autoPlay: true,
      autoPlayInterval: Duration(seconds: 10),
      autoPlayAnimationDuration: Duration(milliseconds: 800),
      autoPlayCurve: Curves.ease,
      enlargeCenterPage: true,
      scrollDirection: Axis.horizontal,
   ),
  items: snapshot.data.docs.map((DocumentSnapshot document) {
    return Builder(
      builder: (BuildContext context) {
        return Container(
          width: MediaQuery.of(context).size.width,
          margin: EdgeInsets.symmetric(horizontal: 5.0),
          //decoration: BoxDecoration(borderRadius: BorderRadius.circular(5)),
          child: FadeInImage(placeholder: AssetImage('images/meeles_logo.png'), image: NetworkImage(document['image']), fit: BoxFit.cover,),
        );
      },
    );
  }).toList());

              }
              ),
						
						SizedBox(
							height: 20,
						),
						Text(
							'Top Places for your meal:',
							style: TextStyle(
								color: Colors.black,
								fontFamily: 'Lato',
								fontSize: 16,
								fontWeight: FontWeight.bold,
							),
						),
						SizedBox(height: 12),
						Container(
						  child: FutureBuilder(
						  		// future: obj
						  		// 		.collection('Mess')
						  		// 		.where('Landmark', isEqualTo: landmark)
						  		// 		.orderBy('Rating', descending: true)
						  		// 		.get(),
                  future: HelperMethods().messprofiles(landmark),
						  		builder: ( context,
						  				AsyncSnapshot snapshot) {
						  			if (snapshot.hasError) {
						  				return Text('Something went wrong');
						  			}

						  			if (snapshot.connectionState == ConnectionState.waiting) {
						  				return Container(height: 120,width: double.infinity,);
						  			}
                    print(snapshot.data[2].id);
						  			return SingleChildScrollView(
												scrollDirection: Axis.horizontal,
																							child: new Row(
						  			  	//scrollDirection: Axis.horizontal,
						  			  //	controller: _scrollController,
						  			  //	shrinkWrap: true,
											
						  			  	children: snapshot.data.map<Widget>((DocumentSnapshot document){
                          
						  			  		return HomeMessTile(document);
						  			  	}).toList(),
						  			  	),
						  			);
						  		}),
						),
						
						SizedBox(
							height: 6,
						),
            Row(
							mainAxisAlignment: MainAxisAlignment.spaceEvenly,
							children: [
								Container(
									//height: 50,
									width: width * 0.45,
									child: InkWell(
										child: Image(
											image: AssetImage('images/rest.jpeg'),
										),
									),
								),
								Container(
									//height: 50,
									width: width * 0.45,
									child: InkWell(
										child: Image(
											image: AssetImage('images/tif.jpeg'),
										),
									),
								),
							],
						),
            if(time == 'Lunch')
            SizedBox(height: 18),
            if(time == 'Lunch')
						Text(
							'Lunch Items in your Locality',
							style: TextStyle(
								color: Colors.black,
								fontFamily: 'Lato',
								fontSize: 16,
								fontWeight: FontWeight.bold,
							),
						),
            if(time == 'Lunch')
						SizedBox(height: 6),
            if(time == 'Lunch')
						Container(
						  child: FutureBuilder<QuerySnapshot>(
						  		future: obj
						  				.collectionGroup(day)
						  				.where('Area', isEqualTo: landmark)
						  				.get(),
						  		builder: (BuildContext context,
						  				AsyncSnapshot<QuerySnapshot> snapshot) {
						  			if (snapshot.hasError) {
						  				return Text('Something went wrong');
						  			}

						  			if (snapshot.connectionState == ConnectionState.waiting) {
						  				return Container(height: 120,width: double.infinity,);
						  			}
						  			return SingleChildScrollView(
												scrollDirection: Axis.horizontal,
																							child: new Row(
						  			  
						  			  	children: snapshot.data.docs.map((DocumentSnapshot document){
                          if(document.data()['type'] == 'Lunch')
						  			  		return MenuTile(document.data(),document.reference);
                          else return Container(height: 0,width: 0,);
						  			  	}).toList(),
						  			  	),
						  			);
						  		}),
						),
            SizedBox(height: 18),
						Text(
							'Dinner Items in your Locality',
							style: TextStyle(
								color: Colors.black,
								fontFamily: 'Lato',
								fontSize: 16,
								fontWeight: FontWeight.bold,
							),
						),
						SizedBox(height: 6),
						Container(
						  child: FutureBuilder<QuerySnapshot>(
						  		future: obj
						  				.collectionGroup(day)
						  				.where('Area', isEqualTo: landmark)
						  				.get(),
						  		builder: (BuildContext context,
						  				AsyncSnapshot<QuerySnapshot> snapshot) {
						  			if (snapshot.hasError) {
						  				return Text('Something went wrong');
						  			}

						  			if (snapshot.connectionState == ConnectionState.waiting) {
						  				return Container(height: 150,width: double.infinity,);
						  			}
						  			return SingleChildScrollView(
												scrollDirection: Axis.horizontal,
																							child: new Row(
						  			  
						  			  	children: snapshot.data.docs.map((DocumentSnapshot document){
                          if(document.data()['type'] == 'Dinner')
						  			  		return MenuTile(document.data(),document.reference);
                          else return Container(height: 0,width: 0,);
						  			  	}).toList(),
						  			  	),
						  			);
						  		}),
						),
					],
				),
			),
		);
	}
}
