import 'package:flutter/material.dart';
import 'package:mapsss/sample_details_page.dart';

class ParkingsPage extends StatelessWidget {
  final List<String> sampleList = ['Sample 1', 'Sample 2', 'Sample 3', 'Sample 4', 'Sample 5'];

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
    );
  }
}
