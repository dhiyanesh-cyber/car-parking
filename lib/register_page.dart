import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'auth_service.dart';

class RegisterPage extends StatefulWidget {
  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  AuthService _authService = AuthService();

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
        iconTheme: IconThemeData(color: Colors.black),
        backgroundColor: Colors.white,elevation: 0,
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("Register", style: TextStyle(fontSize: 30, fontWeight: FontWeight.w800,),),

              SizedBox(
                height: 20,
              ),
              TextField(
                cursorColor: Colors.black87,
                controller: _emailController,
                decoration: InputDecoration(labelText: 'Email',
                    labelStyle: TextStyle(color: Colors.black87),
                    focusColor: Colors.black87,
                    focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                            color: Colors.black87, width: 2
                        )
                    )),
              ),
              SizedBox(height: 16),
              TextField(
                cursorColor: Colors.black87,
                controller: _passwordController,
                decoration: InputDecoration(labelText: 'Password',
                    labelStyle: TextStyle(color: Colors.black87),
                    focusColor: Colors.black87,
                    focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                            color: Colors.black87, width: 2
                        )
                    )),
                obscureText: true,
              ),
              SizedBox(height: 40),
              Container(
                height: 40.0,
                width: 110,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30),
                  gradient: LinearGradient(
                    colors: [Colors.black87, Colors.grey.shade800],
                  ),

                ),
                child: ElevatedButton(
                  onPressed: () async {
                    String email = _emailController.text.trim();
                    String password = _passwordController.text.trim();
                    User? user =
                    await _authService.registerWithEmailAndPassword(email, password);
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
                  child: Text('Register'),
                ),
              ),

              SizedBox(
                height: 60,
              )
            ],
          ),
        ),
      ),
    );
  }
}
