import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class UserRegistrationData {
  final String name;
  final String email;
  final String phoneNumber;

  UserRegistrationData({
    required this.name,
    required this.email,
    required this.phoneNumber,
  });

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'email': email,
      'phoneNumber': phoneNumber,
    };
  }
}


class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // Register with email and password
  // Future<User?> registerWithEmailAndPassword(String email, String password) async {
  //   try {
  //     UserCredential result = await _auth.createUserWithEmailAndPassword(
  //       email: email,
  //       password: password,
  //     );
  //     User? user = result.user;
  //     return user;
  //   } catch (e) {
  //     print('Error registering user: $e');
  //     return null;
  //   }
  // }

  Future<User?> registerWithEmailAndPassword(
      String email,
      String password,
      String name,
      String phoneNumber,
      ) async {
    try {
      UserCredential result = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      User? user = result.user;

      if (user != null) {
        // Save user data to Firestore
        await saveUserDataToFirestore(
          UserRegistrationData(
            name: name,
            email: email,
            phoneNumber: phoneNumber,
          ),
          user.uid,
        );
      }

      return user;
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  Future<void> saveUserDataToFirestore(UserRegistrationData userData, String userId) async {
    try {
      // Reference to Firestore collection named "users"
      CollectionReference usersCollection = FirebaseFirestore.instance.collection('users');

      // Create a document with the user's ID
      DocumentReference userDocument = usersCollection.doc(userId);

      // Convert the UserRegistrationData object to a map
      Map<String, dynamic> userDataMap = userData.toMap();

      // Save the user data to Firestore
      await userDocument.set(userDataMap);
    } catch (e) {
      print(e.toString());
    }
  }

  // Sign in with email and password
  Future<User?> signInWithEmailAndPassword(String email, String password) async {
    try {
      UserCredential result = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      User? user = result.user;
      return user;
    } catch (e) {
      print('Error signing in: $e');
      return null;
    }
  }

  // Sign out
  Future<void> signOut() async {
    await _auth.signOut();
  }


}
