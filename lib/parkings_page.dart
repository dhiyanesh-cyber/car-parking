import 'package:flutter/material.dart';
import 'package:mapsss/sample_details_page.dart';
import 'custom_bottom_navigation_bar.dart';

class ParkingsPage extends StatelessWidget {
  final List<String> sampleList = ['Parking 1', 'Parking 2', 'Parking 3', 'Parking 4', 'Parking 5'];

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

      bottomNavigationBar: BottomNavigationBarWidget(
        selectedIndex: 2,
        onTabChange: (index) {
          switch (index) {
            case 0:
              Navigator.pushNamed(context, '/');
              break;
            case 1:
              Navigator.pushNamed(context, '/mapView');
              break;
            case 3:
              Navigator.pushNamed(context, '/aboutUs');
              break;
            default:
              break;
          }
        },
      ),
    );
  }
}
