import 'package:flutter/material.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:location/location.dart';
import 'package:ParkMe/presentation/colors/colors.dart';
import 'package:ParkMe/presentation/screens/display_parking_details/DisplayParkingData_page.dart';
import 'package:ParkMe/presentation/screens/settings/settings_page.dart';
import 'package:ParkMe/presentation/screens/home/simple_starting_screen.dart';
import '../display_parking_details/display_parking_data_page.dart';
import '../parking_Details/parking_details_page.dart';
import '../../common/nav_animation/navigateWithAnimation.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import '../../Func/parking_data_service.dart';
import '../../Func/parking_dialog.dart';
import '../display_parking_details/display_parking_data_page.dart';
import 'package:ParkMe/presentation/screens/map_view/map_utils.dart';



class ParkingMapView extends StatefulWidget {
  @override
  _ParkingMapViewState createState() => _ParkingMapViewState();
}

class _ParkingMapViewState extends State<ParkingMapView> {
  GoogleMapController? _mapController;
  Location _location = Location();
  LatLng _currentLocation = LatLng(9.939093, 78.121719);
  Set<Marker> _parkingMarkers = {};
  List<Map<String, dynamic>> parkingDataList = [];
  late LocationData locationData;

  @override
  void initState() {
    super.initState();
    _initializeMap();
  }

