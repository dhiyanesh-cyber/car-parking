import 'package:flutter/material.dart';


class DetailsPage extends StatelessWidget {
  final String imageUrl;
  final String parkingName;
  final String mobileNumber;

  DetailsPage({
    required this.imageUrl,
    required this.parkingName,
    required this.mobileNumber,
  });

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
          'Details',
          style: TextStyle(color: Colors.black),
        ),
        elevation: 0,
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(color: Colors.black),
      ),
      body: SingleChildScrollView(
        child: Container(
          alignment: Alignment.topCenter,
          margin: EdgeInsets.only(left: 30, right: 30),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                height: 50,
              ),
              ClipRRect(
                borderRadius: BorderRadius.circular(10), // Apply border radius here
                child: Image.network(
                  imageUrl,
                  height: 200,
                ),
              ),
              SizedBox(height: 40),
              Text(
                'Parking Name: $parkingName',
                style: TextStyle(fontSize: 20),
              ),
              SizedBox(height: 16),
              Text(
                'Mobile Number: $mobileNumber',
                style: TextStyle(fontSize: 18),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
