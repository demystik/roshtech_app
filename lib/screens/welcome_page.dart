import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';


class WelcomePage extends StatelessWidget {
  const WelcomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.deepPurple,
        title: const Text(
          'Team Roshtech Group',
          style: TextStyle(
            fontFamily: 'neue',
            fontWeight: FontWeight.w100,
            color: Colors.white,
          ),
        ),
      ),
      body: Stack(children: [
        Container(
          decoration: const BoxDecoration(
              image: DecorationImage(
                opacity: 0.5,
            fit: BoxFit.cover,
            image: AssetImage('assets/images/roshtech_bg.png'),
          )),
        ),

        /*
        *  The Upper Stack
        * Contains quiz lotties, Powered by text
        * */
        Column(
          children: [
            Expanded(
              flex: 4,
              child: Lottie.asset('assets/lotties/quizlottie1.json'),
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.6,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.deepPurple,
                ),
                  onPressed: () {
                Navigator.pushNamed(context, '/loginPage');
              }, child: const Text('Start!', style: TextStyle(color: Colors.white),)),
            ),
            Expanded(
              flex: 1,
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: 50,
                      width: 50,
                      child: FittedBox(
                          child: Image.asset(
                        width: 50,
                        height: 50,
                        'assets/images/roshtech_logo.png',
                      )),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    RichText(
                        text: const TextSpan(
                          style: TextStyle(color: Colors.black87, fontSize: 16, fontStyle: FontStyle.italic),
                          children: [
                            TextSpan(text: 'Powered by '),
                            TextSpan(text: 'Team Roshtech Group', style: TextStyle(color: Colors.deepPurple)),
                          ]
                        ),
                      ),
                  ],
                ),
              ),
            ),
          ],
        )
      ]),
    ));
  }
}
