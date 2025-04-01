// ignore_for_file: avoid_print
import 'package:cloud_firestore/cloud_firestore.dart';

Future<void> saveResultsToFirestore(String fullName, String matricNumber,
    Map<String, int> scores, List<Map<String, dynamic>> questions) async {
  try {
    // Calculate total score percentage
    int totalQuestions = questions.length;
    int totalCorrectAnswers = scores.isNotEmpty
        ? scores.values.reduce((a, b) =>
            (a) + (b)) // Calculate total correct answers if scores is not empty
        : 0; // Default to 0 if scores is empty
    double totalPercentage = (totalCorrectAnswers / totalQuestions) * 100;

    // Debug logs
    print("Saving results for $fullName ($matricNumber)");
    print("Scores: $scores");
    print("Total Percentage: $totalPercentage");
    // Save results to Firestore
    await FirebaseFirestore.instance.collection('quiz_result').add({
      'fullName': fullName,
      'matricNumber': matricNumber,
      'scores': scores,
      'totalPercentage': totalPercentage,
      'timestamp': FieldValue.serverTimestamp(), // Add a timestamp
    });

    print("Results saved successfully!");
  } catch (e) {
    print("Error saving results: $e");
  }
}
