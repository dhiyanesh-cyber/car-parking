import 'package:flutter/material.dart';

class SampleDetailsPage extends StatelessWidget {
  final String sample;

  SampleDetailsPage({required this.sample});

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
          'Sample Details',
          style: TextStyle(color: Colors.black),
        ),
        elevation: 0,
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(color: Colors.black),
      ),
      body: Center(
        child: Text(
          'Sample Details for $sample',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
