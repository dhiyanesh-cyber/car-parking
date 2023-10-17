import 'package:ParkMe/presentation/parking_owners_screen/success_page.dart';
import 'package:flutter/material.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:location/location.dart';
import 'package:geolocator/geolocator.dart';
import 'package:ParkMe/colors/colors.dart';

class RegisterParkingPage extends StatefulWidget {
  @override
  _RegisterParkingPageState createState() => _RegisterParkingPageState();
}

class _RegisterParkingPageState extends State<RegisterParkingPage> {
  File? _image;
  bool _provideLocation = false;
  Location _location = Location();
  Position? _userLocation;

  TextEditingController _parkingNameController = TextEditingController();
  TextEditingController _mobileNumberController = TextEditingController();
  TextEditingController _totalSlotsController = TextEditingController();
  TextEditingController _chargePerHourController = TextEditingController();

  Future getImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
      } else {
        print('No image selected.');
      }
    });
  }

  Future<String?> _uploadImageToStorage(File imageFile, String imageName) async {
    try {
      final storage = FirebaseStorage.instance;
      final imageRef = storage.ref().child('images/$imageName');
      final uploadTask = imageRef.putFile(imageFile);
      final snapshot = await uploadTask.whenComplete(() {});
      final downloadUrl = await snapshot.ref.getDownloadURL();
      return downloadUrl;
    } catch (error) {
      print('Error uploading image to Firebase Storage: $error');
      return null;
    }
  }

  void _getLocation() async {
    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return;
      }
    }

    if (permission == LocationPermission.deniedForever) {
      return;
    }

    Position position = await Geolocator.getCurrentPosition();
    setState(() {
      _userLocation = position;
    });
  }

  void _saveFormData() async {
    if (!_provideLocation) {
      _showEnableLocationAlert();
      return;
    }

    if (_userLocation != null && _image != null) {
      String imageName = DateTime.now().toString();
      String? imageUrl = await _uploadImageToStorage(_image!, imageName);

      if (imageUrl != null) {
        int totalParkingSlots = int.tryParse(_totalSlotsController.text) ?? 0;
        double chargePerHour = double.tryParse(_chargePerHourController.text) ?? 0.0;

        String mobileNumber = _mobileNumberController.text;
        if (mobileNumber.length != 10) {
          _showMobileNumberErrorAlert();
          return;
        }

        showDialog(
          context: context,
          barrierDismissible: false,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text('Saving Data'),
              content: CircularProgressIndicator(),
            );
          },
        );

        await FirebaseFirestore.instance.collection("parkingData").add({
          'parkingName': _parkingNameController.text,
          'mobileNumber': mobileNumber,
          'imageUrl': imageUrl,
          'latitude': _userLocation!.latitude,
          'longitude': _userLocation!.longitude,
          'totalParkingSlots': totalParkingSlots,
          'chargePerHour': chargePerHour,
        });

        Navigator.of(context).pop();

        _parkingNameController.clear();
        _mobileNumberController.clear();
        _totalSlotsController.clear();
        _chargePerHourController.clear();

        setState(() {
          _image = null;
          _provideLocation = false;
          _userLocation = null;
        });

        _showSuccessDialog();
      } else {
        _showErrorDialog();
      }
    }
  }

  void _showMobileNumberErrorAlert() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Invalid Mobile Number'),
          content: Text('Mobile number must be exactly 10 digits long.'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('OK'),
            ),
          ],
        );
      },
    );
  }

  void _showEnableLocationAlert() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Turn on Location'),
          content: Text('Please turn on location services to provide your location.'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                _location.requestService();
              },
              child: Text('OK'),
            ),
          ],
        );
      },
    );
  }

  void _showSuccessDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Success'),
          content: Text('Form data saved successfully!'),
          actions: [
            TextButton(
              onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => SuccessPage(),
                ),
              );
            },
              child: Text('OK'),
            ),
          ],
        );
      },
    );
  }

  void _showErrorDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Error'),
          content: Text('Failed to save form data.'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('OK'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CustomColors.myHexColor,
      appBar: AppBar(
        centerTitle: true,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(Icons.arrow_back_ios_rounded),
        ),
        title: Text(
          'Fill the form',
          style: TextStyle(color: Colors.black),
        ),
        elevation: 0,
        backgroundColor: CustomColors.myHexColor,
        iconTheme: IconThemeData(color: Colors.black),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(left: 30, right: 30),
          child: Column(
            children: [
              Image.asset('assets/form.png'),
              _image != null
                  ? Image.file(
                      _image!,
                      height: 200,
                    )
                  : Container(
                      height: 50.0,
                      width: 130,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        gradient: LinearGradient(
                          colors: [Colors.black87, Colors.grey.shade800],
                        ),
                      ),
                      child: ElevatedButton(
                        onPressed: getImage,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.transparent,
                          shadowColor: Colors.transparent,
                        ),
                        child: Text(
                          'Pick an Image',
                          style: TextStyle(color: CustomColors.myHexColor),
                        ),
                      ),
                    ),
              SizedBox(height: 24),
              Container(
                decoration: BoxDecoration(
                  color: CustomColors.myHexColorDark,
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(7.0),
                  child: TextFormField(
                    cursorColor: Colors.black87,
                    controller: _parkingNameController,
                    decoration: InputDecoration(
                      hintText: 'Your Parking Name',
                      labelStyle: TextStyle(color: Colors.black87),
                      border: InputBorder.none,
                      contentPadding:
                          EdgeInsets.symmetric(horizontal: 20, vertical: 14),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 24),
              Container(
                decoration: BoxDecoration(
                  color: CustomColors.myHexColorDark,
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                    cursorColor: Colors.black87,
                    controller: _mobileNumberController,
                    decoration: InputDecoration(
                      hintText: 'Mobile Number',
                      labelStyle: TextStyle(color: Colors.black87),
                      border: InputBorder.none,
                      contentPadding:
                          EdgeInsets.symmetric(horizontal: 20, vertical: 14),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 24,
              ),
              Container(
                decoration: BoxDecoration(
                  color: CustomColors.myHexColorDark,
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextField(
                    cursorColor: Colors.black87,
                    controller: _totalSlotsController,
                    decoration: InputDecoration(
                      hintText: 'Total number of parking slots',
                      labelStyle: TextStyle(color: Colors.black87),
                      border: InputBorder.none,
                      contentPadding:
                          EdgeInsets.symmetric(horizontal: 20, vertical: 14),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 10),
              Container(
                decoration: BoxDecoration(
                  color: CustomColors.myHexColorDark,
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextField(
                    cursorColor: Colors.black87,
                    controller: _chargePerHourController,
                    decoration: InputDecoration(
                      hintText: 'Charge per hour',
                      labelStyle: TextStyle(color: Colors.black87),
                      border: InputBorder.none,
                      contentPadding:
                          EdgeInsets.symmetric(horizontal: 20, vertical: 14),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('Provide Location\n(Make sure you are in your parking !)'),
                  SizedBox(width: 10),
                  Switch(
                    activeColor: CustomColors.myHexColorDarkest,
                    value: _provideLocation,
                    onChanged: (value) {
                      setState(() {
                        _provideLocation = value;
                        if (_provideLocation) {
                          _getLocation();
                        }
                      });
                    },
                  ),
                ],
              ),
              SizedBox(height: 20),
              Container(
                height: 60.0,
                width: 300,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  gradient: LinearGradient(
                    colors: [Colors.black87, Colors.grey.shade800],
                  ),
                ),
                child: ElevatedButton(
                  onPressed: _saveFormData,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.transparent,
                    shadowColor: Colors.transparent,
                  ),
                  child: Text('Save Form Data',
                      style: TextStyle(color: CustomColors.myHexColor)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
