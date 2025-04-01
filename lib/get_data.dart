import 'package:cloud_firestore/cloud_firestore.dart';
Future<List<Map<String, dynamic>>> getFirstResultsPerUser() async {
  // Group by user and get earliest timestamp using Firestore query
  final query = FirebaseFirestore.instance
      .collection('results')
      .orderBy('userId')
      .orderBy('timestamp');

  final snapshot = await query.get();

  // Process to get first result per user
  final Map<String, Map<String, dynamic>> firstResults = {};

  for (final doc in snapshot.docs) {
    final data = doc.data();
    final userId = data['userId'] as String;

    if (!firstResults.containsKey(userId)) {
      firstResults[userId] = data;
    }
  }

  return firstResults.values.toList();
}

// Future<List<Map<String, dynamic>>> getFirstResultsPerUser() async {
//   // First get all unique user IDs
//   final userIdsSnapshot = await FirebaseFirestore.instance
//       .collection('results')
//       .orderBy('userId')
//       .get();
//
//   final userIds = userIdsSnapshot.docs
//       .map((doc) => doc['userId'] as String)
//       .toSet()
//       .toList();
//
//   // Then get first result for each user
//   List<Map<String, dynamic>> firstResults = [];
//
//   for (final userId in userIds) {
//     final snapshot = await FirebaseFirestore.instance
//         .collection('results')
//         .where('userId', isEqualTo: userId)
//         .orderBy('timestamp')
//         .limit(1)
//         .get();
//
//     if (snapshot.docs.isNotEmpty) {
//       firstResults.add(snapshot.docs.first.data());
//     }
//   }
//
//   return firstResults;
// }