import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:line_icons/line_icons.dart';

import 'package:mapsss/presentation/screens/about/about.dart';
import 'package:mapsss/presentation/screens/map_view/parking_map_view.dart';
import 'package:mapsss/presentation/screens/parking_list/parkings_page.dart';
import 'package:mapsss/presentation/screens/settings/settings_page.dart';
import '../common/nav_bar/custom_bottom_navigation_bar.dart';
import '../../common/nav_animation/navigateWithAnimation.dart';
import '../display_parking_details/DisplayParkingData_page.dart';
import '../../../main.dart';

class SimpleStartingScreen extends StatefulWidget {
  @override
  _SimpleStartingScreenState createState() => _SimpleStartingScreenState();
}

class _SimpleStartingScreenState extends State<SimpleStartingScreen> {
  int currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.white,
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
                  SizedBox(width: 5),

                  Container(
                    height: 40.0,
                    width: 110,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30),
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
                      child: Text('Map View'),
                    ),
                  ),
                  Container(
                    height: 40.0,
                    width: 110,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30),
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
                      child: Text('Parkings'),
                    ),
                  ),
                  SizedBox(width: 5),
                ],
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomNavigationBarWidget(
        selectedIndex: currentIndex,
        onTabChange: (index) {
          setState(() {
            currentIndex;
          });
          switch (index) {
            case 1:
              navigateWithAnimation(
                  animationType: AnimationType.customSlide,
                  context: context,
                  pageClass: () => ParkingMapView());
              break;
            case 2:
              navigateWithAnimation(
                  animationType: AnimationType.customSlide,
                  context: context,
                  pageClass: () => DisplayPage());
              break;
            case 3:

          
              navigateWithAnimation(
                    animationType: AnimationType.customSlide,
                    context: context,
                    pageClass: () => SettingsPage());
              break;

            default:
              break;
          }
        },
      ),
    );
  }
}





