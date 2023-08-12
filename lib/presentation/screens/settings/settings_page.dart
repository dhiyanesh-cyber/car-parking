import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:ParkMe/presentation/colors/colors.dart';
import 'package:ParkMe/presentation/screens/display_parking_details/DisplayParkingData_page.dart';
import 'package:ParkMe/presentation/common/nav_animation/navigateWithAnimation.dart';
import 'package:ParkMe/presentation/screens/map_view/parking_map_view.dart';

import 'package:ParkMe/presentation/screens/home/simple_starting_screen.dart';

import '../feedback/feedback_page.dart';

class SettingsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CustomColors.myHexColor,
      appBar: AppBar(
        backgroundColor: CustomColors.myHexColor,
        title: Text(
          'Settings',
          textAlign: TextAlign.center,
          style: TextStyle(color: Colors.black),
        ),
        elevation: 0,
        centerTitle: true,
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
                    width: 300,
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
                      icon: Icon(Icons.file_copy, color: CustomColors.myHexColor,),
                      label: Text('Form',style: TextStyle(color: CustomColors.myHexColor),),
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
                      icon: Icon(Icons.info, color: CustomColors.myHexColor,),
                      label: Text(
                        'About',style: TextStyle(color: CustomColors.myHexColor)

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
                      icon: Icon(Icons.logout, color: CustomColors.myHexColor,),
                      label: Text('Log Out',style: TextStyle(color: CustomColors.myHexColor)),
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
                height: 40,
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
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => FeedbackPage()),
                    );
                  },
                  icon: Icon(Icons.feedback, color: CustomColors.myHexColor,),
                  label: Text('Feedback',style: TextStyle(color: CustomColors.myHexColor)),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.transparent,
                    shadowColor: Colors.transparent,

                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
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







