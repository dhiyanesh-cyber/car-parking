import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:mapsss/presentation/screens/map_view/parking_map_view.dart';
import 'package:mapsss/presentation/colors/colors.dart';
import 'package:mapsss/presentation/screens/map_view/search_history.dart';


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

class SearchPage extends StatefulWidget {
  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final TextEditingController _searchController = TextEditingController();
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  

  bool result = false;

  Future<void> _searchParking(String searchText) async {


        QuerySnapshot snapshot = await FirebaseFirestore.instance.collection("parkingData").get();

    // Iterate through the documents in the snapshot
    snapshot.docs.forEach((doc) {
      // Extract latitude, longitude, and parking name from each document

      String parkingName = doc.get('parkingName');

      
      

      if(searchText.toString().toLowerCase().trim() == parkingName.toString().toLowerCase().trim()){
        result = true;
        print(result);
        
      }
    
  });
  

    

    if (result) {
      // Navigate to ParkingDetailsPage with the parking data
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => ParkingMapView(),
        ),
      );
      result = false;
    }
  }

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
            SearchBar(searchController: _searchController, onSearch: _searchParking),
            NearbyParkingDialog(),
            SearchHistoryBox(onSearch: (String ) {  },),
            FamousParkingAreas(),
          ],
        ),
      ),
    );
  }
}

class SearchBar extends StatelessWidget {
  final TextEditingController searchController;
  final Function(String) onSearch;

  SearchBar({required this.searchController, required this.onSearch});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Container(
        height: 45,
        decoration: BoxDecoration(
          border: Border.all(color: Colors.black87),
          borderRadius: BorderRadius.circular(50),
        ),
        padding: EdgeInsets.symmetric(horizontal: 16.0),
        child: TextField(
          controller: searchController,
          decoration: InputDecoration(
            hintText: 'Search for parking...',
            border: InputBorder.none,
            suffixIcon: IconButton(
              icon: Icon(Icons.search),
              onPressed: () {
                onSearch(searchController.text);
              },
            ),
          ),
          onSubmitted: (value) {
            onSearch(value);
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
     'assets/koodal Azhagar Temple.jpg',
     'assets/birla-planetarium.jpg',
     'assets/kamraj-sagar-dam.jpg',
     'assets/Madurai Kamaraj University.jpg',
     'assets/Madurai museum.jpg',
     'assets/Meenakshi temple.jpg',
     'assets/puthu mandapam.jpg',
     'assets/st-mary-s-cathedral.jpg',
     'assets/TEPPAKULAM.jpg',
     'assets/Thirumalai nayakar mahal.jpeg',

    ];

    return Container(
      height: 70, // Adjust the height as needed
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: imageAssets.length,
        itemBuilder: (BuildContext context, int index) {
          return GestureDetector(
            onTap: () {
              
                // Navigate to the same image detail page for other images
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ParkingMapView()),
                );
              
            },
            child: Padding(
              padding: const EdgeInsets.only(
                top: 6.0,
                bottom: 2.0,
                right: 2.5,
                left: 15.0,
                
              ),
              child: CircleAvatar(
                backgroundImage: AssetImage(imageAssets[index] ),
                
                radius: 32, // Adjust the size of the circle
              ),
              
            ),
          );
        },
      ),
    );
  }
}

class SearchHistoryBox extends StatelessWidget {
  final Function(String) onSearch;

  SearchHistoryBox({required this.onSearch});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<String>>(
      future: SearchHistoryManager.getSearchHistory(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return CircularProgressIndicator();
        } else if (snapshot.hasError) {
          return Text('Error loading search history');
        } else {
          final searchHistory = snapshot.data ?? [];
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Search History',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 8),
              if (searchHistory.isNotEmpty)
                ListView.builder(
                  shrinkWrap: true,
                  itemCount: searchHistory.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      leading: Icon(Icons.history),
                      title: Text(searchHistory[index]),
                      onTap: () {
                        onSearch(searchHistory[index]);
                      },
                    );
                  },
                ),
              if (searchHistory.isEmpty)
                Text('No search history available'),
            ],
          );
        }
      },
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
