import 'package:flutter/material.dart';
import 'package:mapsss/sample_details_page.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:line_icons/line_icons.dart';

class ParkingsPage extends StatelessWidget {
  final List<String> sampleList = ['Parking 1', 'Parking 2', 'Parking 3', 'Parking 4', 'Parking 5'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: Container(
        color: Colors.black,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 10),
          child: GNav(
            backgroundColor: Colors.black,
            color: Colors.white,
            activeColor: Colors.white,
            gap: 8,
            tabBackgroundColor: Colors.grey.shade800,
            padding: EdgeInsets.all(16),


            tabs: [
              GButton(
                icon: LineIcons.home,
                text: 'Home',
              ),
              GButton(
                icon: LineIcons.mapMarker,
                text: 'Map View',
              ),
              GButton(
                icon: LineIcons.car,
                text: 'Parkings',
              ),
              GButton(
                icon: LineIcons.infoCircle,
                text: 'About',
              )
            ],
            selectedIndex: 2,
            onTabChange: (index) {
              switch (index) {
                case 0:
                  Navigator.pushNamed(context, '/');
                  break;
                case 1:
                  Navigator.pushNamed(context, '/mapView');
                  break;
                case 2:
                  Navigator.pushNamed(context, '/parkingsPage');
                  break;
                default:
                  break;
              }
            },


          ),

        ),
      ),
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(Icons.arrow_back_ios_rounded),
        ),
        title: Text(
          'Parkings',
          style: TextStyle(color: Colors.black),
        ),
        elevation: 0,
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(color: Colors.black),
      ),
      body: ListView.builder(
        itemCount: sampleList.length,
        itemBuilder: (context, index) {
          final sample = sampleList[index];
          return ListTile(
            title: Text(sample),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => SampleDetailsPage(sample: sample),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
