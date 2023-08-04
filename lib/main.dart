import 'package:flutter/material.dart';
import 'DisplayParkingData_page.dart';
import 'ParkingForm_page.dart';
import 'details_page.dart';
import 'presentation/screens/settings/settings_page.dart';
import 'presentation/auth/register_page.dart';
import 'presentation/screens/about/about.dart';
import 'loading_screen.dart';
import 'presentation/auth/login_page.dart';
import 'simple_starting_screen.dart';
import 'parking_map_view.dart';
import 'parkings_page.dart';
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
