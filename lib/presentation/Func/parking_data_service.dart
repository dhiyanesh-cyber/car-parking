import 'package:cloud_firestore/cloud_firestore.dart';

class ParkingDataService {
  // Method to fetch parking data from Firestore
  static Future<List<Map<String, dynamic>>> fetchParkingData() async {
    // Create a list to store parking data
    List<Map<String, dynamic>> parkingDataList = [];

    // Fetch the parking data from the "parkingData" collection in Firestore
    QuerySnapshot snapshot = await FirebaseFirestore.instance.collection("parkingData").get();

    // Iterate through the documents in the snapshot
    snapshot.docs.forEach((doc) {
      // Extract latitude, longitude, and parking name from each document
      double latitude = doc.get('latitude');
      double longitude = doc.get('longitude');
      String parkingName = doc.get('parkingName');

      // Create a map with parking details and add it to the parkingDataList
      Map<String, dynamic> parkingData = {
        'latitude': latitude,
        'longitude': longitude,
        'parkingName': parkingName,
      };
      parkingDataList.add(parkingData);
    });

    // Return the list of parking data
    return parkingDataList;
  }
}
