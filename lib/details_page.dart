import 'package:flutter/material.dart';
import 'package:mapsss/parking_map_view.dart';
import 'package:mapsss/presentation/screens/settings/settings_page.dart';
import 'package:mapsss/simple_starting_screen.dart';

import 'presentation/screens/common/nav_bar/custom_bottom_navigation_bar.dart';
import 'presentation/common/nav_animation/navigateWithAnimation.dart';

class DetailsPage extends StatelessWidget {
  final String imageUrl;
  final String parkingName;
  final String mobileNumber;

  DetailsPage({
    required this.imageUrl,
    required this.parkingName,
    required this.mobileNumber,
  });

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
          'Details',
          style: TextStyle(color: Colors.black),
        ),
        elevation: 0,
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(color: Colors.black),
      ),
      body: SingleChildScrollView(
        child: Container(
          alignment: Alignment.topCenter,
          margin: EdgeInsets.only(left: 30, right: 30),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                height: 50,
              ),
              ClipRRect(
                borderRadius: BorderRadius.circular(10), // Apply border radius here
                child: Image.network(
                  imageUrl,
                  height: 200,
                ),
              ),
              SizedBox(height: 40),
              Text(
                'Parking Name: $parkingName',
                style: TextStyle(fontSize: 20),
              ),
              SizedBox(height: 16),
              Text(
                'Mobile Number: $mobileNumber',
                style: TextStyle(fontSize: 18),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomNavigationBarWidget(
        selectedIndex: 2,
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
