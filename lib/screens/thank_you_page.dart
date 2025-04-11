import 'dart:math';
import 'package:confetti/confetti.dart';
import 'package:flutter/material.dart';
import 'package:percent_indicator/percent_indicator.dart';

import 'correction_page.dart';

class ResultPage extends StatefulWidget {
  final Map<String, int> score;
  final String courseName;
  final String userName;
  final List<Map<String, dynamic>> questions;
  final List<String?> userAnswers;

  const ResultPage(
      {super.key,
      required this.score,
      required this.courseName,
      required this.userName,
      required this.questions, required this.userAnswers});

  @override
  State<ResultPage> createState() => _ResultPageState();
}

class _ResultPageState extends State<ResultPage> {
  final _confettiController = ConfettiController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _confettiController.play();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _confettiController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final double heights = MediaQuery.of(context).size.height;
    final double widths = MediaQuery.of(context).size.width;
    int? totalScore = widget.score[widget.courseName];
    int totalQuestion = widget.questions.length;
    String title = totalScore! / totalQuestion > 0.5 ? 'Oops!' : 'Hey Champ!';
    String subtitle = totalScore / totalQuestion > 0.5
        ? 'Your need to work on your performance'
        : 'Your performance is outstanding!';

    return PopScope(
      canPop: false,
      child: SafeArea(
          child: Scaffold(
        body: Stack(alignment: Alignment.topCenter, children: [
          //background image layer
          Container(
            width: double.infinity,
            height: double.infinity,
            color: Colors.lightBlueAccent,
          ),
          // const Image(
          //   image: AssetImage('assets/images/roshy.jpg'),
          //   fit: BoxFit.cover,
          // ),

          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    title,
                    style:
                        const TextStyle(fontSize: 30, color: Colors.deepPurple),
                  ),
                  SizedBox(height: heights * 0.02),
                  Text(
                    subtitle,
                    textAlign: TextAlign.center,
                    maxLines: 2,
                  ),
                  CircularPercentIndicator(
                    backgroundColor: Colors.grey,
                    // progressBorderColor: Colors.yellow,
                    progressColor: Colors.deepPurple,
                    radius: widths * 0.3,
                    lineWidth: 20.0,
                    animation: true,
                    center: Text(
                      '${(totalScore / totalQuestion) * 100}%',
                      style: TextStyle(fontSize: widths * 0.1),
                    ),
                    circularStrokeCap: CircularStrokeCap.round,
                    percent: totalScore / totalQuestion,
                    header: const Text('Total Score'),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(15),
                      child: Container(
                        padding: const EdgeInsets.all(15),
                        color: Colors.white,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Total Questions: $totalQuestion'),
                            const Padding(
                              padding: EdgeInsets.symmetric(horizontal: 10),
                              child: Divider(
                                color: Colors.black87,
                              ),
                            ),
                            Text('Correct Answers: $totalScore'),
                            const Padding(
                              padding: EdgeInsets.symmetric(horizontal: 10),
                              child: Divider(
                                color: Colors.black87,
                              ),
                            ),
                            Text('Course: ${widget.courseName}'),
                            const Padding(
                              padding: EdgeInsets.symmetric(horizontal: 10),
                              child: Divider(
                                color: Colors.black87,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: heights * 0.02),
                  // Corrections and leaderboard buttons
                  Row(
                    children: [
                      Padding(
                        padding:
                            EdgeInsets.symmetric(horizontal: widths * 0.05),
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.lightBlueAccent[100],
                          ),
                          onPressed: () => Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => CorrectionPage(
                                questions: widget.questions,
                                userAnswers: widget.userAnswers,
                              ),
                            ),
                          ),
                          child: const Center(child: Text('Corrections')),
                        ),
                      ),
                      Padding(
                        padding:
                            EdgeInsets.symmetric(horizontal: widths * 0.05),
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.lightBlueAccent[100],
                          ),
                          onPressed: () => Navigator.pushNamed(context, '/leaderboards'),
                          child: const Center(child: Text('LeaderBoard')),
                        ),
                      ),
                    ],
                  ),
                  //Close Button
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: widths * 0.05),
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.lightBlueAccent[100],
                      ),
                      onPressed: () =>
                          Navigator.pushReplacementNamed(context, '/dashboard'),
                      child: const Center(child: Text('Close')),
                    ),
                  ),
                ],
              ),
            ),
          ),
          //confetti layer
          ConfettiWidget(
            confettiController: _confettiController,
            blastDirection: pi / 2,
            emissionFrequency: 0.07,
          ),
        ]),
      )),
    );
  }
}
