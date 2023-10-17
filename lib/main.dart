import 'package:ParkMe/auth/login_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:ParkMe/presentation/screens/common/nav_bar/nav_bar.dart';
import 'package:ParkMe/presentation/screens/home/welcome_page.dart';
import 'auth/register_page.dart';
import 'presentation/screens/parking_details_form/ParkingForm_page.dart';
import 'presentation/screens/settings/about/about.dart';
import 'presentation/screens/settings/settings_page.dart';
import 'presentation/screens/home/simple_starting_screen.dart';
import 'presentation/screens/map_view/parking_map_view.dart';
import 'package:firebase_core/firebase_core.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized(); 
  await Firebase.initializeApp();

  final bool userLoggedIn = isLoggedIn();

  runApp(ParkingLocatorApp(initialRoute: userLoggedIn ? '/navBar' : '/welcomePage'));
}


// Check if the user is logged in
bool isLoggedIn() {
  return FirebaseAuth.instance.currentUser != null;
}


class ParkingLocatorApp extends StatelessWidget {
  final String initialRoute;

  const ParkingLocatorApp({required this.initialRoute, super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: initialRoute,
      routes: {
        '/home' : (context) => SimpleStartingScreen(),
        '/welcomePage' : (context) => WelcomePage(),
        '/mapView': (context) => ParkingMapView(isFirst: -1),
        '/aboutUs': (context) => AboutPage(),
        '/login': (context) => LoginPage(),
        '/register': (context) => RegisterPage(),
        '/navBar': (context) => BottomNavigationBarPage(),
        '/form': (context) => FormPage(),
        '/settingsPage': (context) => SettingsPage()

      },
    );
  }
}