import 'package:flutter/material.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class FormPage extends StatefulWidget {
  @override
  _FormPageState createState() => _FormPageState();
}

class _FormPageState extends State<FormPage> {
  File? _image;

  TextEditingController _parkingNameController = TextEditingController();
  TextEditingController _mobileNumberController = TextEditingController();

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
      return null; // Return null to indicate that image upload failed
    }
  }


  void _saveFormData() async {
    if (_image != null) {
      String imageName = DateTime.now().toString();
      String? imageUrl = await _uploadImageToStorage(_image!, imageName);

      if (imageUrl != null) {
        FirebaseFirestore.instance.collection("parkingData").add({
          'parkingName': _parkingNameController.text,
          'mobileNumber': _mobileNumberController.text,
          'imageUrl': imageUrl,
        });

        _parkingNameController.clear();
        _mobileNumberController.clear();
        setState(() {
          _image = null;
        });

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
      } else {
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
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
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
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(color: Colors.black),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [

              SizedBox(
                height: 50,
              ),
              _image != null
                  ? Image.file(
                _image!,
                height: 200,
              )
                  : Container(
                height: 40.0,
                width: 150,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30),
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
                child: Text('Pick an Image'),
              ),
                  ),
              SizedBox(height: 16),
              TextFormField(
                cursorColor: Colors.black87,
                controller: _parkingNameController,
                decoration: InputDecoration(
                  labelText: 'Parking Name',
                    labelStyle: TextStyle(color: Colors.black87),
                    focusColor: Colors.black87,
                    focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                            color: Colors.black87, width: 2
                        )
                    )
                ),
              ),
              SizedBox(height: 16),
              TextFormField(
                cursorColor: Colors.black87,
                controller: _mobileNumberController,
                decoration: InputDecoration(
                  labelText: 'Mobile Number',
                    labelStyle: TextStyle(color: Colors.black87),
                    focusColor: Colors.black87,
                    focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                            color: Colors.black87, width: 2
                        )
                    )
                ),
              ),
              SizedBox(height: 40),
              Container(
                height: 40.0,
                width: 150,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30),
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
                  child: Text('Save Form Data'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
