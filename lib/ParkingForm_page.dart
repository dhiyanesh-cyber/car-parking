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
    final storage = FirebaseStorage.instance;
    final imageRef = storage.ref().child('images/$imageName');
    final uploadTask = imageRef.putFile(imageFile);
    final snapshot = await uploadTask.whenComplete(() {});
    final downloadUrl = await snapshot.ref.getDownloadURL();
    return downloadUrl;
  }

  void _saveFormData() async {
    if (_image != null) {
      String imageName = DateTime.now().toString();
      String? imageUrl = await _uploadImageToStorage(_image!, imageName);

      if (imageUrl != null) {
        FirebaseFirestore.instance.collection('parkingData').add({
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
        title: Text('Fill the Form'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              _image != null
                  ? Image.file(
                _image!,
                height: 200,
              )
                  : ElevatedButton(
                onPressed: getImage,
                child: Text('Pick an Image'),
              ),
              SizedBox(height: 16),
              TextFormField(
                controller: _parkingNameController,
                decoration: InputDecoration(
                  labelText: 'Parking Name',
                ),
              ),
              SizedBox(height: 16),
              TextFormField(
                controller: _mobileNumberController,
                decoration: InputDecoration(
                  labelText: 'Mobile Number',
                ),
              ),
              SizedBox(height: 16),
              ElevatedButton(
                onPressed: _saveFormData,
                child: Text('Save Form Data'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
