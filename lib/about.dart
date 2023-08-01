import 'package:flutter/material.dart';
import 'package:mapsss/parking_map_view.dart';
import 'package:mapsss/parkings_page.dart';
import 'package:mapsss/simple_starting_screen.dart';
import 'custom_bottom_navigation_bar.dart';
import 'navigateWithAnimation.dart';
class AboutPage extends StatelessWidget {
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
        title: Text(
          'About',
          style: TextStyle(color: Colors.black),
        ),
        elevation: 0,
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(color: Colors.black),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Car Parking App',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Text(
              'Version: 1.0',
              style: TextStyle(fontSize: 16, color: Colors.grey),
            ),
            SizedBox(height: 20),
            Text(
              'Description:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 5),
            Text(
              'Car Parking App is a user-friendly application that helps you find nearby car parkings with real-time location and capacity details. The app allows you to check the number of free slots available in each parking lot, making it convenient for you to plan your parking in advance.',
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 20),
            Text(
              'Features:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 5),
            Text(
              '1. Find nearby car parkings on the map.',
              style: TextStyle(fontSize: 16),
            ),
            Text(
              '2. Check live location and capacity of each parking lot.',
              style: TextStyle(fontSize: 16),
            ),
            Text(
              '3. View the number of available free slots in real-time.',
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 20),
            Text(
              'Contact:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 5),
            Text(
              'For any queries or support, feel free to contact us at:',
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 5),
            Text(
              'Email: support@carparkingapp.com',
              style: TextStyle(fontSize: 16),
            ),
            Text(
              'Phone: +1 (123) 456-7890',
              style: TextStyle(fontSize: 16),
            ),
          ],
        ),
      ),
            bottomNavigationBar: BottomNavigationBarWidget(
        selectedIndex: 3,
        onTabChange: (index) {
          switch (index) {
            case 0:
                    navigateWithAnimation(
                    animationType: AnimationType.fade,
                    context: context,
                    pageClass: () => SimpleStartingScreen());
              break;
            case 1:
              navigateWithAnimation(
                    animationType: AnimationType.fade,
                    context: context,
                    pageClass: () => ParkingMapView());
              break;
            case 2:
              navigateWithAnimation(
                    animationType: AnimationType.fade,
                    context: context,
                    pageClass: () => ParkingsPage());
              break;
            default:
              break;
          }
        },
      ),
    );
  }
}
