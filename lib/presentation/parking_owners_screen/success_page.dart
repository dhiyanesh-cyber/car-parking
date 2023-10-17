import 'package:ParkMe/presentation/parking_owners_screen/dashboard.dart';
import 'package:flutter/material.dart';

class SuccessPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Registration Successful'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Thank you for registering your parking with ParkMe!'),
            ElevatedButton(
               onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => DashboardPage(username: 'Indhira',),
                ),
              );
            },
              child: Text('Back to Dashboard'),
            ),
          ],
        ),
      ),
    );
  }
}
