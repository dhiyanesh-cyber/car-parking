import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
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
      appBar: AppBar(
        
        title: Text('Search Page'),
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
      child: Container(
        // Your search bar UI here
        child: TextField(
          decoration: InputDecoration(
            hintText: 'Search...',
            prefixIcon: Icon(Icons.search),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10.0),
            ),
          ),
        ),
      ),
    );
  }
}

class NearbyParkingDialog extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Implement the logic to display a dialog box showing nearby parkings
    // when the first image is tapped.
    return GestureDetector(
      onTap: () {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text('Nearby Parkings'),
              content: Text('List of nearby parkings will be shown here.'),
              actions: [
                TextButton(
                  onPressed: () => Navigator.of(context).pop(),
                  child: Text('Close'),
                ),
              ],
            );
          },
        );
      },
      child: Container(
        // First image UI here
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
