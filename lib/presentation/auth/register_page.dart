import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'auth_service.dart';

class RegisterPage extends StatefulWidget {
  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {

  Color myHexColor = Color(0xFFFDE3E3);
  Color myHexColorDark = Color(0xFFECC9C9);
  Color myHexColorDarker = Color(0xFFD0A6A6);
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _phoneNumberController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  AuthService _authService = AuthService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: myHexColor,
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.pushNamed(context, '/welcomePage');
          },
          icon: Icon(Icons.arrow_back_ios_rounded),
        ),
        title: Text("Register", style: TextStyle(color: Colors.black87),),
        iconTheme: IconThemeData(color: Colors.black),
        backgroundColor: myHexColor,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [






              Image.asset(
                'assets/Signup.png', // Replace 'welcome.gif' with your actual gif file path
                height: 300,
                width: 300,
                fit: BoxFit.contain,

              ),

              Container(
                decoration: BoxDecoration(
                  color: myHexColorDark,
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(7.0),
                  child: TextField(
                    cursorColor: Colors.black87,
                    controller: _nameController,
                    decoration: InputDecoration(
                      hintText: 'Name',
                      labelStyle: TextStyle(color: Colors.black87),
                      border: InputBorder.none,
                      contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 14),
                    ),
                  ),
                ),
              ),

              SizedBox(height: 16),

              Container(
                decoration: BoxDecoration(
                  color: myHexColorDark,
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(7.0),
                  child: TextField(
                    cursorColor: Colors.black87,
                    controller: _phoneNumberController,
                    keyboardType: TextInputType.phone,
                    decoration: InputDecoration(
                      hintText: 'Phone Number',
                      labelStyle: TextStyle(color: Colors.black87),
                      border: InputBorder.none,
                      contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 14),
                    ),
                  ),
                ),
              ),

              SizedBox(height: 16),



              Container(
                decoration: BoxDecoration(
                  color: myHexColorDark,
                  borderRadius: BorderRadius.circular(15),

                ),
                child: Padding(
                  padding: const EdgeInsets.all(7.0),
                  child: TextField(
                    cursorColor: Colors.black87,
                    controller: _emailController,
                    decoration: InputDecoration(

                      hintText: 'Email',
                      labelStyle: TextStyle(color: Colors.black87),
                      border: InputBorder.none,
                      contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 14),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 16),
              Container(

                decoration: BoxDecoration(
                  color: myHexColorDark,
                  borderRadius: BorderRadius.circular(15),

                ),
                child: Padding(
                  padding: const EdgeInsets.all(7.0),
                  child: TextField(

                    cursorColor: Colors.black87,
                    controller: _passwordController,
                    decoration: InputDecoration(
                      hintText: 'Password',
                      labelStyle: TextStyle(color: Colors.black87),
                      border: InputBorder.none,
                      contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 14),
                    ),
                    obscureText: true,
                  ),
                ),
              ),
              SizedBox(height: 40),
              Container(
                height: 50.0,
                width: 250,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  gradient: LinearGradient(
                    colors: [Colors.black87, Colors.grey.shade800],
                  ),
                ),
                child: ElevatedButton(
                  onPressed: () async {
                    String email = _emailController.text.trim();
                    String password = _passwordController.text.trim();
                    String name = _nameController.text.trim(); // Get the name from the text field
                    String phoneNumber = _phoneNumberController.text.trim();
                    User? user =
                    await _authService.registerWithEmailAndPassword(email, password, name, phoneNumber);
                    if (user != null) {
                      // Registration successful, navigate to login page
                      Navigator.pushReplacementNamed(context, '/login');
                    } else {
                      // Show error message
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('Registration failed')),
                      );
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.transparent,
                    shadowColor: Colors.transparent,
                  ),
                  child: Text('Create an Account', style: TextStyle(color: myHexColor),),
                ),
              ),

              TextButton(
                onPressed: () {
                  Navigator.pushNamed(context, '/login');
                },
                child: Text('Already have an account ? Login', style: TextStyle(color: myHexColorDarker),),
              ),

            ],
          ),
        ),
      ),
    );
  }
}
