import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

Future<void> loginUser(String email, String matricNumber, BuildContext context) async {

  // Show loading dialog
  showDialog(
    context: context,
    barrierDismissible: false, // Prevent dismissing by tapping outside
    builder: (BuildContext context) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    },
  );

  try {
    // Step 1: Authenticate user with email and dummy password
    UserCredential userCredential = await FirebaseAuth.instance.signInWithEmailAndPassword(
      email: email,
      password: "student123", // Use the same dummy password
    );

    // Step 2: Fetch user data from Firestore
    DocumentSnapshot userDoc = await FirebaseFirestore.instance
        .collection('users')
        .doc(userCredential.user!.uid)
        .get();

    // Step 3: Validate matriculation number
    if (userDoc.exists && userDoc['matricNumber'] == matricNumber) {
      if (context.mounted) {
        Navigator.of(context).pop();
        Navigator.pushReplacementNamed(
            context, '/dashboard');
      }
      // print("Login successful!");
    } else {
      await FirebaseAuth.instance.signOut(); // Log out if validation fails

      if(context.mounted){
        Navigator.of(context).pop();
        // ScaffoldMessenger.of(context).clearSnackBars();
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          backgroundColor: Colors.red,
          shape: StadiumBorder(),
          behavior: SnackBarBehavior.floating,
          margin: EdgeInsets.only(top: 50),
          content: Text("Invalid matriculation number."),
        ),
      );
      }
    }
  } on FirebaseAuthException catch (e) {
    if(context.mounted){
      Navigator.of(context).pop();
      // ScaffoldMessenger.of(context).clearSnackBars();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          backgroundColor: Colors.red,
          shape: const StadiumBorder(),
          behavior: SnackBarBehavior.floating,
          margin: const EdgeInsets.only(top: 50),
          content: Text("Error during login: ${e.code}", overflow: TextOverflow.ellipsis),
        ),
      );
    }
  }
}