import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class ParkingDetailsPage extends StatefulWidget {
  final String parkingName;
  final LatLng parkingLocation;
  final LatLng currentLocation;

  ParkingDetailsPage({
    required this.parkingName,
    required this.parkingLocation,
    required this.currentLocation,
  });

  @override
  _ParkingDetailsPageState createState() => _ParkingDetailsPageState();
}

class _ParkingDetailsPageState extends State<ParkingDetailsPage> {
  List<LatLng> _polylineCoordinates = [];
  GoogleMapController? _mapController;

  @override
  void initState() {
    super.initState();
    _navigateToParking();
  }

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
            Text('Parking Name: ${widget.parkingName}'),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                _navigateToParking();
              },
              child: Text('Navigate'),
            ),
            SizedBox(height: 16),
            Expanded(
              child: GoogleMap(
                onMapCreated: _onMapCreated,
                initialCameraPosition: CameraPosition(
                  target: widget.currentLocation,
                  zoom: 15,
                ),
                polylines: {
                  Polyline(
                    polylineId: PolylineId('route_polyline'),
                    color: Colors.red,
                    points: _polylineCoordinates,
                    width: 10,
                  ),
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _onMapCreated(GoogleMapController controller) {
    _mapController = controller;
  }

  void _navigateToParking() async {
    // Calculate the route using the PolylinePoints
    _polylineCoordinates.clear();
    PolylinePoints polylinePoints = PolylinePoints();
    PolylineResult result = await polylinePoints.getRouteBetweenCoordinates(
      "AIzaSyBh9WKcqa42eAeZPNYmWPB1YebJiUXd2fU", // Replace with your Google Maps API key
      PointLatLng(widget.currentLocation.latitude, widget.currentLocation.longitude),
      PointLatLng(widget.parkingLocation.latitude, widget.parkingLocation.longitude),
      travelMode: TravelMode.driving,
    );

    if (result.points.isNotEmpty) {
      result.points.forEach((PointLatLng point) {
        _polylineCoordinates.add(LatLng(point.latitude, point.longitude));
      });
    } else {
      print('No route found!');
    }

    // Update the map to show the new polyline
    if (_mapController != null) {
      _mapController!.animateCamera(CameraUpdate.newLatLng(widget.currentLocation));
    } else {
      print('_mapController is null!');
    }
    setState(() {});
  }

}

