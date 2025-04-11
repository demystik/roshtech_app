import 'package:flutter/material.dart';
import 'package:roshtech/screens/quiz_page.dart';
import 'dart:async';
import '../services/get_user_data.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  // List of all available courses
  final List<String> allCourses = ['mat101', 'mat113', 'phy101', 'chm101'];

  // Track selected courses
  final List<String> selectedCourses = [];
  late String? selectedCourse = '';
  String userName = '';
  String userMatricNumber = '';
  // Timer? timer;
  int timeRemaining = 3;

  setUser() async {
    Map<String, String> userData = await getUserData();
    String fullName = userData['fullName'] ?? "Unknown";
    String userMatricNum = userData['matricNumber'] ?? '';
    if (context.mounted) {
      setState(() {
        userName = fullName;
        userMatricNumber = userMatricNum;
      });
    }
  }

  // Timer(Dur)
  void startTimer() {
    Timer.periodic(const Duration(seconds: 1), (timer) {
      if (context.mounted) {
        setState(() {
          if (timeRemaining > 0) {
            timeRemaining--;
          } else {
            timer.cancel();
            displayInstruction();
          }
        });
      }
    });
  }

  displayInstruction() {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return SizedBox(
            child: AlertDialog(
              title: const Text('Instruction!'),
              content: const SingleChildScrollView(
                child: IntrinsicHeight(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: 8.0, vertical: 10.0),
                          child: Divider(
                            height: 1.0,
                            color: Colors.deepPurple,
                          )),
                      Text(
                        'You\'re to take one course at a time',
                        maxLines: 2,
                        style: TextStyle(fontSize: 15),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        'You\'re to answer 30 questions in 30 minutes',
                        maxLines: 2,
                        // textAlign: TextAlign.center,
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        'Make sure you submit before time elapses, otherwise it\'ll be submitted automatically',
                        maxLines: 3,
                        // textAlign: TextAlign.center,
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                          'Do not close/minimize the app while the quiz is ongoing, otherwise you will lose your quiz progress',
                          maxLines: 3,
                          // textAlign: TextAlign.center,
                          overflow: TextOverflow.ellipsis),
                    ],
                  ),
                ),
              ),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: const Text('Okay'),
                ),
              ],
            ),
          );
        });
  }

  @override
  void initState() {
    // TODO: implement initState
    // startTimer();
    setUser();
    super.initState();
  }

  bool get isCivilEngineeringStudents {
    return userMatricNumber.toUpperCase().endsWith('EC');
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    // double screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: const Text("Select Courses"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (isCivilEngineeringStudents)
              const Expanded(
                child: Column(
                  children: [
                    Center(
                      child: Text(
                        'NICESA 100L PRE-TEST',
                        style: TextStyle(
                          fontSize: 20,
                          color: Colors.deepPurple,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    Center(
                      child: Text(
                          textAlign: TextAlign.center,
                          style: TextStyle(),
                          'FROM THE OFFICE OF THE WELFARE DIRECTOR (ALPHA)'),
                    ),
                  ],
                ),
              ),
            Expanded(
              child: Row(
                children: [
                  const Icon(Icons.person),
                  Text(
                    'Hello!, $userName',
                    style: const TextStyle(overflow: TextOverflow.ellipsis),
                  ),
                  const Spacer(),
                  TextButton(
                      onPressed: () => displayInstruction(),
                      child: const Text('Instruction'))
                ],
              ),
            ),
            const Text(
              "Select any course below:",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),

            // Display checkboxes for each course
            ...allCourses.map((course) {
              return Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(8),
                  child: CheckboxListTile(
                      tileColor: Colors.greenAccent,
                      title: Text(course),
                      value: selectedCourse == course,
                      onChanged: (bool? isChecked) {
                        if (context.mounted) {
                          setState(() {
                            if (isChecked == true) {
                              selectedCourse = course;
                            }
                          });
                        }
                      }),
                ),
              );
            }),

            const SizedBox(height: 20),
            // Button to proceed to the quiz
            Expanded(
              child: Center(
                child: SizedBox(
                  width: screenWidth * 0.8,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.deepPurple,
                    ),
                    onPressed: () async {
                      if (selectedCourse != null) {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                QuizPage(selectedCourse:selectedCourse ?? '', userName:userName, userMatricNumber: userMatricNumber,),
                          ),
                        );
                      } else {
                        // Show a message if the user hasn't selected exactly 3 courses
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                              content: Text("Please select a course")),
                        );
                      }
                    },
                    child: const Text(
                      "Start Quiz",
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
