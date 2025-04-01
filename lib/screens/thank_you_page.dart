import 'dart:math';
import 'package:confetti/confetti.dart';
import 'package:flutter/material.dart';

import '../services/logout_user.dart';

class ThankYouPage extends StatefulWidget {
  const ThankYouPage({super.key});

  @override
  State<ThankYouPage> createState() => _ThankYouPageState();
}

class _ThankYouPageState extends State<ThankYouPage> {

  final _confettiController = ConfettiController();

  @override
  void initState() {
    // TODO: implement initState
    _confettiController.play();
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _confettiController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
  final double heights = MediaQuery.of(context).size.height;

    return PopScope(
      canPop: false,
      child: SafeArea(
          child: Scaffold(
        body: Stack(
          alignment: Alignment.topCenter,
          children: [
            const Image(
                image: AssetImage('assets/images/roshy.jpg'), fit: BoxFit.cover,
            ),
            ConfettiWidget(
                confettiController: _confettiController,
              blastDirection: pi / 2,
              emissionFrequency: 0.07,
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Center(
                child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Text('Congratulations!', style: TextStyle(fontSize: 30, color: Colors.deepPurple),),
                  SizedBox(height: heights * 0.02),
                  const Text('Your quiz result has been successfully submitted, thanks for joining us today.', textAlign : TextAlign.center, maxLines: 2,),
                  SizedBox(height: heights * 0.02),
                  ElevatedButton(
                    onPressed: () async {
                      await signOutUser(context);
                    },
                    child: const Text('Close'),
                  ),
                ],
                        ),
              ),
            ),
            ]
        ),
      )),
    );
  }
}
