import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapScreen extends StatelessWidget {
  Future<Uint8List> getBytesFromAsset(String path) async {
    ByteData data = await rootBundle.load(path);
    return data.buffer.asUint8List();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Parking Lot Taj the Gateway'),
      ),
      body: FutureBuilder<Uint8List>(
        future: getBytesFromAsset('assets/parking_marker2.png'),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done && snapshot.hasData) {
            return GoogleMap(
              initialCameraPosition: CameraPosition(
                target: LatLng(9.921818, 78.120483),
                zoom: 15,
              ),
              markers: {
                Marker(
                  markerId: MarkerId('parkingLot'),
                  position: LatLng(9.921818, 78.120483),
                  icon: BitmapDescriptor.fromBytes(snapshot.data!),
                  infoWindow: InfoWindow(
                    title: 'Parking lot Taj the Gateway',
                  ),
                ),
              },
            );
          } else {
            return Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }
}
