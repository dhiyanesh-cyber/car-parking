import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';

class MapsDirectionScreen extends StatefulWidget {
  @override
  _MapsDirectionScreenState createState() => _MapsDirectionScreenState();
}

class _MapsDirectionScreenState extends State<MapsDirectionScreen> {
  GoogleMapController? mapController;
  List<LatLng> polylineCoordinates = [];
  PolylinePoints polylinePoints = PolylinePoints();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Maps Direction Example'),
      ),
      body: GoogleMap(
        onMapCreated: (controller) {
          mapController = controller;
          findRoute(); // Call the function to find the route
        },
        initialCameraPosition: CameraPosition(
          target: LatLng(37.7749, -122.4194), // Initial map center
          zoom: 12.0,
        ),
        polylines: {
          Polyline(
            polylineId: PolylineId('route'),
            color: Colors.blue,
            points: polylineCoordinates,
          ),
        },
        markers: {
          Marker(
            markerId: MarkerId('start'),
            position: LatLng(37.7749, -122.4194), // Start location
            icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueGreen),
          ),
          Marker(
            markerId: MarkerId('end'),
            position: LatLng(37.3352, -122.0096), // End location
            icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueRed),
          ),
        },
      ),
    );
  }

  void findRoute() async {
    PolylineResult result = await polylinePoints.getRouteBetweenCoordinates(
      'YOUR_API_KEY_HERE', // Replace with your API key
      PointLatLng(37.7749, -122.4194), // Start location
      PointLatLng(37.3352, -122.0096), // End location
    );

    if (result.points.isNotEmpty) {
      setState(() {
        polylineCoordinates = result.points
            .map((PointLatLng point) => LatLng(point.latitude, point.longitude))
            .toList();
      });
    }
  }
}

void main() => runApp(MaterialApp(home: MapsDirectionScreen()));
