// ignore_for_file: avoid_print

import 'package:cloud_firestore/cloud_firestore.dart';


Future<List<Map<String, dynamic>>> getFirstResultsPerUser() async {
  try {
    print('⏳ Starting to fetch quiz results...');

    // Get all documents ordered by timestamp (earliest first)
    final QuerySnapshot snapshot = await FirebaseFirestore.instance
        .collection('quiz_result')
        .orderBy('timestamp')
        .get();

    print('✅ Successfully fetched ${snapshot.docs.length} raw documents');

    // Print all raw documents for verification
    print('\n📄 RAW DOCUMENTS:');
    for (var i = 0; i < snapshot.docs.length; i++) {
      final doc = snapshot.docs[i];
      print('[Document ${i + 1}] ID: ${doc.id}');
      print('Data: ${doc.data()}');
      print('-----------------------');
    }

    // Group by matricNumber
    final Map<String, Map<String, dynamic>> firstResults = {};
    int duplicateCount = 0;

    for (final doc in snapshot.docs) {
      final data = doc.data() as Map<String, dynamic>;
      final matricNumber = data['matricNumber'] as String;

      if (!firstResults.containsKey(matricNumber)) {
        firstResults[matricNumber] = {
          'fullName': data['fullName'],
          'matricNumber': matricNumber,
          'scores': data['scores'],
          'percent': data['totalPercentage'],
        };
      } else {
        duplicateCount++;
      }
    }

    print('\n🔍 PROCESSED RESULTS:');
    print('• Unique users: ${firstResults.length}');
    print('• Duplicates skipped: $duplicateCount');

    // Print all processed results
    print('\n🏆 FINAL RESULTS:');
    firstResults.forEach((matric, result) {
      print('Matric: $matric');
      print('Name: ${result['fullName']}');
      print('Scores: ${result['scores']}');
      print('Percentage: ${result['percent']}%');
      print('-----------------------');
    });

    return firstResults.values.toList();
  } catch (e) {
    print('❌ ERROR in getFirstResultsPerUser: $e');
    return [];
  }
}





// Future<List<Map<String, dynamic>>> getFirstResultsPerUser() async {
//   try {
//     // Get all documents ordered by timestamp (earliest first)
//     final QuerySnapshot snapshot = await FirebaseFirestore.instance
//         .collection('quiz_result')
//         .orderBy('timestamp')
//         .get();
//
//     // Group by matricNumber (assuming this is the unique user identifier)
//     final Map<String, Map<String, dynamic>> firstResults = {};
//
//     for (final doc in snapshot.docs) {
//       final data = doc.data() as Map<String, dynamic>;
//       final matricNumber = data['matricNumber'] as String; // Using matricNumber as user identifier
//
//       // Only keep the first result for each matricNumber
//       if (!firstResults.containsKey(matricNumber)) {
//         firstResults[matricNumber] = {
//           'fullName': data['fullName'],
//           'matricNumber': matricNumber,
//           // 'timestamp': data['timestamp'],
//           'scores' : data['scores'],
//           'percent' : data['totalPercentage'],
//           // 'documentId': doc.id, // Include document ID if needed
//         };
//       }
//     }
//
//     return firstResults.values.toList();
//   } catch (e) {
//     print('Error in getFirstResultsPerUser: $e');
//     return [];
//   }
// }
//











