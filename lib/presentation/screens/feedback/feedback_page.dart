import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ParkMe/presentation/colors/colors.dart';

class FeedbackPage extends StatefulWidget {
  @override
  _FeedbackPageState createState() => _FeedbackPageState();
}

class _FeedbackPageState extends State<FeedbackPage> {
  final _feedbackController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Feedback'),
        backgroundColor: CustomColors.myHexColor,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextFormField(
              controller: _feedbackController,
              maxLines: 5,
              decoration: InputDecoration(
                labelText: 'Your Feedback',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _submitFeedback,
              child: Text('Submit Feedback'),
            ),
          ],
        ),
      ),
    );
  }

  void _submitFeedback() async {
    try {
      // Get the current user's UID from Firebase Authentication.
      final user = FirebaseAuth.instance.currentUser;
      if (user == null) {
        // Handle the case where the user is not authenticated.
        return;
      }

      // Store the feedback in Firestore database.
      await FirebaseFirestore.instance.collection('feedback').add({
        'userUid': user.uid,
        'feedbackText': _feedbackController.text,
        'timestamp': FieldValue.serverTimestamp(),
      });

      // Show a thank you message to the user.
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Thank You!'),
            content: Text('Your feedback has been submitted.'),
            actions: [
              ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                  Navigator.pop(context); // Navigate back to previous screen.
                },
                child: Text('OK'),
              ),
            ],
          );
        },
      );
    } catch (e) {
      // Handle any error that might occur during feedback submission (optional).
      print('Error submitting feedback: $e');
    }
  }

  @override
  void dispose() {
    _feedbackController.dispose();
    super.dispose();
  }
}
