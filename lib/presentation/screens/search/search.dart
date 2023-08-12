// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:ParkMe/presentation/screens/map_view/parking_map_view.dart';
import 'package:ParkMe/presentation/colors/colors.dart';
import 'package:ParkMe/presentation/screens/map_view/search_history.dart';



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
  List<DocumentSnapshot> _searchResults = [];
  List<String> _searchHistory = [];
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    // Load existing search history
    SearchHistoryManager.getSearchHistory().then((history) {
      setState(() {
        _searchHistory = history;
      });
    });
  }

  Future<void> _searchParking(String searchText) async {
    QuerySnapshot snapshot = await FirebaseFirestore.instance.collection("parkingData").get();

    setState(() {
      _searchResults = snapshot.docs.where((doc) {
        String parkingName = doc.get('parkingName');
        return parkingName.toLowerCase().contains(searchText.toLowerCase().trim());
      }).toList();
    });
  }

  void _navigateToParkingDetails(String parkingName) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ParkingMapView(isFirst: -1,),
      ),
    );
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
            SizedBox(
              height: 20,
            ),
            SearchBar(
              searchController: _searchController,
              onSearch: _searchParking,
              searchResults: _searchResults,
              onTapResult: _navigateToParkingDetails,
            ),
            SizedBox(
              height: 20,
            ),
            NearbyParkingDialog(),
            SizedBox(
              height: 25,
            ),
            Center(
              child: Container(
                child: SearchHistoryBox(
                  searchHistory: _searchHistory,
                  onSearch: _searchParking,
                  clearSearchHistory: () {
                    setState(() {
                      _searchHistory.clear();
                    });
                  },
                ),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            FamousParkingAreas(),
          ],
        ),
      ),
    );
  }
}
class SearchBar extends StatefulWidget {
  final TextEditingController searchController;
  final Function(String) onSearch;
  final List<DocumentSnapshot> searchResults;
  final Function(String) onTapResult;

  SearchBar({required this.searchController, required this.onSearch, required this.searchResults, required this.onTapResult});

  @override
  _SearchBarState createState() => _SearchBarState();
}

class _SearchBarState extends State<SearchBar> {
  @override
  Widget build(BuildContext context) {
    final isSuggestionVisible = widget.searchController.text.isNotEmpty && widget.searchResults.isNotEmpty;

    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: GestureDetector(
        onTap: () {
          // Clear focus to dismiss the keyboard
          FocusScope.of(context).unfocus();
        },
        child: Container(
          decoration: BoxDecoration(
            color: CustomColors.myHexColorDark,
            borderRadius: BorderRadius.circular(15),
          ),
          child: Padding(
            padding: const EdgeInsets.all(7.0),
            child: Column(
              children: [
                Row(
                  children: [
                    Icon(Icons.search),
                    SizedBox(width: 10),
                    Expanded(
                      child: TextField(
                        cursorColor: Colors.black87,
                        controller: widget.searchController,
                        onChanged: (value) {
                          widget.onSearch(value);
                        },
                        decoration: InputDecoration(
                          hintText: 'Search for parking...',
                          border: InputBorder.none,
                          contentPadding: EdgeInsets.symmetric(horizontal: 10, vertical: 14),
                        ),
                      ),
                    ),
                    if (widget.searchController.text.isNotEmpty)
                      GestureDetector(
                        onTap: () {
                          widget.searchController.clear();
                          widget.onSearch('');
                        },
                        child: Icon(Icons.clear),
                      ),
                  ],
                ),
                if (isSuggestionVisible)
                  Container(
                    color: Colors.white,
                    child: Column(
                      children: widget.searchResults.map((snapshot) {
                        String parkingName = snapshot.get('parkingName');
                        return ListTile(
                          title: Text(parkingName),
                          onTap: () {
                            widget.onTapResult(parkingName);
                          },
                        );
                      }).toList(),
                    ),
                  ),
              ],
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
    List<String> imageAssets = [
      'assets/koodal Azhagar Temple.jpg',
      'assets/Madurai Kamaraj University.jpg',
      'assets/Madurai museum.jpg',
      'assets/Meenakshi temple.jpg',
      'assets/puthu mandapam.jpg',
      'assets/st-mary-s-cathedral',
      'assets/TEPPAKULAM.jpg',
      'assets/Thirumalai nayakar mahal.jpg',
      // ... other image assets ...
    ];

    return Container(
      height: 70,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: imageAssets.length,
        itemBuilder: (BuildContext context, int index) {
          return GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => ParkingMapView(isFirst: index,)),
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
                backgroundImage: AssetImage(imageAssets[index]),
                radius: 32,
              ),
            ),
          );
        },
      ),
    );
  }
}
class SearchHistoryBox extends StatelessWidget {
 List<String> searchHistory;
  final Function(String) onSearch;
  final Function() clearSearchHistory;

  SearchHistoryBox({
    required this.searchHistory,
    required this.onSearch,
    required this.clearSearchHistory,
  });


  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30),
        color: CustomColors.myHexColorDark,
      ),
      margin: EdgeInsets.all(30),
      padding: EdgeInsets.all(30),
      
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Search History',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            GestureDetector(
              onTap: () {
                SearchHistoryManager.clearSearchHistory();

                clearSearchHistory;
              
                // Handle the delete action here
                // For example, you could clear the search history.
              },
              child: Icon(Icons.delete),
            ),
          ],
        ),
        SizedBox(height: 8),
          if (searchHistory.isNotEmpty)
            Center(
              child: ListView.builder(
                shrinkWrap: true,
                itemCount: searchHistory.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    leading: Container( // Wrap the leading widget with a Container
            width: 48.0, // Set a desired width
            child: Icon(Icons.history),
          ),
                    
                    title: Text(searchHistory[index]),
                    onTap: () {
                      onSearch(searchHistory[index]);
                    },
                  );
                },
              ),
            ),
          if (searchHistory.isEmpty) Text(''),
        ],
      ),
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
