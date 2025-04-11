// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
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

  fetchRecentActivities() async {
    try{
      List<Map<String, dynamic>> activities = await fetchUserRecentActivities();
      if (mounted) {
        setState(() {
          listOfActivities = activities;
          isLoading = false;
        });
      }
    } catch (e){
      print('Error fetching activities: $e');
      if (mounted) {
        setState(() {
          isLoading = false;
        });
      }
    }
    
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fetchRecentActivities();
  }

  @override
  Widget build(BuildContext context) {
    // if (listOfActivities.isEmpty) {
    //   return Scaffold(
    //     appBar: AppBar(
    //       title: const Text('Loading...'),
    //     ),
    //     body: const Center(
    //       child: CircularProgressIndicator(),
    //     ),
    //   );
    // }
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
        title: const Text('Recent Activities'),
      ),
      body: Stack(
        children : [ Positioned.fill(
          child: Padding(
            padding: const EdgeInsets.all(10),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  const Text('Recent Activities'),
                  isLoading ? const Center(child: CircularProgressIndicator()) :
                  listOfActivities.isEmpty
                      ? const Text('No recent activities', style: kSmallText)
                      : ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: listOfActivities.length,
                    itemBuilder: (context, index) {
                      final activity = listOfActivities[index];
                      return ListTile(
                        title: Text('${activity['course']} Quiz'),
                        subtitle: Text(
                          'Score: ${activity['score']} (${activity['percentage'].toStringAsFixed(1)}%)',
                        ),
                        trailing: Text(
                          activity['timestamp'].toString().substring(0, 10),
                        ),
                      );
                    },
                  ),
                ],
              ),
            )
          ),
        ),
        ]
      ),
    ));
  }
}
