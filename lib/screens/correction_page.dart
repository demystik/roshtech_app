import 'package:flutter/material.dart';

class CorrectionPage extends StatefulWidget {
  final List<Map<String, dynamic>> questions;
  final List<String?> userAnswers;
  const CorrectionPage(
      {super.key, required this.questions, required this.userAnswers});

  @override
  State<CorrectionPage> createState() => _CorrectionPageState();
}

class _CorrectionPageState extends State<CorrectionPage> {
  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    final List<Map<String, dynamic>> allQuestions = widget.questions;
    for (var i = 0; i < allQuestions.length; i++) {
      allQuestions[i].remove('options');
      allQuestions[i]['selectedAnswer'] = widget.userAnswers[i];
      allQuestions[i]['questionNumber'] = i + 1;
    }
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(title: const Text('Corrections')),
      body: SizedBox(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: ListView(
            children: [
              ...allQuestions.map((eachQuestionMap) {
                String correctAnswer = eachQuestionMap['correctAnswer'];
                String selectedAnswer = eachQuestionMap['selectedAnswer'];
                String questionText = eachQuestionMap['questionText'];
                int questionNumber = eachQuestionMap['questionNumber'];
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    width: screenWidth * 0.7,
                      decoration: BoxDecoration(
                          border: correctAnswer == selectedAnswer
                              ? Border.all(color: Colors.red)
                              : Border.all(color: Colors.blueAccent),
                        borderRadius: BorderRadius.circular(15),
                        color: Colors.cyan.shade100,
                      ),
                      padding: const EdgeInsets.all(8),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Column(
                            crossAxisAlignment : CrossAxisAlignment.start,
                            children: [
                              Container(
                                width : screenWidth * 0.1,
                                height: screenHeight * 0.04,
                                padding : const EdgeInsets.all(4),
                                decoration:BoxDecoration(
                                  color: Colors.deepPurple,
                                  borderRadius: BorderRadius.circular(8.0),
                                ),
                                  child: Text('#$questionNumber', style: const TextStyle(color: Colors.white),),
                              ),
                              SizedBox(height: screenHeight * 0.02,),
                              Text(questionText, style: const TextStyle(fontSize: 18), softWrap: true,),
                              SizedBox(height: screenHeight * 0.02,),
                            ],
                          ),
                          Text('Correct Answer: $correctAnswer'),
                          Text('Selected Answer: $selectedAnswer'),
                        ],
                      )),
                );
              })
            ],
          ),
        ),
      ),
    ));
  }
}
