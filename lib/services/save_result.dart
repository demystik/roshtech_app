// ignore_for_file: avoid_print
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

Future<void> saveResultsToFirestore(String fullName, String matricNumber,
    Map<String, int> scores, List<Map<String, dynamic>> questions, String selectedCourse) async {

  try {
    //get user data
    final user = FirebaseAuth.instance.currentUser;
    if(user == null){
      print('no user logged in');
      return;
    }
    // Calculate total score percentage
    int? totalQuestions = questions.length;
    int? totalCorrectAnswers = scores.isNotEmpty
        ? scores[selectedCourse] ?? 0 : 0; // Default to 0 if scores is empty
    double totalPercentage = (totalCorrectAnswers / totalQuestions) * 100;

    await FirebaseFirestore.instance.collection('quiz_result').add({
      'fullName': fullName,
      'matricNumber': matricNumber,
      'scores': scores,
      'userId' : user.uid,
      'selectedCourse' : selectedCourse,
      'totalPercentage': totalPercentage,
      'timestamp': FieldValue.serverTimestamp(), // Add a timestamp
    });
    print("Results saved successfully!");
  } catch (e) {
    print("Error saving results: $e");
  }
}
