import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'auth_service.dart';


class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  Color myHexColor = Color(0xFFFDE3E3);
  Color myHexColorDark = Color(0xFFECC9C9);
  Color myHexColorDarker = Color(0xFFD0A6A6);
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
        title: Text("Log In", style: TextStyle(color: Colors.black87),),
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

              SizedBox(
                height: 24,
              ),


              Image.asset(
                'assets/Login.png', // Replace 'welcome.gif' with your actual gif file path
                height: 300,
                width: 300,
                fit: BoxFit.contain,

              ),

              SizedBox(
                height: 24,
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
                    User? user =
                    await _authService.signInWithEmailAndPassword(email, password);
                    if (user != null) {
                      // Navigate to home screen
                      Navigator.pushNamed(context, '/navBar');
                    } else {
                      // Show error message
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('Invalid email or password')),
                      );
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.transparent,
                    shadowColor: Colors.transparent,
                  ),
                  child: Text('Login',style: TextStyle(color: myHexColor),),
                ),
              ),

              TextButton(
                onPressed: () {
                  Navigator.pushNamed(context, '/register');
                },
                child: Text('Don\'t have an account? Register', style: TextStyle(color: myHexColorDarker),),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
