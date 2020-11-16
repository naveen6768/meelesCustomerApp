import 'package:flutter/material.dart';

class AboutUs extends StatelessWidget {
  static const routeName = '/aboutus';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('About Us'),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Container(
            margin: EdgeInsets.all(10.0),
            child: SingleChildScrollView(
              padding: EdgeInsets.all(20),
              child: Column(
                children: <Widget>[
                  Text(
                    'A good quality, nutritious food is not only a source of energy, it\'s an ultimate experience and, we are here to make this very experience of yours better than yesterday and will always endeavor to move towards the best of, what we can.',
                    style: TextStyle(
                      fontFamily: 'Lato',
                      fontSize: 16,
                    ),
                  ),
                  Text(
                    'Eagerness for change is the human nature, and keeping the same in mind, meeles has been initiated. Meeles is an online platform for a variety of food lovers and owners to come across each other and connects them front to front, the food lovers have the options or choices for their daily meals, whether it is lunch or dinner and may experience something new everyday from a variety of messes in their area than to the traditional and boring daily meals of a single mess.',
                    style: TextStyle(
                      fontFamily: 'Lato',
                      fontSize: 16,
                    ),
                  ),
                  Text(
                    'Whereas, the owners of this field get a huge opportunity to expand their customer base and to globalize their food industry. Being in this competitive atmosphere, they will learn how to do well, in hospitality, in marketing techniques, in providing the nutrition enriched food and many others aspects of food industry.',
                    style: TextStyle(
                      fontFamily: 'Lato',
                      fontSize: 16,
                    ),
                  ),
                  Text(
                    'Our main aim is to provide better choices at any moment with a single click. That\'s why, introducing you to the biggest food mess chain of India that facilitates food requirements. That\'s what we are all about. We are really optimistic about the future.',
                    style: TextStyle(
                      fontFamily: 'Lato',
                      fontSize: 16,
                    ),
                  ),
                  SizedBox(
                    height: 10.0,
                  ),
                  Text(
                    '\"Pull up a chair. Take a taste. Come join us. Life is so endlessly delicious.\"',
                    style: TextStyle(
                      fontFamily: 'Lato',
                      fontSize: 16,
                    ),
                  ),
                ],
              ),
            )),
      ),
    );
  }
}
