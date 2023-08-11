import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:ParkMe/presentation/colors/colors.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:android_intent_plus/android_intent.dart';
import 'package:pay/pay.dart';
import 'package:geolocator/geolocator.dart';
import 'package:ParkMe/presentation/screens/display_parking_details/payment.dart';
import 'testGpay.dart';

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
       String defaultGooglePay = '''{
  "provider": "google_pay",
  "data": {
    "environment": "TEST",
    "apiVersion": 2,
    "apiVersionMinor": 0,
    "allowedPaymentMethods": [
      {
        "type": "CARD",
        "tokenizationSpecification": {
          "type": "PAYMENT_GATEWAY",
          "parameters": {
            "gateway": "example",
            "gatewayMerchantId": "gatewayMerchantId"
          }
        },
        "parameters": {
          "allowedCardNetworks": ["VISA", "MASTERCARD"],
          "allowedAuthMethods": ["PAN_ONLY", "CRYPTOGRAM_3DS"],
          "billingAddressRequired": true,
          "billingAddressParameters": {
            "format": "FULL",
            "phoneNumberRequired": true
          }
        }
      }
    ],
    "merchantInfo": {
      "merchantId": "01234567890123456789",
      "merchantName": "Example Merchant Name"
    },
    "transactionInfo": {
      "countryCode": "IN",
      "currencyCode": "INR"
    }
  }
}''';

    // Create the payment items.
    final paymentItems = [
      PaymentItem(
        label: "My Product",
        amount: "10.00",
        status: PaymentItemStatus.final_price,
        
      ),
    ];

    void onGooglePayResult(dynamic paymentResult) {
      debugPrint(paymentResult.toString());
  // Send the resulting Google Pay token to your server / PSP
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CustomColors.myHexColor,
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(Icons.arrow_back_ios_rounded),
        ),
        iconTheme: IconThemeData(color: Colors.black),
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
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Image.asset('assets/payment.png'),
              const SizedBox(
                height: 20,
              ),
              Center(
                child: Text(
                  widget.parkingName,
                  style: const TextStyle(
                    fontSize: 19,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
              SizedBox(
                height: 25,
              ),
              Center(
                child: Text(
                  "Select What are you going to park",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Container(
                height: 50,
                width: 350,
                padding: const EdgeInsets.symmetric(horizontal: 15),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(
                      15,
                    ),
                    color: Color(0xFFc86868).withOpacity(.8)),
                child: DropdownButtonHideUnderline(
                  child: DropdownButton(
                    iconEnabledColor: CustomColors.myHexColorLight,
                    dropdownColor: Color(0xFFc86868),
                    value: vechicalOption,
                    style: const TextStyle(
                        fontWeight: FontWeight.w700,
                        fontSize: 17,
                        color: CustomColors.myHexColorLight),
                    items: const [
                      DropdownMenuItem(
                        value: 'Bike',
                        child: Text('Two wheeler'),
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
                        if (ammount > 0) {
                          parkingTime -= const Duration(hours: 1, minutes: 00);
                          ammount -= 5;
                        }
                      });
                    },
                    child: Container(

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
                  "Total amount: ₹" + ammount.toString(),
                  style: TextStyle(fontWeight: FontWeight.w700),
                ),
              ),
              SizedBox(
                height: 50,
              ),
              Center(
                child: Column(
                  children: [
                  Container(
                        height: 50,
                        width: 100,
                        padding: const EdgeInsets.symmetric(horizontal: 15),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          color: const Color(0xFFc86868).withOpacity(0.8),
                        ),
                        child: ElevatedButton(
                          onPressed: () {
                            // Add your pay button's onPressed logic here
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => App(),
                              ),
                            );
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.transparent,
                            elevation: 0,  // Set text color
                          ),
                          child: Text('Pay', style: TextStyle(color: CustomColors.myHexColorLight),),
                        ),






                    ),
                  ],
                ),
              ),
              SizedBox(height: 30,)
            ],
          ),
        ),
      ),
      bottomNavigationBar: Container(

        padding: const EdgeInsets.all(20.0),
        child: ElevatedButton(
          onPressed: () {
            openGoogleMapsNavigation();
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: Color(0xFFc86868).withOpacity(0.8),
            elevation: 0,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
          ),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              'Navigate',
              style: TextStyle(
                fontSize: 16,
                color: CustomColors.myHexColorLight,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ),
    );
  }



  void openGoogleMapsNavigation() async {

    Position position = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high,
    );

    // Construct the Google Maps URL with the selected parking location and the current location
    String parkingLocation = '${widget.location.latitude},${widget.location.longitude}';
    String currentLocation =  '${position.latitude},${position.longitude}'; // Replace with the actual current location

    String url = 'https://www.google.com/maps/dir/?api=1&destination=$parkingLocation&origin=$currentLocation&travelmode=driving';

    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

void openGooglePayApp(String recipientVPA, String recipientName, double amount) async {
    final String googlePayPackageName = "com.google.android.apps.nbu.paisa.user";
    String encodedVPA = Uri.encodeComponent(recipientVPA);
    String encodedName = Uri.encodeComponent(recipientName);

    final Uri uri = Uri(
      scheme: "upi",
      path: "pay",
      queryParameters: {
        "pa": encodedVPA,
        "pn": encodedName, // Recipient's name
        "mc": "",            // Merchant code (optional)
        "tr": "txn_${DateTime.now().millisecondsSinceEpoch}", // Unique transaction reference ID
        "tn": "Sending money", // Transaction note
        "am": amount.toStringAsFixed(2), // Transaction amount
        "cu": "INR",         // Currency code
        "url": "",           // Transaction URL (optional)
      },
    );

    if (await canLaunch(uri.toString())) {
      await launch(uri.toString(), forceSafariVC: false);
    } else {
      // Handle if the app is not installed or cannot be opened.
      // You can show an error message or take appropriate action.
      print('Google Pay app not installed or cannot be opened.');
    }
  }
}


