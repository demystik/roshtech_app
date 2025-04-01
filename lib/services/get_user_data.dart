import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

Future<Map<String, String>> getUserData() async {
  try {
    // Get the current user
    User? user = FirebaseAuth.instance.currentUser;
    if (user == null) {
      throw Exception("User not logged in");
    }

    // Fetch user data from Firestore
    DocumentSnapshot userDoc = await FirebaseFirestore.instance
        .collection('users')
        .doc(user.uid)
        .get();

    if (userDoc.exists) {
      return {
        'fullName': userDoc['fullName'],
        'matricNumber': userDoc['matricNumber'],
      };
    } else {
      throw Exception("User data not found");
    }
  } catch (e) {
    // print("Error fetching user data: $e");
    return {};
  }
}