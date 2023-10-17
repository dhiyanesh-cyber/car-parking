import 'package:cloud_firestore/cloud_firestore.dart';

class ParkingDataService {
  // Method to fetch pa
  static Future<List<Map<String, dynamic>>> fetchParkingData() async {
    // Create a list to store rking data from Firestoreparking data
    List<Map<String, dynamic>> parkingDataList = [];

    // Fetch the parking data from the "parkingData" collection in Firestore
    QuerySnapshot snapshot = await FirebaseFirestore.instance.collection("parkingData").get();

    // Iterate through the documents in the snapshot
    snapshot.docs.forEach((doc) {
      // Extract latitude, longitude, and parking name from each document
      double latitude = doc.get('latitude');
      double longitude = doc.get('longitude');
      String parkingName = doc.get('parkingName');
      int slots = doc.get('totalParkingSlots');

      // Create a map with parking details and add it to the parkingDataList
      Map<String, dynamic> parkingData = {
        'latitude': latitude,
        'longitude': longitude,
        'parkingName': parkingName,
        'slots' : slots,
      };
      parkingDataList.add(parkingData);
    });

    // Return the list of parking data
    return parkingDataList;
  }
}
