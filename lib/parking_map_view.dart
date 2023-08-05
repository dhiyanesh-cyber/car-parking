import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';

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

      // Load your custom marker image from assets
      BitmapDescriptor.fromAssetImage(
        ImageConfiguration(size: Size(5, 5)), // You can adjust the size as per your image
        'assets/car.png', // Replace 'your_custom_marker.png' with the actual image name
      ).then((BitmapDescriptor customMarker) {
        setState(() {
          _parkingMarkers.clear();
          _parkingMarkers.add(
            Marker(
              markerId: MarkerId("user_location"),
              position: _currentLocation,
              icon: customMarker,
            ),
          );
        });
      });
    });
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
        title: Text('Map View'),
        elevation: 0,
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(color: Colors.black),
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

