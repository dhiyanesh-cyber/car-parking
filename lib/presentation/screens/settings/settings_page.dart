import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:mapsss/DisplayParkingData_page.dart';
import 'package:mapsss/presentation/common/nav_animation/navigateWithAnimation.dart';
import 'package:mapsss/parking_map_view.dart';
import 'package:mapsss/parkings_page.dart';
import 'package:mapsss/simple_starting_screen.dart';

import '../common/nav_bar/custom_bottom_navigation_bar.dart'; // Import the Firebase Auth package

class SettingsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(Icons.arrow_back_ios_rounded),
        ),
        iconTheme: IconThemeData(color: Colors.black),
        backgroundColor: Colors.white,
        title: Text(
          'Settings',
          textAlign: TextAlign.center,
          style: TextStyle(color: Colors.black),
        ),
        elevation: 0,
      ),


      bottomNavigationBar: BottomNavigationBarWidget(
        selectedIndex: 3,
        onTabChange: (index) {
          switch (index) {
            case 0:
                    navigateWithAnimation(
                    animationType: AnimationType.customSlide,
                    context: context,
                    pageClass: () => SimpleStartingScreen());
              break;
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
           
            default:
              break;
          }
        },
      ),

      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              SizedBox(
                height: 30,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [


                  Container(
                    height: 70.0,
                    width: 130,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      gradient: LinearGradient(
                        colors: [Colors.black87, Colors.grey.shade800],
                      ),
                    ),
                    child: ElevatedButton.icon(
                      onPressed: () {
                        // Log out the user and navigate to the LoginPage.
                        Navigator.pushNamed(context, '/form');
                      },
                      icon: Icon(Icons.file_copy),
                      label: Text('Form'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.transparent,
                        shadowColor: Colors.transparent,

                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                    ),
                  ),

                ],
              ),

              SizedBox(
                height: 50,
              ),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Container(
                    height: 70.0,
                    width: 130,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      gradient: LinearGradient(
                        colors: [Colors.black87, Colors.grey.shade800],
                      ),
                    ),
                    child: ElevatedButton.icon(
                      onPressed: () {
                        // Navigate to the AboutPage.
                        Navigator.pushNamed(context, '/aboutUs');
                      },
                      icon: Icon(Icons.info),
                      label: Text(
                        'About',

                      ),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.transparent,
                        shadowColor: Colors.transparent,

                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                    ),
                  ),
                  Container(
                    height: 70.0,
                    width: 130,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      gradient: LinearGradient(
                        colors: [Colors.black87, Colors.grey.shade800],
                      ),
                    ),
                    child: ElevatedButton.icon(
                      onPressed: () {
                        // Log out the user and navigate to the LoginPage.
                        _logout(context);
                      },
                      icon: Icon(Icons.logout),
                      label: Text('Log Out'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.transparent,
                        shadowColor: Colors.transparent,

                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                    ),
                  ),


                ],
              ),
              SizedBox(height: 16), // Add some spacing between buttons
              // You can add additional buttons or widgets here if needed
            ],
          ),
        ),
      ),

    );
  }

  void _logout(BuildContext context) async {
    try {
      // Sign out the user from Firebase Authentication.
      await FirebaseAuth.instance.signOut();

      // Clear user session or other relevant data if applicable.
      // ...

      // Navigate to the login page and remove all previous routes.
      Navigator.pushNamedAndRemoveUntil(context, '/login', (route) => false);
    } catch (e) {
      // Handle any error that might occur during logout (optional).
      print('Error during logout: $e');
    }
  }


}

