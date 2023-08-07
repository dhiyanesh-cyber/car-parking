import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:location/location.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  GoogleMapController? mapController;
   Location _location = Location();
  LatLng _currentLocation=LatLng(37.422, -122.084);
  LatLng _targetLocation = LatLng(37.422, -122.084); // Replace with your target location coordinates
  List<LatLng> _currentRouteCoords = [];

  @override
  void initState() {
    super.initState();
    _getCurrentLocation();
  }

  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
  }

  void _getCurrentLocation() async {
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
    });
  }

  void _getRoute() async {
    if (_currentLocation == null) {
      print("Current location is not available.");
      return;
    }

    String apiKey = "AIzaSyBh9WKcq34a4AeZPNYmWPB1YebJiUXd2fU";
    String url =
        "https://maps.googleapis.com/maps/api/directions/json?origin=${_currentLocation.latitude},${_currentLocation.longitude}&destination=${_targetLocation.latitude},${_targetLocation.longitude}&key=$apiKey";

    http.Response response = await http.get(Uri.parse(url));
    Map<String, dynamic> data = json.decode(response.body);
    print(data);

    if (data["status"] == "OK") {
      List<LatLng> routeCoords = _decodePolyline(data["routes"][0]["overview_polyline"]["points"]);

      if (routeCoords != null && routeCoords.isNotEmpty) {
        mapController?.animateCamera(
          CameraUpdate.newLatLngBounds(
            LatLngBounds(
              southwest: LatLng(
                routeCoords.first.latitude,
                routeCoords.first.longitude,
              ),
              northeast: LatLng(
                routeCoords.last.latitude,
                routeCoords.last.longitude,
              ),
            ),
            100.0,
          ),
        );

        setState(() {
          _currentRouteCoords = routeCoords;
        });
      }
    } else {
      print("Failed to get directions");
    }
  }

  List<LatLng> _decodePolyline(String encoded) {
    List<LatLng> poly = [];
    int index = 0;
    int len = encoded.length;
    int lat = 0;
    int lng = 0;

    while (index < len) {
      int b;
      int shift = 0;
      int result = 0;

      do {
        b = encoded.codeUnitAt(index++) - 63;
        result |= (b & 0x1F) << shift;
        shift += 5;
      } while (b >= 0x20);

      int dlat = ((result & 1) != 0 ? ~(result >> 1) : (result >> 1));
      lat += dlat;

      shift = 0;
      result = 0;

      do {
        b = encoded.codeUnitAt(index++) - 63;
        result |= (b & 0x1F) << shift;
        shift += 5;
      } while (b >= 0x20);

      int dlng = ((result & 1) != 0 ? ~(result >> 1) : (result >> 1));
      lng += dlng;

      double latDouble = lat / 1E5;
      double lngDouble = lng / 1E5;

      LatLng point = LatLng(latDouble, lngDouble);
      poly.add(point);
    }

    return poly;
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Route App'),
        ),
        body: Stack(
          children: [
            GoogleMap(
              onMapCreated: _onMapCreated,
              initialCameraPosition: CameraPosition(
                target: LatLng(
                  _currentLocation?.latitude ?? 0,
                  _currentLocation?.longitude ?? 0,
                ),
                zoom: 12.0,
              ),
              polylines: {
                if (_currentRouteCoords != null && _currentRouteCoords.isNotEmpty)
                  Polyline(
                    polylineId: PolylineId("route"),
                    color: Colors.blue,
                    points: _currentRouteCoords,
                  ),
              },
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: ElevatedButton(
                onPressed: _getRoute,
                child: Text('Get Route'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
