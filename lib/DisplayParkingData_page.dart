import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:mapsss/parking_map_view.dart';
import 'package:mapsss/presentation/screens/settings/settings_page.dart';
import 'package:mapsss/simple_starting_screen.dart';
import 'presentation/screens/common/nav_bar/custom_bottom_navigation_bar.dart';
import 'details_page.dart';
import 'presentation/common/nav_animation/navigateWithAnimation.dart'; // Import the DetailsPage

class DisplayPage extends StatelessWidget {
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
          'Parking List',
          style: TextStyle(color: Colors.black),
        ),
        elevation: 0,
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(color: Colors.black),
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
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance.collection('parkingData').snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }

          return ListView.builder(
            itemCount: snapshot.data!.docs.length,
            itemBuilder: (context, index) {
              var doc = snapshot.data!.docs[index];
              return ListTile(
                leading: Image.network(
                  doc['imageUrl'],
                  height: 50,
                  width: 50,
                  fit: BoxFit.cover,
                ),
                title: Text(doc['parkingName']),
                subtitle: Text(doc['mobileNumber']),
                onTap: () {
                  // Navigate to the DetailsPage with the selected data's details.
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => DetailsPage(
                        imageUrl: doc['imageUrl'],
                        parkingName: doc['parkingName'],
                        mobileNumber: doc['mobileNumber'],
                      ),
                    ),
                  );
                },
              );
            },
          );
        },
      ),
    );
  }
}
