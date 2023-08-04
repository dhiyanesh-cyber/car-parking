import 'package:flutter/material.dart';
import 'package:mapsss/parking_map_view.dart';
import 'package:mapsss/sample_details_page.dart';

import 'package:mapsss/settings_page.dart';
import 'package:mapsss/simple_starting_screen.dart';

import 'custom_bottom_navigation_bar.dart';
import 'navigateWithAnimation.dart';

class ParkingsPage extends StatelessWidget {
  final List<String> sampleList = ['Parking 1', 'Parking 2', 'Parking 3', 'Parking 4', 'Parking 5'];

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
          'Parkings',
          style: TextStyle(color: Colors.black),
        ),
        elevation: 0,
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(color: Colors.black),
      ),
      body: ListView.builder(
        itemCount: sampleList.length,
        itemBuilder: (context, index) {
          final sample = sampleList[index];
          return ListTile(
            title: Text(sample),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => SampleDetailsPage(sample: sample),
                ),
              );
            },
          );
        },
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
