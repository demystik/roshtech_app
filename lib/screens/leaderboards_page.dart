// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:roshtech/services/leaderboards.dart';

import '../Shared/constants.dart';

class LeaderBoards extends StatefulWidget {
  final String? initialCourse;
  const LeaderBoards({super.key, required this.initialCourse});

  @override
  State<LeaderBoards> createState() => _LeaderBoardsState();
}

class _LeaderBoardsState extends State<LeaderBoards> {
  bool isLoading = true;
  List<Map<String, dynamic>> leaderData = [];
  List<String> courses = ['mat101', 'mat113', 'phy101', 'chm101'];
  String selectedCourse = 'mat101';

  getLeaderBoardData() async {
    setState(() {
      isLoading = true;
    });
    try {
      List<Map<String, dynamic>> leaderBoard =
          await getLeaderboardForCourse(selectedCourse);
      setState(() {
        leaderData = leaderBoard;
        isLoading = false;
      });
    } catch (e) {
      print('Error in leaderBoard Data $e.code');
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if(widget.initialCourse != null) {
      selectedCourse = widget.initialCourse!;
      getLeaderBoardData();
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
        title: const Text('LeaderBoards'),
      ),
      backgroundColor: Colors.tealAccent,
      body: Stack(
          children: [
            //
            //Background...................
            //
            
        Positioned.fill(
          child: Padding(
            padding: const EdgeInsets.all(10),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  const Text('Leaders'),
                  DropdownButton(
                    value: selectedCourse,
                      items: courses.map((course){
                        return DropdownMenuItem(
                          value: course,
                            child: Text(course.toUpperCase())
                        );
                      }).toList(),
                      onChanged: (value) {
                      if(value != null){
                        setState(() {
                          selectedCourse = value;
                        });
                        getLeaderBoardData();
                      }
                      }
                  ),
                  isLoading ? const CircularProgressIndicator() :
                      leaderData.isEmpty ? const Text('Users has no leaderData') :
                          ListView.builder(
                            shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              itemCount: leaderData.length,
                              itemBuilder: (context, index) {
                              final entry = leaderData[index];
                              return Card(
                                  elevation: 2,
                                margin: const EdgeInsets.symmetric(vertical: 5.0),
                                child: ListTile(
                                  leading: CircleAvatar(
                                    backgroundColor: index < 3
                                        ? [Colors.yellow, Colors.grey, Colors.brown][index]
                                        : Colors.blueGrey,
                                    child: Text(
                                      '${index + 1}',
                                      style: const TextStyle(color: Colors.white),
                                    ),
                                  ),
                                  title: Text(entry['fullName'], style: kMediumText),
                                  subtitle: Text(
                                    'Matric: ${entry['matricNumber']} | Avg: ${entry['averagePercentage'].toStringAsFixed(1)}% (${entry['quizCount']} quizzes)',
                                    style: kSmallText,
                                  ),
                                ),
                              );
                              }
                          ),
                  Center(
                    child: MaterialButton(
                        color: Colors.lightBlueAccent,
                        onPressed: () => getLeaderBoardData(),
                        child: const Text('get leaders')),
                  )
                ],
              ),
            ),
          ),
        ),
      ]),
    ));
  }
}