  Future<void> _initializeMap() async {
    await _getLocation();
    parkingDataList = await ParkingDataService.fetchParkingData();
    _showParkingMarkers(parkingDataList);
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(

      backgroundColor: Colors.white,
      body: SafeArea(
        bottom: false,
        child: Stack(

          children: [
            GoogleMap(
              onMapCreated: _onMapCreated,
              initialCameraPosition: CameraPosition(
                target: _currentLocation,
                zoom: 10.0,
              ),
              markers: _parkingMarkers,
              zoomControlsEnabled: false,
            ),

            Container(
              margin: EdgeInsets.only(bottom: 60),
              child: Align(
                alignment: Alignment.bottomCenter,
                child: Padding(

                  padding: const EdgeInsets.only(bottom: 20),
                  child: ElevatedButton(
                    onPressed: _showParkingListDialog,
                    style: ElevatedButton.styleFrom(
                      primary: Colors.black.withOpacity(0.85),
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                    ),



                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Text(
                        'Nearby Parking',
                        style: TextStyle(
                          color: CustomColors.myHexColor,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),

                ),

              ),
            ),

          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.startFloat,
      floatingActionButton: Container(
        margin: EdgeInsets.only(bottom: 60),
        child: FloatingActionButton(
          backgroundColor: Colors.black87,
          onPressed: _showMyLocation,
          child: Icon(Icons.my_location, color: CustomColors.myHexColor,),
        ),
      ),
    );
  }

  void _showParkingPopup(String parkingName, LatLng location) {
    showModalBottomSheet<void>(
      context: context,
      builder: (BuildContext context) {
        return Container(
          decoration: BoxDecoration(borderRadius: BorderRadius.only(topLeft: Radius.circular(16), topRight: Radius.circular(16))),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  parkingName,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),


                SizedBox(height: 20),
                ElevatedButton(

                  onPressed: () {
                    Navigator.pop(context); // Close the popup
                    _navigateToParkingDetailsPage(parkingName, location);
                  },
                  child: Text('Details'),
                ),
              ],
            ),
          ),
        );
      },
    );
  }



  Future<void> _fetchParkingData() async {
    parkingDataList = await ParkingDataService.fetchParkingData();
  }

  // Show the user's current location on the map and display parking markers
  Future<void> _getLocation() async {
    // Check and request location service and permission
    bool serviceEnabled;
    PermissionStatus permissionGranted;
    

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

    // Get the user's current location
    LocationData? locationData; // Note the nullable type

if (locationData == null) {
  locationData = await _location.getLocation();
}

    LatLng currentLocation = LatLng(locationData.latitude!, locationData.longitude!);
    _currentLocation = currentLocation;
    // Fetch and show the parking markers on the map
    MapUtils.zoomToLocation(_mapController, _currentLocation);

    setState(() {
      // Use the zoomToLocation function

      _showParkingMarkers(parkingDataList);
    });
  }

  // Show the parking markers on the map
  Future<void> _showParkingMarkers(List<Map<String, dynamic>> parkingDataList) async {
    // Load custom marker image for parking locations
    BitmapDescriptor customMarker = await BitmapDescriptor.fromAssetImage(
      ImageConfiguration(size: Size(5, 5)),
      'assets/park.png',
    );

    setState(() {
      _parkingMarkers.clear();
      // Add the marker for the user's current location
      _parkingMarkers.add(
        Marker(
          markerId: MarkerId("user_location"),
          position: _currentLocation,
          icon: BitmapDescriptor.defaultMarker,
        ),
      );

      // Add markers for parking locations with names
      parkingDataList.forEach((parkingData) {
        double latitude = parkingData['latitude'];
        double longitude = parkingData['longitude'];
        String parkingName = parkingData['parkingName'];
        LatLng parkingLocation = LatLng(latitude, longitude);

        // Add the parking marker to the set of markers
        _parkingMarkers.add(
          Marker(
            markerId: MarkerId(parkingName),
            position: parkingLocation,
            icon: customMarker,
            onTap: () {
              // Navigate to the parking details page when the marker is tapped
              // _navigateToParkingDetailsPage(parkingName, parkingLocation);
              _showParkingPopup(parkingName, parkingLocation);
              // _onMarkerTapped(MarkerId(parkingName));
            },
          ),
        );
      });
    });
  }

  // Show the parking list dialog with sorted parking locations
  void _showParkingListDialog() {
    ParkingDialog.showParkingListDialog(
      context,
      parkingDataList, // Pass the parkingDataList as a parameter
      _currentLocation, // User's current location
      _navigateToParkingDetailsPage, // Function to navigate to the details page
    );
  }

  // Navigate to the parking details page
  void _navigateToParkingDetailsPage(String parkingName, LatLng location) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => DisplayParkingDataPage(
          parkingName: parkingName,
          location: location,
        ),
      ),
    );
  }

  void _onMapCreated(GoogleMapController controller) {
    _mapController = controller;
  }


  void _showMyLocation() async {
    // Show the user's current location on the map
    LocationData locationData = await _location.getLocation();
    LatLng currentLocation = LatLng(locationData.latitude!, locationData.longitude!);
    MapUtils.zoomToLocation(_mapController, currentLocation); // Use the zoomToLocation function
  }


  //-------------------------------------------------------------------------- NAVIGATION LINES IMPLEMENTATION-----------------------------------------------------------------------------------------------------------------

  // Called when a parking marker is tapped
  void _onMarkerTapped(MarkerId markerId) async {
    if (markerId.value == 'user_location') {
      // If the user taps on their own location marker, do nothing.
      return;
    }

    // Find the selected parking data based on the markerId
    Map<String, dynamic>? selectedParkingData;
    for (var parkingData in parkingDataList) {
      if (parkingData['parkingName'] == markerId.value) {
        selectedParkingData = parkingData;
        break;
      }
    }

    if (selectedParkingData == null) {
      return;
    }

    // Get the LatLng of the selected parking
    double latitude = selectedParkingData['latitude'];
    double longitude = selectedParkingData['longitude'];
    LatLng selectedParkingLocation = LatLng(latitude, longitude);

    // Get the user's current location
    LocationData locationData = await _location.getLocation();
    LatLng currentLocation = LatLng(locationData.latitude!, locationData.longitude!);

    // Navigate to the parking details page and pass the required data
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ParkingDetailsPage(
          parkingName: markerId.value.toString(),
          parkingLocation: selectedParkingLocation,
          currentLocation: currentLocation,
        ),
      ),
    );
  }





}