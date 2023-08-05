import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class DisplayParkingDataPage extends StatelessWidget {
  final String parkingName;
  final LatLng location;

  const DisplayParkingDataPage({required this.parkingName, required this.location});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Parking Details'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Parking Name: $parkingName'),
            SizedBox(height: 10),
            Text('Latitude: ${location.latitude}, Longitude: ${location.longitude}'),
          ],
        ),
      ),
    );
  }
}
