// ignore_for_file: avoid_print

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:roshtech/screens/welcome_page.dart';

Future<void> signOutUser(BuildContext context) async {
  try {
    await FirebaseAuth.instance.signOut();
    await Future.delayed(
      const Duration(seconds: 1),
    );
    if (context.mounted) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => const WelcomePage(),
        ),
      );
    }
    // print("User signed out successfully!");
  } catch (e) {
    if (context.mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content:
              Text("Error during login: $e", overflow: TextOverflow.ellipsis),
        ),
      );
    }
  }
}
