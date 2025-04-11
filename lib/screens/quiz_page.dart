import 'package:flutter/material.dart';
import 'package:roshtech/screens/thank_you_page.dart';
import 'dart:async';
import '../services/fetch_random_questions.dart';
import '../services/save_result.dart';

class QuizPage extends StatefulWidget {
  final String selectedCourse;
  final String userName;
  final String userMatricNumber;
  const QuizPage(
      {super.key,
      required this.selectedCourse,
      required this.userName,
      required this.userMatricNumber});

  @override
  State<QuizPage> createState() => _QuizPageState();
}

class _QuizPageState extends State<QuizPage> {
  List<Map<String, dynamic>> questions = [];
  // Map<String, List<Map<String, dynamic>>> courseQuestions =
  //     {}; // Track questions by course
  // int currentCourseIndex = 0;
  int currentQuestionIndex = 0;
  Map<String, int> scores = {}; // This will now properly track scores
  String? selectedAnswer;
  int timeRemaining = 1800; // This is 30 minutes in seconds
  Timer? timer;
  String currentCourse = ''; // Track current course being tested
  bool lastQuestion = false;
  List<String?> userAnswers = List<String?>.filled(30, null);


  @override
  void initState() {
    super.initState();
    // Initialize scores for all selected courses
    // for (var course in widget.selectedCourses) {
    scores[widget.selectedCourse] = 0;
    // }
    loadQuestions();
    startTimer();
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

  void startTimer() {
    timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        if (timeRemaining > 0) {
          if (timeRemaining < 60) {
            lastQuestion = true;
          }
          timeRemaining--;
        } else {
          timer.cancel();
          endQuiz(context);
        }
      });
    });
  }

  Future<void> loadQuestions() async {
    questions = await fetchRandomQuestions(widget.selectedCourse);
    // Load questions for each course separately
    // for (String course in widget.selectedCourses) {
    //   List<Map<String, dynamic>> courseQs = await fetchRandomQuestions(course);
    // courseQuestions[course] = courseQs;
    // questions.addAll(courseQs.map(
    //     (q) => {...q, 'course': course})); // Add course info to each question
    // }
    // Set the current course to the first one
    // if (widget.selectedCourses.isNotEmpty) {
    //   currentCourse = widget.selectedCourses.first;
    // }
    setState(() {});
  }

  void submitAnswer(String answer) {
    setState(() {
      selectedAnswer = answer;
      userAnswers[currentQuestionIndex] = selectedAnswer;
    });

    String correctAnswer = questions[currentQuestionIndex]['correctAnswer'];
    // String questionCourse = questions[currentQuestionIndex]['course'];

    // Update score for the specific course
    if (selectedAnswer == correctAnswer) {
      setState(() {
        // scores[questionCourse] = (scores[questionCourse] ?? 0) + 1;
        scores[widget.selectedCourse] =
            (scores[widget.selectedCourse] ?? 0) + 1;
      });
    }
  }

  void moveToPreviousQuestion() {
    if (currentQuestionIndex > 0) {
      setState(() {
        currentQuestionIndex--;
        selectedAnswer = userAnswers[currentQuestionIndex];

        // Update current course if we've moved to questions from a different course
        // String newCourse = questions[currentQuestionIndex]['course'];
        // if (newCourse != currentCourse) {
        //   currentCourse = newCourse;
        // }
      });
    }
  }

  void moveToNextQuestion() {
    // Move to next question or course
    if (currentQuestionIndex < questions.length - 1) {
      setState(() {
        currentQuestionIndex++;
        selectedAnswer = userAnswers[currentQuestionIndex];

        // Update current course if we've moved to questions from a different course
        // String newCourse = questions[currentQuestionIndex]['course'];
        // if (newCourse != currentCourse) {
        //   currentCourse = newCourse;
        // }

        //Check for last question
        if (currentQuestionIndex == questions.length - 1) {
          lastQuestion = true;
        }
      });
    }
  }

  void endQuiz(BuildContext currentContext) async {
    timer?.cancel();
    //show circular indicator while submitting result
    showDialog(
      context: context,
      barrierDismissible: false, // Prevent dismissing by tapping outside
      builder: (BuildContext context) {
        return const Center(
          child: CircularProgressIndicator(),
        );
      },
    );
    // Save results for each course
    await saveResultsToFirestore(widget.userName, widget.userMatricNumber,
        scores, questions, widget.selectedCourse);

    if (context.mounted) {
      Navigator.of(currentContext).pop();
      Navigator.pushReplacement(
        currentContext,
        MaterialPageRoute(
          builder: (currentContext) => ResultPage(
              score: scores,
              courseName: widget.selectedCourse,
              userName: widget.userName,
              questions: questions,
              userAnswers: userAnswers,
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    // double _height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    //Loading..
    if (questions.isEmpty) {
      return Scaffold(
        appBar: AppBar(title: const Text("Loading...")),
        body: const Center(child: CircularProgressIndicator()),
      );
    }

    Map<String, dynamic> currentQuestion = questions[currentQuestionIndex];
    // String currentCourseName = currentQuestion['course'];
    String currentCourseName = widget.selectedCourse;

    return PopScope(
      canPop: false,
      child: SafeArea(
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.grey.withOpacity(0.4),
            title: Text("Quiz - $currentCourseName"), // Show current course
            actions: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    Expanded(
                      child: Text(
                        "Time: ${timeRemaining ~/ 60}:${(timeRemaining % 60).toString().padLeft(2, '0')}",
                        style: const TextStyle(fontSize: 18),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          body: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Question ${currentQuestionIndex + 1} of ${questions.length}",
                  style: userAnswers[currentQuestionIndex] != null
                      ? const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w300,
                          color: Colors.green)
                      : const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w300,
                          color: Colors.deepPurple),
                ),
                const SizedBox(height: 20),
                Text(
                  maxLines: 3,
                  currentQuestion['questionText'],
                  style: const TextStyle(fontSize: 23),
                ),
                const SizedBox(height: 20),
                ...(currentQuestion['options'] as List<dynamic>).map((option) {
                  return Center(
                    child: SizedBox(
                      width: MediaQuery.of(context).size.width * 0.8,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 5.0),
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: selectedAnswer == option
                                ? Colors.blue
                                : Colors.grey[300],
                          ),
                          onPressed: () => submitAnswer(option),
                          child: Text(
                            option,
                            style: TextStyle(
                              color: selectedAnswer == option
                                  ? Colors.white
                                  : Colors.black,
                            ),
                          ),
                        ),
                      ),
                    ),
                  );
                }),
                const SizedBox(height: 20),
                /*
                * Previous and Next Buttons
                */
                Row(
                  children: [
                    //Previous Button
                    Padding(
                      padding: const EdgeInsets.only(left: 20.0),
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          // elevation: 4.0,
                          backgroundColor: Colors.lightBlueAccent[100],
                        ),
                        onPressed: currentQuestionIndex > 0
                            ? moveToPreviousQuestion
                            : null,
                        // selectedAnswer != null ? moveToNextQuestion : null,
                        child: const Text("Previous"),
                      ),
                    ),
                    const Spacer(),
                    //Next Button
                    Padding(
                      padding: const EdgeInsets.only(right: 20.0),
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          // elevation: 4.0,
                          backgroundColor: Colors.lightBlueAccent[100],
                        ),
                        onPressed: currentQuestionIndex < questions.length - 1
                            ? moveToNextQuestion
                            : null,
                        child: const Text("Next"),
                      ),
                    ),
                  ],
                ),
                const Spacer(),
                // Submit Button
                if (lastQuestion == true)
                  Align(
                    alignment: Alignment.center,
                    child: SizedBox(
                      width: width * 0.7,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.red[600],
                        ),
                        onPressed: () => endQuiz(context),
                        child: const Text(
                          'Submit',
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                  ),
                const Spacer(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
