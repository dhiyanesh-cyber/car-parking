import 'package:flutter/material.dart';
import 'simple_starting_screen.dart';
import 'parking_map_view.dart';
import 'parkings_page.dart';

void main() => runApp(ParkingLocatorApp());

class ParkingLocatorApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SimpleStartingScreen(),
      routes: {
        '/mapView': (context) => ParkingMapView(),
        '/parkingsPage': (context) => ParkingsPage(),
      },
    );
  }
}
