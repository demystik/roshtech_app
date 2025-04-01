import 'package:cloud_firestore/cloud_firestore.dart';

Future<List<Map<String, dynamic>>> fetchRandomQuestions(String courseId) async {
  // Fetch all questions for the course
  QuerySnapshot querySnapshot = await FirebaseFirestore.instance
      .collection('courses')
      .doc(courseId)
      .collection('questions')
      .get();

  // Convert documents to a list of maps
  List<Map<String, dynamic>> questions = querySnapshot.docs
      .map((doc) => doc.data() as Map<String, dynamic>)
      .toList();

  // Shuffle the list
  questions.shuffle();

  // Select the first 10 questions
  return questions.take(10).toList();
}