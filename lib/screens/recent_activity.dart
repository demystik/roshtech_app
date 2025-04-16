// ignore_for_file: avoid_print
import 'package:flutter/material.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:roshtech/services/fetch_user_recent_activities.dart';
import '../Shared/constants.dart';

class RecentActivity extends StatefulWidget {
  const RecentActivity({super.key});

  @override
  State<RecentActivity> createState() => _RecentActivityState();
}

class _RecentActivityState extends State<RecentActivity> {
  List<Map<String, dynamic>> listOfActivities = [];
  bool isLoading = true;
  String? errorMessage;
  final ScrollController _scrollController = ScrollController();

  /// Fetches recent user activities from Firestore and updates state.
  Future<void> fetchRecentActivities() async {
    try {
      List<Map<String, dynamic>> activities = await fetchUserRecentActivities();
      if (mounted) {
        setState(() {
          listOfActivities = activities;
          isLoading = false;
        });
      }
    } catch (e) {
      print('Error fetching activities: $e');
      if (mounted) {
        setState(() {
          errorMessage = 'Failed to load activities: $e';
          isLoading = false;
        });
      }
    }
  }

  @override
  void initState() {
    super.initState();
    fetchRecentActivities();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  /// Builds a single activity tile for the ListView.
  Widget _buildActivityTile(Map<String, dynamic> activity, int index, double screenHeight) {
    final String percent = activity['percentage'].toStringAsFixed(0);
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 8.0),
      child: Card(
        elevation: 2,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        color: index % 2 == 0 ? Colors.grey[100] : Colors.grey[200],
        child: ListTile(
          leading: CircularPercentIndicator(
            radius: 20,
            lineWidth: 4,
            circularStrokeCap: CircularStrokeCap.round,
            animation: true,
            percent: activity['percentage'] / 100,
            progressColor: Colors.green,
            backgroundColor: Colors.grey[300]!,
          ),
          title: Text('${activity['course']} Quiz', style: kMediumText),
          subtitle: Text('Score: ${activity['score']} ($percent%)', style: kSmallText),
          trailing: Text(
            activity['timestamp'].toString().substring(0, 10),
            style: kSmallText,
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final double screenHeight = MediaQuery.of(context).size.height;
    final double screenWidth = MediaQuery.of(context).size.width;

    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.deepPurple,
        appBar: AppBar(
          title: const Text('Recent Activities'),
          backgroundColor: Colors.deepPurple,
        ),
        body: Stack(
          children: [
            // Main content
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: isLoading
                  ? const Center(child: CircularProgressIndicator(color: Colors.white))
                  : errorMessage != null
                  ? Center(child: Text(errorMessage!, style: kMediumText.copyWith(color: Colors.white)))
                  : SingleChildScrollView(
                controller: _scrollController,
                child: Column(
                  children: [
                    SizedBox(height: screenHeight * 0.15), // Space for avatar
                    Container(
                      decoration: const BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.vertical(top: Radius.circular(18)),
                      ),
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                              height: screenHeight * 0.08,
                              decoration: BoxDecoration(
                                color: Colors.deepPurple,
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                                child: Row(
                                  children: [
                                    Flexible(
                                      child: Text(
                                        "You've taken ${listOfActivities.length} quizzes so far",
                                        style: kMediumText.copyWith(color: Colors.white),
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          listOfActivities.isEmpty
                              ? const Padding(
                            padding: EdgeInsets.all(16.0),
                            child: Text('No recent activities', style: kSmallText),
                          )
                              : ListView.builder(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount: listOfActivities.length,
                            itemBuilder: (context, index) => _buildActivityTile(
                              listOfActivities[index],
                              index,
                              screenHeight,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            // Animated profile icon
            AnimatedBuilder(
              animation: _scrollController,
              builder: (context, child) {
                final double offset = _scrollController.hasClients ? _scrollController.offset : 0;
                final double opacity = (1 - (offset / (screenHeight * 0.15))).clamp(0, 1);
                final double translateY = offset * 0.5;

                return Transform.translate(
                  offset: Offset(0, translateY),
                  child: Opacity(
                    opacity: opacity,
                    child: Padding(
                      padding: EdgeInsets.only(top: screenHeight * 0.03),
                      child: Align(
                        alignment: Alignment.topCenter,
                        child: CircleAvatar(
                          radius: screenWidth * 0.15,
                          backgroundColor: Colors.transparent,
                          child: Container(
                            decoration: const BoxDecoration(
                              shape: BoxShape.circle,
                              gradient: LinearGradient(
                                colors: [Colors.green, Colors.lightGreen],
                                begin: Alignment.topLeft,
                                end: Alignment.bottomRight,
                              ),
                            ),
                            child: const Icon(
                              Icons.person_2_rounded,
                              size: 60,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}







// // ignore_for_file: avoid_print
// import 'package:flutter/material.dart';
// import 'package:percent_indicator/circular_percent_indicator.dart';
// import 'package:roshtech/services/fetch_user_recent_activities.dart';
// import '../Shared/constants.dart';
//
// class RecentActivity extends StatefulWidget {
//   const RecentActivity({super.key});
//
//   @override
//   State<RecentActivity> createState() => _RecentActivityState();
// }
//
// class _RecentActivityState extends State<RecentActivity> {
//   List<Map<String, dynamic>> listOfActivities = [];
//   bool isLoading = true;
//   bool isScrolling = false;
//
//   fetchRecentActivities() async {
//     try {
//       List<Map<String, dynamic>> activities = await fetchUserRecentActivities();
//       if (mounted) {
//         setState(() {
//           listOfActivities = activities;
//           isLoading = false;
//         });
//       }
//     } catch (e) {
//       print('Error fetching activities: $e');
//       if (mounted) {
//         setState(() {
//           isLoading = false;
//         });
//       }
//     }
//   }
//
//   @override
//   void initState() {
//     // TODO: implement initState
//     super.initState();
//     fetchRecentActivities();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     double screenHeight = MediaQuery.of(context).size.height;
//     return SafeArea(
//         child: Scaffold(
//       backgroundColor: Colors.deepPurple,
//       appBar: AppBar(
//         title: const Text('Recent Activities'),
//       ),
//       body: Stack(children: [
//         Container(
//           width: double.infinity,
//           height: double.infinity,
//           child: Positioned.fill(
//             child: Padding(
//                 padding: const EdgeInsets.all(10),
//                 child: SingleChildScrollView(
//                   child: Column(
//                     children: [
//                       SizedBox(
//                         height: screenHeight * 0.1,
//                       ),
//                       isLoading
//                           ? const Center(child: CircularProgressIndicator())
//                           : listOfActivities.isEmpty
//                           ? const Text('No recent activities',
//                           style: kSmallText)
//                           : Container(
//                         //top free space
//                         padding: EdgeInsets.only(top: screenHeight * 0.08),
//                         decoration: const BoxDecoration(
//                             color: Colors.white,
//                             borderRadius: BorderRadius.only(topLeft: Radius.circular(18.0), topRight: Radius.circular(18.0))
//                         ),
//                         child: Column(
//                           children: [
//                             Padding(
//                               padding: const EdgeInsets.all(4.0),
//                               child: Container(
//                                 height: screenHeight * 0.1,
//                                 // width: double.infinity,
//                                 decoration: BoxDecoration(
//                                   color: Colors.deepPurple,
//                                   borderRadius: BorderRadius.circular(8.0)
//                                 ),
//                                 child: Padding(
//                                   padding: const EdgeInsets.symmetric(horizontal: 8.0),
//                                   child: Row(
//                                     children: [
//                                       Text('You\'ve taken ${listOfActivities.length} quizes so far', style: const TextStyle(color: Colors.white),)
//                                     ],
//                                   ),
//                                 ),
//                               ),
//                             ),
//                             ListView.builder(
//                               shrinkWrap: true,
//                               physics: const NeverScrollableScrollPhysics(),
//                               itemCount: listOfActivities.length,
//                               itemBuilder: (context, index) {
//                                 final activity = listOfActivities[index];
//                                 String percent = activity['percentage'].toStringAsFixed(0);
//                                 return Padding(
//                                   padding: const EdgeInsets.all(4.0),
//                                   child: ClipRRect(
//                                     borderRadius: BorderRadius.circular(5),
//                                     child: Container(
//                                       color: [Colors.black12, Colors.cyanAccent][index % 2],
//                                       child: ListTile(
//                                         leading: CircularPercentIndicator(
//                                             radius: 20,
//                                           // lineWidth: ,
//                                           circularStrokeCap: CircularStrokeCap.round,
//                                           animation: true,
//                                           percent: activity['percentage'] / 100,
//                                         ),
//                                         title: Text('${activity['course']} Quiz'),
//                                         subtitle: Text(
//                                           'Score: ${activity['score']} ($percent%)',
//                                         ),
//                                         trailing: Text(
//                                           activity['timestamp']
//                                               .toString()
//                                               .substring(0, 10),
//                                         ),
//                                       ),
//                                     ),
//                                   ),
//                                 );
//                               },
//                             ),
//                           ],
//                         ),
//                       )
//                     ]
//                   ),
//                 )),
//           ),
//         ),
//         //person profile icon
//         Padding(
//           padding: EdgeInsets.only(top: screenHeight * 0.05),
//           child: const Align(
//             alignment: Alignment.topCenter,
//             child: CircleAvatar(
//               radius: 50,
//               backgroundColor: Colors.green,
//               child: Icon(Icons.person_2_rounded, size: 80,),
//             ),
//           ),
//         ),
//
//       ]),
//     ));
//   }
//
// }
