import 'package:flutter/material.dart';
import 'package:ParkMe/colors/colors.dart';
import 'package:ParkMe/presentation/screens/map_view/parking_map_view.dart';
import '../../profile/user_profile.dart';
import '../../settings/settings_page.dart';
import '../../search/search.dart';


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
    ParkingMapView( isFirst: -1),
    // DashboardPage(username: "Indhira"),
    SearchPage(),
    UserProfilePage(),
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
                borderRadius: BorderRadius.only(topLeft: Radius.circular(24), topRight: Radius.circular(24)),

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
                    backgroundColor: Colors.transparent,
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(Icons.settings),
                    label: 'About',
                    backgroundColor: Colors.transparent,
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




