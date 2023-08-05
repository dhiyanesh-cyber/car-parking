import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';

import 'package:mapsss/presentation/screens/display_parking_details/DisplayParkingData_page.dart';


import 'package:mapsss/presentation/screens/settings/settings_page.dart';
import 'package:mapsss/presentation/screens/home/simple_starting_screen.dart';

import '../display_parking_details/display_parking_data_page.dart';
import '/presentation/screens/common/nav_bar/custom_bottom_navigation_bar.dart';
import '../../common/nav_animation/navigateWithAnimation.dart';


class ParkingMapView extends StatefulWidget {
  @override
  _ParkingMapViewState createState() => _ParkingMapViewState();
}

class _ParkingMapViewState extends State<ParkingMapView> {
  GoogleMapController? _mapController;
  Location _location = Location();
  LatLng _currentLocation = LatLng(9.939093, 78.121719);
  Set<Marker> _parkingMarkers = {};

  @override
  void initState() {
    super.initState();
    _getLocation();
  }

  // FETCHING DATA FROM DB

  Future<List<Map<String, dynamic>>> _fetchParkingData() async {
    List<Map<String, dynamic>> parkingDataList = [];

    QuerySnapshot snapshot = await FirebaseFirestore.instance.collection("parkingData").get();
    snapshot.docs.forEach((doc) {
      double latitude = doc.get('latitude');
      double longitude = doc.get('longitude');
      String parkingName = doc.get('parkingName');
      Map<String, dynamic> parkingData = {
        'latitude': latitude,
        'longitude': longitude,
        'parkingName': parkingName,
      };
      parkingDataList.add(parkingData);
    });

    return parkingDataList;
  }


  void _getLocation() async {
    bool serviceEnabled;
    PermissionStatus permissionGranted;
    LocationData locationData;

    serviceEnabled = await _location.serviceEnabled();
    if (!serviceEnabled) {
      serviceEnabled = await _location.requestService();
      if (!serviceEnabled) {
        return;
      }
    }

    permissionGranted = await _location.hasPermission();
    if (permissionGranted == PermissionStatus.denied) {
      permissionGranted = await _location.requestPermission();
      if (permissionGranted != PermissionStatus.granted) {
        return;
      }
    }

    locationData = await _location.getLocation();
    setState(() {
      _currentLocation = LatLng(locationData.latitude!, locationData.longitude!);
      _showParkingMarkers();
    });
  }

  void _showParkingMarkers() async {
    List<Map<String, dynamic>> parkingDataList = await _fetchParkingData();

    // Load custom marker image for parking locations
    BitmapDescriptor customMarker = await BitmapDescriptor.fromAssetImage(
      ImageConfiguration(size: Size(5, 5)),
      'assets/car.png',
    );

    setState(() {
      _parkingMarkers.clear();
      _parkingMarkers.add(
        Marker(
          markerId: MarkerId("user_location"),
          position: _currentLocation,
          icon: BitmapDescriptor.defaultMarker, // Default marker for user's location
        ),
      );

      // Add markers for parking locations with names
      parkingDataList.forEach((parkingData) {
        double latitude = parkingData['latitude'];
        double longitude = parkingData['longitude'];
        String parkingName = parkingData['parkingName'];
        LatLng parkingLocation = LatLng(latitude, longitude);

        _parkingMarkers.add(
          Marker(
            markerId: MarkerId(parkingName),
            position: parkingLocation,
            icon: customMarker, // Custom marker for parking locations
            onTap: () {
              // Navigate to a page when marker is tapped
              _navigateToParkingDetailsPage(parkingName, parkingLocation);
            },
          ),
        );
      });
    });
  }


  void _navigateToParkingDetailsPage(String parkingName, LatLng location) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => DisplayParkingDataPage(parkingName: parkingName, location: location),
      ),
    );
  }



  void _onMapCreated(GoogleMapController controller) {
    _mapController = controller;
  }

  void _showMyLocation() async {
    LocationData locationData = await _location.getLocation();
    LatLng currentLocation = LatLng(locationData.latitude!, locationData.longitude!);
    _mapController?.animateCamera(CameraUpdate.newLatLng(currentLocation));
  }

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
          'Map View',
          textAlign: TextAlign.center,
          style: TextStyle(color: Colors.black),
        ),
        elevation: 0,
      ),
      body: Stack(
        children: [
          GoogleMap(
            onMapCreated: _onMapCreated,
            initialCameraPosition: CameraPosition(
              target: _currentLocation,
              zoom: 10.0,
            ),
            markers: _parkingMarkers,
          ),
          Positioned(
            top: 10,
            left: 10,
            right: 10,
            child: Container(
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey),
                borderRadius: BorderRadius.circular(20),
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
          ),
        ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.startFloat,
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.black87,
        onPressed: _showMyLocation,
        child: Icon(Icons.my_location),
      ),
    );
  }
}

