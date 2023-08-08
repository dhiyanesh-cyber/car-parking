import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapsDirectionScreen extends StatefulWidget {
  @override
  _MapsDirectionScreenState createState() => _MapsDirectionScreenState();
}

class _MapsDirectionScreenState extends State<MapsDirectionScreen> {
  GoogleMapController? mapController;
  List<Polyline> polylines = [];
  List<Polygon> polygons = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Polygons and Polylines Example'),
      ),
      body: Stack(
        children: [
          GoogleMap(
            onMapCreated: (controller) {
              mapController = controller;
              addPolylinesAndPolygons(); // Call the function to add polylines and polygons
            },
            initialCameraPosition: CameraPosition(
              target: LatLng(-27.457, 153.040), // Initial map center
              zoom: 4.0,
            ),
            polylines: Set.from(polylines),
            polygons: Set.from(polygons),
            onTap: (LatLng latLng) {
              // Handle map tap event here if needed
            },
          ),
          GestureDetector(
            onTap: () {
              // Check if any polyline is tapped
              for (Polyline polyline in polylines) {
                List<LatLng> points = polyline.points;
                LatLngBounds bounds = LatLngBounds(
                  southwest: points.first,
                  northeast: points.last,
                );
                // Convert screen coordinates of the polyline to LatLng
                mapController?.getLatLng(ScreenCoordinate(
                  x: MediaQuery.of(context).size.width ~/ 2,
                  y: MediaQuery.of(context).size.height ~/ 2,
                )).then((LatLng latLng) {
                  // Check if the tap event is within the polyline bounds
                  if (bounds.contains(latLng)) {
                    // Handle polyline tap event here
                    print('Polyline tapped: ${polyline.polylineId}');
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: Text('Polyline Tapped'),
                          content: Text(
                              'You tapped on Polyline: ${polyline.polylineId}'),
                          actions: <Widget>[
                            TextButton(
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                              child: Text('Close'),
                            ),
                          ],
                        );
                      },
                    );
                    
                  }
                });
              }
            },
          ),
        ],
      ),
    );
  }

  void addPolylinesAndPolygons() {
    // Add polylines to the map.
    // Polylines are useful to show a route or some other connection between points.
    polylines.add(Polyline(
      polylineId: PolylineId('polyline1'),
      points: [
        LatLng(-35.016, 143.321),
        LatLng(-34.747, 145.592),
        LatLng(-34.364, 147.891),
        LatLng(-33.501, 150.217),
        LatLng(-32.306, 149.248),
        LatLng(-32.491, 147.309),
      ],
      color: Colors.black,
      width: 12,
    ));

    polylines.add(Polyline(
      polylineId: PolylineId('polyline2'),
      points: [
        LatLng(-29.501, 119.700),
        LatLng(-27.456, 119.672),
        LatLng(-25.971, 124.187),
        LatLng(-28.081, 126.555),
        LatLng(-28.848, 124.229),
        LatLng(-28.215, 123.938),
      ],
      color: Colors.red,
      width: 12,
    ));

    // Add polygons to indicate areas on the map.
    polygons.add(Polygon(
      polygonId: PolygonId('polygon1'),
      points: [
        LatLng(-27.457, 153.040),
        LatLng(-33.852, 151.211),
        LatLng(-37.813, 144.962),
        LatLng(-34.928, 138.599),
      ],
      strokeWidth: 8,
      strokeColor: Colors.black,
      fillColor: Colors.white,
    ));

    polygons.add(Polygon(
      polygonId: PolygonId('polygon2'),
      points: [
        LatLng(-31.673, 128.892),
        LatLng(-31.952, 115.857),
        LatLng(-17.785, 122.258),
        LatLng(-12.4258, 130.7932),
      ],
      strokeWidth: 8,
      strokeColor: Colors.black,
      fillColor: Colors.white,
    ));

    mapController?.moveCamera(CameraUpdate.newLatLngZoom(LatLng(-23.684, 133.903), 4));
  }
}

void main() => runApp(MaterialApp(home: MapsDirectionScreen()));
