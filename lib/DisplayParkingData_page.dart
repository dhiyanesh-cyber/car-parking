import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class DisplayPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Display Data'),
        ),
        body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance.collection('parkingData').snapshots(),
    builder: (context, snapshot) {
    if (!snapshot.hasData) {
    return Center(
    child: CircularProgressIndicator(),
    );
    }

    return ListView.builder(
    itemCount: snapshot.data!.docs.length,
    itemBuilder: (context, index) {
    var doc = snapshot.data!.docs[index];
    return ListTile(
    leading: Image.network(
    doc['imageUrl'],
    height: 50,
    width: 50,
    fit: BoxFit.cover,
    ),
    title: Text(doc['parkingName']),
      subtitle: Text(doc['mobileNumber']),
      onTap: () {
        // Implement the action you want to perform when a ListTile is tapped.
      },
    );
    },
    );
    },
        ),
    );
  }
}
