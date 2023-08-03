import 'package:flutter/material.dart';

class ParkingLoadingWidget extends StatefulWidget {
  @override
  _ParkingLoadingWidgetState createState() => _ParkingLoadingWidgetState();
}

class _ParkingLoadingWidgetState extends State<ParkingLoadingWidget>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: Duration(seconds: 1),
    )..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Image.asset(
          'assets/Park me-logos_black.png', // Replace 'my_image.png' with your actual image path
          width: 100, // Set the desired width for the image
          height: 100, // Set the desired height for the image
        ),
        SizedBox(height: 16), // Add some spacing between the image and text
        Text(
          "By Spartechans...",
          style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
        ),
      ],
    );
  }
}
