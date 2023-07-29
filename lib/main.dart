import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';

void main() => runApp(ParkingLocatorApp());

class ParkingLocatorApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(

      debugShowCheckedModeBanner: false,
      home: SimpleStartingScreen(

      ),
      routes: {
        '/mapView': (context) => ParkingMapView(),
      },
    );
  }
}

class SimpleStartingScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: AppBar(
        backgroundColor: Colors.white,

        title: Text('Parking Locator',textAlign: TextAlign.center, style: TextStyle( color: Colors.black),),
        elevation: 0,
      ),

      body: Container(
        alignment: Alignment.center,
        margin: EdgeInsets.only(left: 30, right: 30),

        child: Column(

          mainAxisSize: MainAxisSize.min,

          children: [

            Container(
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey), // Add a border
                borderRadius: BorderRadius.circular(20), // Add border radius
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
            SizedBox(height: 16),

            SizedBox(height: 40,
            child: ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, '/mapView');
              },
              child: Text('Map View'),
              style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20)
                  )
              ),
            ),
            ),
          ],
        ),
      ),
    );
  }
}

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
      _parkingMarkers.clear();
      _parkingMarkers.add(
        Marker(
          markerId: MarkerId("user_location"),
          position: _currentLocation,
          icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueAzure),
        ),
      );
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
    final themeData = ThemeData(
      primarySwatch: Colors.lightBlue,
    );

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(Icons.arrow_back_ios_rounded),
        ),

        title: Text('Map View',style: TextStyle(color: Colors.black),),
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
                border: Border.all(color: Colors.grey), // Add a border
                borderRadius: BorderRadius.circular(20), // Add border radius
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
        onPressed: _showMyLocation,
        child: Icon(Icons.my_location),
      ),
    );
  }
}
