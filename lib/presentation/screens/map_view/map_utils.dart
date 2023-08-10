import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapUtils {
  static void zoomToLocation(GoogleMapController? mapController, LatLng location, {double zoomLevel = 15.0}) {
    mapController?.animateCamera(CameraUpdate.newLatLngZoom(location, zoomLevel));
  }
}
