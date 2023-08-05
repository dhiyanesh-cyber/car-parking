import 'package:flutter/material.dart';


class WelcomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    Color myHexColor = Color(0xFFFDE3E3);
    return Scaffold(
      backgroundColor: myHexColor,

      body: Center(

        child: Column(

          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Gif Image
            Image.asset(
              'assets/parking-amico.png', // Replace 'welcome.gif' with your actual gif file path
              height: 300,
              width: 300,
              fit: BoxFit.contain,
              
            ),

            // Welcome Text
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                'Welcome to ParkMe',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),

            // Description Text
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 32.0),
              child: Text(
                'Please register or login to your account',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 14),
              ),
            ),

            SizedBox(height: 32),



            // Buttons

            // CREATE AN ACCOUNT
            Container(
              height: 50.0,
              width: 300,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                gradient: LinearGradient(
                  colors: [Colors.black87, Colors.grey.shade800],
                ),

              ),
              child: ElevatedButton(
                onPressed: () {
                  // Handle the action for Create an Account button
                  // For example, navigate to the registration page.
                  Navigator.pushNamed(context, '/register');
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.transparent,
                  shadowColor: Colors.transparent,
                ),
                child: Text('Create an Account',style: TextStyle(color: myHexColor),),
              ),
            ),

            SizedBox(height: 26),


            // I HAVE AN ACCOUNT

            Container(
              height: 50.0,
              width: 300,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                gradient: LinearGradient(
                  colors: [Colors.black87, Colors.grey.shade800],
                ),

              ),
              child: ElevatedButton(

                onPressed: () {
                  // Handle the action for I have an Account button
                  // For example, navigate to the login page.
                  Navigator.pushNamed(context, '/login');
                },
                style: ElevatedButton.styleFrom(

                  backgroundColor: Colors.transparent,
                  shadowColor: Colors.transparent,
                ),
                child: Text('I have an Account', style: TextStyle(color: myHexColor),),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
