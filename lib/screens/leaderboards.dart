import 'package:flutter/material.dart';

class LeaderBoards extends StatefulWidget {
  const LeaderBoards({super.key});

  @override
  State<LeaderBoards> createState() => _LeaderBoardsState();
}

 getCourseResults(){}

class _LeaderBoardsState extends State<LeaderBoards> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
        title: const Text('LeaderBoards'),
      ),
      backgroundColor: Colors.tealAccent,
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          children: [
            Center(
              child: MaterialButton(
                color: Colors.lightBlueAccent,
                  onPressed: () => getCourseResults(),
              child: const Text('get leaders')),
            )
          ],
        ),
      ),
    ));
  }
}
