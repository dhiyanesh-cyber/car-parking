import 'package:flutter/material.dart';
import 'package:location/location.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MapScreen(),
    );
  }
}

class ParkingLocation {
  final String name;
  final LatLng coordinates;
  final String imageUrl;
  final String mobileNumber;

  ParkingLocation({
    required this.name,
    required this.coordinates,
    required this.imageUrl,
    required this.mobileNumber,
  });
}

class MapScreen extends StatefulWidget {
  @override
  _MapScreenState createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  LatLng userLocation = LatLng(9.921818, 78.120483);
  Location _location = Location();

  @override
  void initState() {
    super.initState();
    _getUserLocation();
  }

  Future<void> _getUserLocation() async {
    bool serviceEnabled;
    PermissionStatus permissionGranted;

    // Check if location services are enabled
    serviceEnabled = await _location.serviceEnabled();
    if (!serviceEnabled) {
      serviceEnabled = await _location.requestService();
      if (!serviceEnabled) {
        return;
      }
    }

    // Check if location permission is granted
    permissionGranted = await _location.hasPermission();
    if (permissionGranted == PermissionStatus.denied) {
      permissionGranted = await _location.requestPermission();
      if (permissionGranted != PermissionStatus.granted) {
        return;
      }
    }

    // Get the user's current location
    LocationData locationData = await _location.getLocation();
    setState(() {
      userLocation = LatLng(locationData.latitude!, locationData.longitude!);
    });
  }

  List<ParkingLocation> parkingLocations = [
    ParkingLocation(
      name: 'Parking Lot 1',
      coordinates: LatLng(9.921818, 78.120483),
      imageUrl: 'https://example.com/parking1.jpg',
      mobileNumber: '1234567890',
    ),
    ParkingLocation(
      name: 'Parking Lot 2',
      coordinates: LatLng(9.912345, 78.115678),
      imageUrl: 'https://example.com/parking2.jpg',
      mobileNumber: '9876543210',
    ),
    ParkingLocation(
      name: 'Parking Lot 3',
      coordinates: LatLng(9.930000, 78.130000),
      imageUrl: 'https://example.com/parking3.jpg',
      mobileNumber: '5555555555',
    ),
    // Add more parking locations as needed
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Parking Lot Taj the Gateway'),
      ),
      body: GoogleMap(
        initialCameraPosition: CameraPosition(
          target: userLocation,
          zoom: 15,
        ),
        markers: Set.from([
          Marker(
            markerId: MarkerId('userLocation'),
            position: userLocation,
            icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueBlue),
            infoWindow: InfoWindow(
              title: 'Your Location',
            ),
          ),
          ..._buildParkingMarkers(),
        ]),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _showParkingListDialog();
        },
        child: Icon(Icons.list),
        tooltip: 'Nearby Parkings',
      ),
    );
  }

  List<Marker> _buildParkingMarkers() {
    return parkingLocations.map((location) {
      return Marker(
        markerId: MarkerId(location.name),
        position: location.coordinates,
        icon: BitmapDescriptor.defaultMarker,
        infoWindow: InfoWindow(
          title: location.name,
        ),
        onTap: () {
          _onParkingMarkerTapped(location);
        },
      );
    }).toList();
  }

  double _calculateDistance(double lat1, double lon1, double lat2, double lon2) {
    return Geolocator.distanceBetween(lat1, lon1, lat2, lon2);
  }

  void _showParkingListDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        List<Map<String, dynamic>> sortedParkingList = [];

        for (ParkingLocation location in parkingLocations) {
          double distance = _calculateDistance(userLocation.latitude, userLocation.longitude, location.coordinates.latitude, location.coordinates.longitude);
          sortedParkingList.add({
            'name': location.name,
            'distance': distance,
          });
        }

        sortedParkingList.sort((a, b) => a['distance'].compareTo(b['distance']));

        return AlertDialog(
          title: Text('Parking Locations Sorted by Distance'),
          content: Container(
            width: double.maxFinite,
            child: ListView.builder(
              shrinkWrap: true,
              itemCount: sortedParkingList.length,
              itemBuilder: (BuildContext context, int index) {
                String name = sortedParkingList[index]['name'];
                double distance = sortedParkingList[index]['distance'];

                return ListTile(
                  title: Text('Parking Name: $name'),
                  subtitle: Text('Distance: ${distance.toStringAsFixed(2)} meters'),
                );
              },
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: Text('Close'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  void _onParkingMarkerTapped(ParkingLocation location) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => DetailsPage(
          imageUrl: location.imageUrl,
          parkingName: location.name,
          mobileNumber: location.mobileNumber,
        ),
      ),
    );
  }
}

class DetailsPage extends StatelessWidget {
  final String imageUrl;
  final String parkingName;
  final String mobileNumber;

  DetailsPage({required this.imageUrl, required this.parkingName, required this.mobileNumber});

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
            Image.network(imageUrl),
            SizedBox(height: 20),
            Text('Parking Name: $parkingName'),
            SizedBox(height: 10),
            Text('Mobile Number: $mobileNumber'),
          ],
        ),
      ),
    );
  }
}
