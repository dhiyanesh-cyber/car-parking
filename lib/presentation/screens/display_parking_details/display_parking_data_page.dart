import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:mapsss/presentation/colors/colors.dart';

class DisplayParkingDataPage extends StatefulWidget {
  final String parkingName;
  final LatLng location;

  DisplayParkingDataPage({required this.parkingName, required this.location});

  @override
  State<DisplayParkingDataPage> createState() => _DisplayParkingDataPageState();
}

class _DisplayParkingDataPageState extends State<DisplayParkingDataPage> {
  String vechicalOption = 'Bike';
  Duration parkingTime = const Duration(hours: 0, minutes: 00);

  double ammount = 0.0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CustomColors.myHexColor,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: CustomColors.myHexColor,
        title: Text(
          'Parking Information',
          textAlign: TextAlign.center,
          style: TextStyle(
                    color: Colors.black87,
                    fontWeight: FontWeight.w500,
                    fontSize: 20),
        ),
        elevation: 0,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              
              Image.asset('assets/info.png'),
              const SizedBox(
                height: 20,
              ),
              Text(
                widget.parkingName,
                style: const TextStyle(
                  fontSize: 19,
                  fontWeight: FontWeight.w700,
                ),
              ),
              const SizedBox(
                height: 25,
              ),
              const Text(
                "Selected What are you going to park",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
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
                    color: Color(0xFFc86868)),
                child: DropdownButtonHideUnderline(
                  child: DropdownButton(
                    iconEnabledColor: Colors.black87,
                    dropdownColor: CustomColors.myHexColorDark,
                    value: vechicalOption,
                    style: const TextStyle(
                        fontWeight: FontWeight.w700,
                        fontSize: 17,
                        color: Colors.black87),
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
                        if(ammount > 0)
{                       parkingTime -= const Duration(hours: 1, minutes: 00);
                        ammount -= 5;
                        } 
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
                          color: Color(0xFFc86868).withOpacity(.8)),
                      child: const Center(child: Icon(Icons.arrow_back_ios)),
                    ),
                  ),
                  const SizedBox(
                    width: 25,
                  ),
                  Text(
                    '${parkingTime.inHours}h: 00min',
                    style: const TextStyle(fontWeight: FontWeight.w600),
                  ),
                  const SizedBox(
                    width: 25,
                  ),
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        parkingTime += const Duration(hours: 1, minutes: 00);
                        ammount += 5;
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
                          color: const Color(0xFFc86868).withOpacity(.8)),
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
                child: Container(
                    height: 50,
                    width: 100,
                    padding: const EdgeInsets.symmetric(horizontal: 15),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(
                          15,
                        ),
                        color: Color(0xFFc86868)),
                    child: Center(child: Image.asset('assets/google-pay.png'))),
              )
            ],
          ),
        ),
      ),
    );
  }
}
