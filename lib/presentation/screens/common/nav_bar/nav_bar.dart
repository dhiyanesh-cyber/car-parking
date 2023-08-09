import 'package:flutter/material.dart';
import 'package:mapsss/presentation/colors/colors.dart';
import 'package:mapsss/presentation/screens/about/about.dart';
import 'package:mapsss/presentation/screens/map_view/parking_map_view.dart';
import '../../settings/settings_page.dart';

import '../../map_view/test_map.dart';



class BottomNavigationBarPage extends StatefulWidget {
  const BottomNavigationBarPage({super.key});

  @override
  State<BottomNavigationBarPage> createState() =>
      _BottomNavigationBarPageState();

  static void setIndex(int i) {}
}

class _BottomNavigationBarPageState extends State<BottomNavigationBarPage> {
  int _selectedIndex = 0;
  static final List<Widget> _widgetOptions = <Widget>[
    ParkingMapView(),
    SearchPage(),
    AboutPage(),
    SettingsPage(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  void setIndex(int index){
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Positioned.fill(
            child: Center(
              child: _widgetOptions.elementAt(_selectedIndex),
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              padding: EdgeInsets.only(top: 8,),
              decoration: BoxDecoration(
                color: Colors.black,
                borderRadius: BorderRadius.only(topLeft: Radius.circular(16), topRight: Radius.circular(16)),

              ),
              child: BottomNavigationBar(
                elevation: 0,
                showSelectedLabels: false,
                showUnselectedLabels: false,
                items: const <BottomNavigationBarItem>[
                  BottomNavigationBarItem(
                    icon: Icon(Icons.dashboard_outlined),
                    label: 'Home',
                    backgroundColor: Colors.transparent,
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(Icons.search_outlined),
                    label: 'Search',
                    backgroundColor: Colors.transparent,
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(Icons.person),
                    label: 'Profile',
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(Icons.info_outline),
                    label: 'About',
                  ),
                ],
                currentIndex: _selectedIndex,
                selectedItemColor: CustomColors.myHexColorDarker,
                unselectedItemColor: Colors.white,
                onTap: _onItemTapped,
                backgroundColor: Colors.transparent,
              ),
            ),
          ),
        ],
      ),
    );
  }
}



// class _BottomNavigationBarPageState extends State<BottomNavigationBarPage> {
//   int _selectedIndex = 0;
//   static const TextStyle optionStyle =
//       TextStyle(fontSize: 30, fontWeight: FontWeight.bold);
//
//   static final List<Widget> _widgetOptions = <Widget>[
//     ParkingMapView(),
//     ParkingMapView(),
//     AboutPage(),
//     SettingsPage(),
//   ];
//
//   void _onItemTapped(int index) {
//     setState(() {
//       _selectedIndex = index;
//     });
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Center(
//         child: _widgetOptions.elementAt(_selectedIndex),
//       ),
//       bottomNavigationBar: BottomNavigationBar(
//
//
//               showSelectedLabels: false,
//               showUnselectedLabels: false,
//               items: const <BottomNavigationBarItem>[
//                 BottomNavigationBarItem(
//                   icon: Icon(Icons.dashboard_outlined),
//                   label: 'Home',
//                 ),
//                 BottomNavigationBarItem(
//                   icon: Icon(Icons.search_outlined),
//                   label: 'Search',
//                 ),BottomNavigationBarItem(
//                   icon: Icon(Icons.person),
//                   label: 'Search',
//                 ),
//                 BottomNavigationBarItem(
//                   icon: Icon(Icons.info_outline),
//                   label: 'About',
//                 ),
//               ],
//               currentIndex: _selectedIndex,
//
//               selectedItemColor:CustomColors.myHexColorDarker,
//               unselectedItemColor:Colors.black87,
//               onTap: _onItemTapped,
//             ),
//         );
//
//   }
// }
