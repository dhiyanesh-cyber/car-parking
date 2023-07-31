import 'package:flutter/material.dart';
import 'parking_loading_widget.dart';

class LoadingScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Replace this with your actual loading logic
    Future.delayed(Duration(seconds: 2), () {
      // Navigate to the home screen after the loading process is completed
      Navigator.pushReplacementNamed(context, '/home');
    });

    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: ParkingLoadingWidget(), // Replace this with your custom loading widget
      ),
    );
  }
}



