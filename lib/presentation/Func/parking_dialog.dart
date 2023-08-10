import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:ParkMe/presentation/colors/colors.dart';

class ParkingDialog {
  // Method to show the parking list dialog with sorted parking locations
  static void showParkingListDialog(
      BuildContext context,
      List<Map<String, dynamic>> parkingDataList,
      LatLng currentLocation,
      Function(String, LatLng) navigateToParkingDetails,
      ) {
    // Create a list to store parking locations sorted by distance
    List<Map<String, dynamic>> sortedParkingList = [];

    // Calculate the distance between the user's current location and each parking location
    parkingDataList.forEach((parkingData) {
      double distance = Geolocator.distanceBetween(
        currentLocation.latitude,
        currentLocation.longitude,
        parkingData['latitude'],
        parkingData['longitude'],
      );
      // Add parking location details to the sorted list
      sortedParkingList.add({
        'name': parkingData['parkingName'],
        'distance': distance * 0.001, // Convert distance to kilometers
        'latitude': parkingData['latitude'],
        'longitude': parkingData['longitude'],
      });
    });

    // Sort the list based on distance in ascending order
    sortedParkingList.sort((a, b) => a['distance'].compareTo(b['distance']));

    // Show the dialog to display the sorted parking locations
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Colors.black.withOpacity(0.8),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
          shadowColor: Colors.black.withOpacity(0),
          title: Text(
            'Parking Locations Sorted by Distance',
            style: TextStyle(color: CustomColors.myHexColorDarker),
          ),
          content: Container(
            width: double.maxFinite,
            child: ListView.builder(
              shrinkWrap: true,
              itemCount: sortedParkingList.length,
              itemBuilder: (BuildContext context, int index) {
                String name = sortedParkingList[index]['name'];
                double distance = sortedParkingList[index]['distance'];

                return GestureDetector(
                  onTap: () {
                    // Navigate to the respective details page when a parking location is tapped
                    navigateToParkingDetails(
                      name,
                      LatLng(
                        sortedParkingList[index]['latitude'],
                        sortedParkingList[index]['longitude'],
                      ),
                    );
                  },
                  child: ListTile(
                    title: Text(
                      'Parking Name: $name',
                      style: TextStyle(color: Colors.white),
                    ),
                    subtitle: Text(
                      'Distance: ${distance.toStringAsFixed(2)} Km',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                );
              },
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: Text('Close', style: TextStyle(color: CustomColors.myHexColor),),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}
