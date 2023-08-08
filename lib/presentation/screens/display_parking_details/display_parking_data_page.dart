import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:mapsss/presentation/colors/colors.dart';
import 'package:url_launcher/url_launcher.dart';

class DisplayParkingDataPage extends StatefulWidget {
  final String parkingName;
  final LatLng location;

  DisplayParkingDataPage({required this.parkingName, required this.location});

  @override
  State<DisplayParkingDataPage> createState() => _DisplayParkingDataPageState();
}

class _DisplayParkingDataPageState extends State<DisplayParkingDataPage> {
  String vechicalOption = 'Bike';
  Duration parkingTime = const Duration(hours: 1, minutes: 30);

  double ammount = 10.0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CustomColors.myHexColor,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "Parking Information :",
                style: TextStyle(
                    color: Color(0xff22308b),
                    fontWeight: FontWeight.w900,
                    fontSize: 24),
              ),
              Image.asset('assets/info.png'),
              const SizedBox(
                height: 20,
              ),
              Text(
                widget.parkingName,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(
                height: 25,
              ),
              const Text(
                "Selected What are you going to park",
                style: TextStyle(fontSize: 19, fontWeight: FontWeight.w700),
              ),
              const SizedBox(
                height: 35,
              ),
              Container(
                height: 50,
                width: 350,
                padding: const EdgeInsets.symmetric(horizontal: 15),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(
                      15,
                    ),
                    color: const Color(0xFF228b22).withOpacity(.7)),
                child: DropdownButtonHideUnderline(
                  child: DropdownButton(
                    value: vechicalOption,
                    style: const TextStyle(
                        fontWeight: FontWeight.w700,
                        fontSize: 17,
                        color: Colors.black45),
                    items: const [
                      DropdownMenuItem(
                        value: 'Bike',
                        child: Text('Bike'),
                      ),
                      DropdownMenuItem(
                        value: 'Car',
                        child: Text('Car'),
                      ),
                    ],
                    onChanged: (value) {
                      setState(() {
                        vechicalOption = value!;
                      });
                    },
                  ),
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        parkingTime -= const Duration(hours: 0, minutes: 30);
                        ammount -= 10;
                      });
                    },
                    child: Container(
                      height: 50,
                      width: 50,
                      padding: const EdgeInsets.symmetric(horizontal: 15),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(
                            10,
                          ),
                          color: const Color(0xFF228b22).withOpacity(.5)),
                      child: const Center(child: Icon(Icons.arrow_back_ios)),
                    ),
                  ),
                  const SizedBox(
                    width: 25,
                  ),
                  Text(
                    '${parkingTime.inHours}h: ${parkingTime.inMinutes}min',
                    style: const TextStyle(fontWeight: FontWeight.w600),
                  ),
                  const SizedBox(
                    width: 25,
                  ),
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        parkingTime += const Duration(hours: 0, minutes: 30);
                        ammount += 10;
                      });
                    },
                    child: Container(
                      height: 50,
                      width: 50,
                      padding: const EdgeInsets.symmetric(horizontal: 15),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(
                            10,
                          ),
                          color: const Color(0xFF228b22).withOpacity(.5)),
                      child: const Center(child: Icon(Icons.arrow_forward_ios)),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 30,
              ),
              Center(
                child: Text(
                  "Total ammount: ₹" + ammount.toString(),
                  style: TextStyle(fontWeight: FontWeight.w700),
                ),
              ), SizedBox(
                height: 50,
              ),
              Center(
                child: Column(
                  children: [
                    Row(
                      children: [
                        ElevatedButton(
                          onPressed: () {
                            openGoogleMapsNavigation();
                          },
                          style: ElevatedButton.styleFrom(
                            primary: Colors.black.withOpacity(0.8),
                            elevation: 0,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15),
                            ),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Text(
                              'Navigate to Parking',
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                        Container(
                            height: 50,
                            width: 100,
                            padding: const EdgeInsets.symmetric(horizontal: 15),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(
                                  15,
                                ),
                                color: const Color(0xFF228b22).withOpacity(.5)),
                            child: Center(child: Image.asset('assets/google-pay.png'))),
                      ],
                    ),


                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  void openGoogleMapsNavigation() async {
    // Construct the Google Maps URL with the selected parking location and the current location
    String parkingLocation = '${widget.location.latitude},${widget.location.longitude}';
    String currentLocation = 'your_current_latitude,your_current_longitude'; // Replace with the actual current location

    String url = 'https://www.google.com/maps/dir/?api=1&destination=$parkingLocation&origin=$currentLocation&travelmode=driving';

    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

}
