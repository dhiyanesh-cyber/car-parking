import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:mapsss/presentation/colors/colors.dart';
class UserProfilePage extends StatefulWidget {
  @override
  _UserProfilePageState createState() => _UserProfilePageState();
}

class _UserProfilePageState extends State<UserProfilePage> {
  late User _user;
  late DocumentReference _userRef;
  String _name = '';
  String _email = '';
  String _mobileNumber = '';

  @override
  void initState() {
    super.initState();
    _user = FirebaseAuth.instance.currentUser!;
    _userRef = FirebaseFirestore.instance.collection('users').doc(_user.uid);

    _fetchUserInfo();
  }

  Future<void> _fetchUserInfo() async {
    try {
      DocumentSnapshot snapshot = await _userRef.get();
      if (snapshot.exists) {
        Map<String, dynamic> userData = snapshot.data() as Map<String, dynamic>;

        print("Fetched user data: $userData");

        setState(() {
          _name = userData['name'];
          _email = userData['email'];
          _mobileNumber = userData['phoneNumber'];
        });
      } else {
        print("User data does not exist in Firestore.");
        print(_user.uid);
      }
    } catch (error) {
      print("Error fetching user data: $error");
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CustomColors.myHexColorDark,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: CustomColors.myHexColorDark,
        title: Text(
          'Profile',
          textAlign: TextAlign.center,
          style: TextStyle(color: Colors.black),
        ),
        elevation: 0,
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(

              padding: EdgeInsets.all(24),
              child: Container(

                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(50)),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black87.withOpacity(0.1),
                      spreadRadius: 3,
                      blurRadius: 10,
                      offset: Offset(0, -7), // changes position of shadow
                    ),
                  ],
                ),
                child: CircleAvatar(
                  radius: 50,
                  backgroundColor: Colors.white70,
                  backgroundImage: AssetImage('assets/profile.png'),
                ),
              ),
            ),
            SizedBox(height: 20),
            Expanded(
              child: Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  color: CustomColors.myHexColorLight,
                  borderRadius: BorderRadius.vertical(top: Radius.circular(30)),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black87.withOpacity(0.3),
                      spreadRadius: 7,
                      blurRadius: 30,
                      offset: Offset(0, 3), // changes position of shadow
                    ),
                  ],
                ),
                child: Container(
                  padding: EdgeInsets.all(30),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 40),
                      Text(
                        'Username',
                        style: TextStyle(fontSize: 16, color: Colors.grey),
                      ),
                      SizedBox(height: 10,),
                      Text(
                        _name,
                        style: TextStyle(fontSize: 20, fontWeight: FontWeight.w400,color: Colors.black87),
                      ),
                      SizedBox(height: 20),
                      Divider(color: Colors.grey,),
                      SizedBox(height: 20),
                      Text(
                        'Email',
                        style: TextStyle(fontSize: 16, color: Colors.grey),
                      ),
                      SizedBox(height: 10,),
                      Text(
                        _email,
                        style: TextStyle(fontSize: 16,fontWeight: FontWeight.w400,color: Colors.black87),
                      ),
                      SizedBox(height: 20),
                      Divider(color: Colors.grey,),
                      SizedBox(height: 20),
                      Text(
                        'Mob Number',
                        style: TextStyle(fontSize: 16, color: Colors.grey),
                      ),
                      SizedBox(height: 10,),
                      Text(
                        _mobileNumber,
                        style: TextStyle(fontSize: 16,fontWeight: FontWeight.w400,color: Colors.black87),
                      ),
                      SizedBox(height: 20),
                    ],
                  ),

                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
