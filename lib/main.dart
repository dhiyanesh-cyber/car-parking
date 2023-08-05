import 'package:flutter/material.dart';

import 'package:mapsss/presentation/screens/home/welcome_page.dart';


import 'presentation/screens/display_parking_details/DisplayParkingData_page.dart';
import 'presentation/screens/parking_details_form/ParkingForm_page.dart';
import 'presentation/screens/parking_Details/details_page.dart';

import 'presentation/screens/settings/settings_page.dart';
import 'presentation/auth/register_page.dart';
import 'presentation/screens/about/about.dart';
import 'presentation/screens/loading/loading_screen.dart';
import 'presentation/auth/login_page.dart';
import 'presentation/screens/home/simple_starting_screen.dart';
import 'presentation/screens/map_view/parking_map_view.dart';

import 'package:firebase_core/firebase_core.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const ParkingLocatorApp());
}

class ParkingLocatorApp extends StatelessWidget {
  const ParkingLocatorApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: LoadingScreen(),
      routes: {
        '/home' : (context) => SimpleStartingScreen(),
        '/welcomePage' : (context) => WelcomePage(),
        '/mapView': (context) => ParkingMapView(),
        '/aboutUs': (context) => AboutPage(),
        // '/parkingsPage': (context) => ParkingsPage(),
        '/login': (context) => LoginPage(),
        '/register': (context) => RegisterPage(),

        '/form': (context) => FormPage(),
        '/displayPage': (context) => DisplayPage(),

        '/settingsPage': (context) => SettingsPage()

      },
    );
  }
}
