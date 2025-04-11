
// ignore_for_file: avoid_print

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

Future<List<Map<String, dynamic>>> fetchUserRecentActivities() async  {
  try{
    User? user = FirebaseAuth.instance.currentUser;
    if(user == null){
      print('user not logged in');
      return [];
    }

    QuerySnapshot query = await FirebaseFirestore.instance
        .collection('quiz_result')
        .where('userId', isEqualTo: user.uid)
        .orderBy('timestamp', descending: true)
        .limit(10)
        .get();

    return query.docs.map((doc) {
      return {
        'course': doc['selectedCourse'],
        'score': doc['scores'][doc['selectedCourse']],
        'percentage': doc['totalPercentage'],
        'timestamp': (doc['timestamp'] as Timestamp?)?.toDate() ?? DateTime.now(),
      };
    }).toList();
  }
  catch (e) {
    print('Error fetching activities: $e');
    return [];
  }
}