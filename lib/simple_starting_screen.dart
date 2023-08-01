import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:line_icons/line_icons.dart';

class SimpleStartingScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: Container(
        color: Colors.black,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 10),
          child: GNav(
              backgroundColor: Colors.black,
              color: Colors.white,
              activeColor: Colors.white,
              gap: 8,
              tabBackgroundColor: Colors.grey.shade800,
              padding: EdgeInsets.all(16),


              tabs: [
                GButton(
                  icon: LineIcons.home,
                  text: 'Home',
                ),
                GButton(
                  icon: LineIcons.mapMarker,
                  text: 'Map View',
                ),
                GButton(
                  icon: LineIcons.car,
                  text: 'Parkings',
                ),
                GButton(
                  icon: LineIcons.infoCircle,
                  text: 'About',
                )
              ],
            selectedIndex: 0,
            onTabChange: (index) {
              switch (index) {
                case 1:
                  Navigator.pushNamed(context, '/mapView');
                  break;
                case 2:
                  Navigator.pushNamed(context, '/parkingsPage');
                  break;
                default:
                  break;
              }
            },


          ),

        ),
      ),
      appBar: AppBar(
        backgroundColor: Colors.white,

        title: Text(
          'Parking Locator',
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
              SizedBox(
                height: 20,
              ),
              Image.asset(
                'assets/Park me-logos_black.png',
                height: 200,
              ),
              SizedBox(height: 20),

              Container(
                height: 45,
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey),
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

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(width: 5,),




                  Container(
                    height: 40.0,
                    width: 110,

                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(30),
                        gradient: LinearGradient(
                            colors: [Color.fromARGB(255, 2, 173, 102), Colors.blue])),
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.pushNamed(context, '/mapView');
                      },
                      style: ElevatedButton.styleFrom(

                          backgroundColor: Colors.transparent,
                          shadowColor: Colors.transparent),
                      child: Text('Map View'),
                    ),
                  ),






                  Container(
                    height: 40.0,
                    width: 110,

                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30),
                        gradient: LinearGradient(
                            colors: [Color.fromARGB(255, 2, 173, 102), Colors.blue])),
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.pushNamed(context, '/parkingsPage');
                      },
                      style: ElevatedButton.styleFrom(

                          backgroundColor: Colors.transparent,
                          shadowColor: Colors.transparent),
                      child: Text('Parkings'),
                    ),
                  ),





                  SizedBox(width: 5,),
                ],
              ),


            ],
          ),
        ),
      ),
    );
  }
}







