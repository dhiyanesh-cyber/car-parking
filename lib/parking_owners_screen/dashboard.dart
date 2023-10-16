import 'package:ParkMe/parking_owners_screen/parking_register_screen.dart';
import 'package:flutter/material.dart';

class DashboardPage extends StatelessWidget {
  final String username;

  DashboardPage({required this.username});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Welcome, $username'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text('Hi $username, Welcome to ParkMe! Register your parkings to help the community.'),
          ElevatedButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => RegisterParkingPage(),
                ),
              );
            },
            child: Text('Register Your Parking'),
          ),
          // Add other dashboard elements here
        ],
      ),
    );
  }
}
