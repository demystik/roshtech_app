// ignore_for_file: avoid_print

import 'package:cloud_firestore/cloud_firestore.dart';


Future<List<Map<String, dynamic>>> getLeaderboardForCourse(String course) async {
  try {
    //Fet quiz result for specific course
    QuerySnapshot query = await FirebaseFirestore.instance
        .collection('quiz_result')
        .where('selectedCourse', isEqualTo: course)
        .orderBy('totalPercentage', descending: true)
        .get();

    //Group by userId and calculate average totalPercentage
    Map<String, Map<String, dynamic>> userScores = {};
    for (var doc in query.docs) {
      final data = doc.data() as Map<String, dynamic>;
      final userId = data['userId'] as String;
      final percentage = (data['totalPercentage'] as num?)?.toDouble() ?? 0.0;
      final fullName = data['fullName'] as String? ?? 'Unknown';
      final matricNumber = data['matricNumber'] as String? ?? 'N/A';

      if (userScores.containsKey(userId)) {
        userScores[userId]!['totalPercentageSum'] += percentage;
        userScores[userId]!['quizCount'] += 1;
      } else {
        userScores[userId] = {
          'fullName': fullName,
          'matricNumber': matricNumber,
          'quizCount': 1,
          'totalPercentageSum': percentage,
        };
      }
    }

    //Calculate averages and convert to list
    List<Map<String, dynamic>> leaderboard = userScores.entries.map((entry) {
      final avgPercentage =
          entry.value['totalPercentageSum'] / entry.value['quizCount'];
      return {
        'userId': entry.key,
        'fullName': entry.value['fullName'],
        'matricNumber': entry.value['matricNumber'],
        'averagePercentage': avgPercentage,
        'quizCount': entry.value['quizCount'],
      };
    }).toList();

    //Sort by average percentage (descending)
    leaderboard.sort(
        (a, b) => b['averagePercentage'].compareTo(a['averagePercentage']));

    //Limit to top 10
    return leaderboard.take(10).toList();
  } catch (e){
    print('Error fetching leaderboard for $course: $e');
    return [];
  }
}
