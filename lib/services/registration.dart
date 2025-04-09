import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

Future<void> registerUser(String email, String matricNumber, String department,
    String fullName, BuildContext context) async {

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
    // Step 1: Create user with email and a dummy password
    UserCredential userCredential =
        await FirebaseAuth.instance.createUserWithEmailAndPassword(
      email: email,
      password: "student123", // Use a dummy password for all users
    );

    // Step 2: Store user data in Firestore
    await FirebaseFirestore.instance
        .collection('users')
        .doc(userCredential.user!.uid)
        .set({
      'email': email,
      'matricNumber': matricNumber,
      'department': department,
      'fullName': fullName,
    });

   //Display successfully registration scaffold
    if(context.mounted){
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("You've successfully registered 😎", overflow: TextOverflow.ellipsis),
        ),
      );
    }
    //delay for one second
    await Future.delayed(const Duration(seconds: 1),);

    // Check mounted after the async gap and Go to Dashboard
    if (context.mounted) {
      Navigator.pushReplacementNamed(
          context, '/Dashboard');
    }

    // If error occurs during registration
  } on FirebaseAuthException catch (e) {
    if(context.mounted){
      ScaffoldMessenger.of(context).clearSnackBars();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Error during registration: ${e.code}", overflow: TextOverflow.ellipsis),
        ),
      );
    }
  }
}
