import 'package:flutter/material.dart';


import 'package:ParkMe/colors/colors.dart';




class SimpleStartingScreen extends StatefulWidget {
  @override
  _SimpleStartingScreenState createState() => _SimpleStartingScreenState();
}

class _SimpleStartingScreenState extends State<SimpleStartingScreen> {
  int currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CustomColors.myHexColor,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: CustomColors.myHexColor,
        title: Text(
          'Park me',
          textAlign: TextAlign.center,
          style: TextStyle(color: Colors.black),
        ),
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Container(
          alignment: Alignment.topCenter,
          margin: EdgeInsets.only(left: 30, right: 30),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(height: 20),
              Image.asset(
                'assets/Park me-logos_black.png',
                height: 200,
              ),
              SizedBox(height: 20),
              Container(
                height: 45,
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.black87),
                  borderRadius: BorderRadius.circular(50),
                ),
                padding: EdgeInsets.symmetric(horizontal: 16.0),
                child: TextField(
                  decoration: InputDecoration(
                    hintText: 'Search for parking...',
                    border: InputBorder.none,
                    suffixIcon: Icon(Icons.search),
                  ),
                  onChanged: (value) {
                    // Implement your search functionality here
                  },
                ),
              ),
              SizedBox(height: 50),

              Container(
                    height: 50.0,
                    width: 300,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      gradient: LinearGradient(
                        colors: [Colors.black87, Colors.grey.shade800],
                      ),
                    ),
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.pushNamed(context, '/mapView');
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.transparent,
                        shadowColor: Colors.transparent,
                      ),
                      child: Text('Map View',style: TextStyle(color: CustomColors.myHexColor),),
                    ),
                  ),

                  SizedBox(
                    height: 20,
                  ),
                  Container(
                    height: 50.0,
                    width: 300,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      gradient: LinearGradient(
                        colors: [Colors.black87, Colors.grey.shade800],
                      ),

                    ),
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.pushNamed(context, '/parkingsPage');
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.transparent,
                        shadowColor: Colors.transparent,
                      ),
                      child: Text('Parkings',style: TextStyle(color: CustomColors.myHexColor),),
                    ),
                  ),
                  SizedBox(width: 5),
                ],
              ),

          ),
        ),


    );
  }
}
