import 'package:flutter/material.dart';
import 'package:location/location.dart';
import 'package:ParkMe/presentation/colors/colors.dart';
import '../display_parking_details/display_parking_data_page.dart';
import '../parking_Details/parking_details_page.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import '../../Func/parking_data_service.dart';
import '../../Func/parking_dialog.dart';
import 'package:ParkMe/presentation/screens/map_view/map_utils.dart';

class ParkingMapView extends StatefulWidget {
  final int isFirst;

  ParkingMapView({required this.isFirst});

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

  // Define the list of LatLng locations for parking spots
  List<LatLng> latlang = [
    LatLng(9.914540330991873, 78.11396268654826),
    LatLng(9.94970300044104, 78.02092294426797),
    LatLng(9.929912407504423, 78.13872093995883),
    LatLng(9.91977926967325, 78.11982459393568),
    LatLng(9.920376832315313, 78.1213395037362),
    LatLng(9.913666874803905, 78.12629729762934),
    LatLng(9.910817942643579, 78.14752226394555),
    LatLng(9.91520620649439, 78.12376839201691),
  ];

  @override
  void initState() {
    _getLocation();
    _initializeMap();
    super.initState();
  }

  Future<void> _initializeMap() async {
    parkingDataList = await ParkingDataService.fetchParkingData();
    _showParkingMarkers(parkingDataList);
    // print(widget.isFirst);
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
                      backgroundColor: Colors.black.withOpacity(0.85),
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
          child: Icon(Icons.my_location, color: CustomColors.myHexColor),
        ),
      ),
    );
  }

  void _showParkingPopup(String parkingName, LatLng location, int slots) {
    showModalBottomSheet<void>(
      context: context,
      builder: (BuildContext context) {
        return Container(
          decoration: BoxDecoration(
            color: CustomColors.myHexColor,
          ),
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
                Text(
                  'CCTV Availability: Yes',
                  style: TextStyle(
                    fontWeight: FontWeight.normal,
                    fontSize: 14,
                  ),
                ),
                SizedBox(height: 10),
                Text(
                  'EV Charging Availability: Yes',
                  style: TextStyle(
                    fontWeight: FontWeight.normal,
                    fontSize: 14,
                  ),
                ),
                SizedBox(height: 20),
                Container(
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color(0xFFc86868).withOpacity(0.8),
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                    ),
                    onPressed: () {
                      Navigator.pop(context);
                      _navigateToParkingDetailsPage(parkingName, location, slots);
                    },
                    child: Text('Details'),
                  ),
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

  Future<void> _getLocation() async {
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

    LocationData? locationData;
    locationData = await _location.getLocation();
    LatLng currentLocation = (widget.isFirst == -1)
        ? LatLng(locationData.latitude!, locationData.longitude!)
        : latlang[widget.isFirst];
    _currentLocation = currentLocation;
    MapUtils.zoomToLocation(_mapController, _currentLocation);
    setState(() {
      _showParkingMarkers(parkingDataList);
    });
  }

  Future<void> _showParkingMarkers(List<Map<String, dynamic>> parkingDataList) async {
    BitmapDescriptor customMarker = await BitmapDescriptor.fromAssetImage(
      ImageConfiguration(size: Size(5, 5)),
      'assets/park.png',
    );

    setState(() {
      _parkingMarkers.clear();
      _parkingMarkers.add(
        Marker(
          markerId: MarkerId("user_location"),
          position: _currentLocation,
          icon: BitmapDescriptor.defaultMarker,
        ),
      );

      parkingDataList.forEach((parkingData) {
        double latitude = parkingData['latitude'];
        double longitude = parkingData['longitude'];
        String parkingName = parkingData['parkingName'];
        int slots = parkingData['slots'];
        LatLng parkingLocation = LatLng(latitude, longitude);

        _parkingMarkers.add(
          Marker(
            markerId: MarkerId(parkingName),
            position: parkingLocation,
            icon: customMarker,
            infoWindow: InfoWindow(
              title: parkingName,
              snippet: slots > 0 ? "Available slots: $slots" : "No available slots",
              onTap: () {
                _showParkingPopup(parkingName, parkingLocation, slots);
              },
            ),
          ),
        );
      });
    });
  }

  void _showParkingListDialog() {
    ParkingDialog.showParkingListDialog(
      context,
      parkingDataList,
      _currentLocation,
      _navigateToParkingDetailsPage,
    );
  }

  void _navigateToParkingDetailsPage(String parkingName, LatLng location, int slots) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => DisplayParkingDataPage(
          parkingName: parkingName,
          location: location,
          totalSlots: slots,
        ),
      ),
    );
  }

  void _onMapCreated(GoogleMapController controller) {
    _mapController = controller;
  }

  void _showMyLocation() async {
    LocationData locationData = await _location.getLocation();
    LatLng currentLocation = LatLng(locationData.latitude!, locationData.longitude!);
    MapUtils.zoomToLocation(_mapController, currentLocation);
  }

  void _onMarkerTapped(MarkerId markerId) async {
    if (markerId.value == 'user_location') {
      return;
    }

    Map<String, dynamic>? selectedParkingData = parkingDataList.firstWhere(
      (parkingData) => parkingData['parkingName'] == markerId.value,
      // orElse: () => null,
    );

    

    double latitude = selectedParkingData['latitude'];
    double longitude = selectedParkingData['longitude'];
    LatLng selectedParkingLocation = LatLng(latitude, longitude);

    LocationData locationData = await _location.getLocation();
    LatLng currentLocation = LatLng(locationData.latitude!, locationData.longitude!);

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
