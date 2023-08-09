import 'package:flutter/material.dart';
import 'package:mapsss/presentation/screens/map_view/parking_map_view.dart';

import '../../colors/colors.dart';

void main() {
  runApp(SearchPage());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SearchPage(),
    );
  }
}

class SearchPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CustomColors.myHexColor,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: CustomColors.myHexColor,
        title: Text(
          'Search',
          textAlign: TextAlign.center,
          style: TextStyle(color: Colors.black),
        ),
        elevation: 0,
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            SearchBar(),
            NearbyParkingDialog(),
            SearchHistoryBox(),
            FamousParkingAreas(),
          ],
        ),
      ),
    );
  }
}

class SearchBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child:Container(
                height: 45,
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.black87),
                  borderRadius: BorderRadius.circular(50),
                ),
                padding: EdgeInsets.symmetric(horizontal: 16.0),
                child: TextField(
                  decoration: InputDecoration(
                    hintText: 'Search for parking...',
                    border: InputBorder.none,
                    suffixIcon: Icon(Icons.search),
                  ),
                  onChanged: (value) {
                    // Implement your search functionality here
                  },
                ),
              ),
              
    );
  }
}


class NearbyParkingDialog extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Replace the images list with your image assets
    List<String> imageAssets = [
      'assets/parking_marker2.png',
      'assets/parking_marker2.png',
      'assets/parking_marker2.png',
      'assets/parking_marker2.png',
      'assets/parking_marker2.png',
      'assets/parking_marker2.png',
      'assets/parking_marker2.png',
      'assets/parking_marker2.png',
    ];

    return Container(
      height: 70, // Adjust the height as needed
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: imageAssets.length,
        itemBuilder: (BuildContext context, int index) {
          return GestureDetector(
            onTap: () {
              if (index == 0) {
                // Navigate to a different page for the first image
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ParkingMapView()),
                );
              } else {
                // Navigate to the same image detail page for other images
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ParkingMapView()),
                );
              }
            },
            child: Padding(
              padding: const EdgeInsets.only(
                top: 2.0,
                bottom: 2.0,
                right: 3.0,
                left: 2.0,
              ),
              child: Expanded( // Wrap in an Expanded widget
                child: Column(
                  children: [
                    CircleAvatar(
                      backgroundImage: AssetImage(imageAssets[index]),
                      radius: 40, // Adjust the size of the circle
                    ),
                    SizedBox(height: 5), // Adjust the spacing between image and text
                    Text(
                      'Image $index', // Replace with your text
                      style: TextStyle(
                        fontSize: 4,
                        
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

class SearchHistoryBox extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Implement the search history UI inside a box here
    return Container(
      // Search history UI here
    );
  }
}

class FamousParkingAreas extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Implement the UI to display images and names of famous parking areas
    return Container(
      // Famous parking areas UI here
    );
  }
}
