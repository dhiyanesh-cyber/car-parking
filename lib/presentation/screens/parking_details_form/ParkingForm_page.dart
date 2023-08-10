import 'package:flutter/material.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:location/location.dart';
import 'package:geolocator/geolocator.dart';
import 'package:ParkMe/presentation/colors/colors.dart';

class FormPage extends StatefulWidget {
  @override
  _FormPageState createState() => _FormPageState();
}

class _FormPageState extends State<FormPage> {
  File? _image;
  bool _provideLocation = false; // Flag to indicate whether user wants to provide location
  Location _location = Location();
  Position? _userLocation; // Location data of the user

  TextEditingController _parkingNameController = TextEditingController();
  TextEditingController _mobileNumberController = TextEditingController();

  // Function to pick an image from gallery
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

  // Function to upload image to Firebase Storage
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
      return null; // Return null to indicate that image upload failed
    }
  }

  void _getLocation() async {
    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      // Location permission has not been granted yet
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        // Permission request was denied by the user
        return;
      }
    }

    if (permission == LocationPermission.deniedForever) {
      // The user has previously denied the permission permanently
      // You can open app settings here and ask the user to enable the permission manually
      return;
    }

    // Get the user's location
    Position position = await Geolocator.getCurrentPosition();
    setState(() {
      _userLocation = position;
    });
  }

  void _saveFormData() async {
    if (!_provideLocation) {
      // Show an alert asking the user to turn on location services
      _showEnableLocationAlert();
      return;
    }

    if (_userLocation != null && _image != null) {
      String imageName = DateTime.now().toString();
      String? imageUrl = await _uploadImageToStorage(_image!, imageName);

      if (imageUrl != null) {
        // Save the form data along with user's location data
        FirebaseFirestore.instance.collection("parkingData").add({
          'parkingName': _parkingNameController.text,
          'mobileNumber': _mobileNumberController.text,
          'imageUrl': imageUrl,
          'latitude': _userLocation!.latitude,
          'longitude': _userLocation!.longitude,
        });

        _parkingNameController.clear();
        _mobileNumberController.clear();
        setState(() {
          _image = null;
          _provideLocation = false;
          _userLocation = null;
        });

        // Show a success dialog
        _showSuccessDialog();
      } else {
        // Show an error dialog
        _showErrorDialog();
      }
    }
  }

  // Function to show an alert to enable location services
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

  // Function to show a success dialog
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
                Navigator.of(context).pop();
              },
              child: Text('OK'),
            ),
          ],
        );
      },
    );
  }

  // Function to show an error dialog
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
          padding: const EdgeInsets.only(left:30, right: 30),
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
                  child: Text('Pick an Image',style: TextStyle(color: CustomColors.myHexColor),),
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
                      contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 14),
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
                      contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 14),
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
                  child: Text('Save Form Data',style: TextStyle(color: CustomColors.myHexColor),),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

void main() {
  runApp(MaterialApp(
    home: FormPage(),
  ));
}
