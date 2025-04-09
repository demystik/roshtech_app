import 'package:flutter/material.dart';
import '../Shared/constants.dart';
// import 'package:percent_indicator/percent_indicator.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({super.key});

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {

  navigator(String toPage) {
    if(toPage == 'take_quiz'){
      Navigator.pushReplacementNamed(context, '/home');
    }
  }

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery
        .of(context)
        .size
        .height;
    double screenWidth = MediaQuery
        .of(context)
        .size
        .width;

    return SafeArea(
      child: Scaffold(
        body: Stack(
          children: [
          //Background
          Container(
          width: double.infinity,
          height: double.infinity,
          decoration: BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  Colors.deepPurple.withAlpha(200),
                  Colors.deepPurple.withAlpha(100),
                  Colors.deepPurple.withAlpha(150),
                  Colors.deepPurple.withAlpha(80),
                ]),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
          //Top Information
          Row(
          children: [
          Expanded(
          flex: 2,
            child: Row(
              children: [
                const CircleAvatar(
                  radius: 18,
                  child: Icon(
                    Icons.person_2_rounded,
                    size: 24,
                  ),
                ),
                Padding(
                  padding:
                  const EdgeInsets.symmetric(horizontal: 5.0),
                  child: SizedBox(
                    width: screenWidth * 0.5,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Nurudeen Roqeeb Alowonle Ajao',
                          // maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(color: Colors.white),
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 8, vertical: 2),
                          decoration: BoxDecoration(
                            color: Colors.black12,
                            borderRadius: BorderRadius.circular(15),
                          ),
                          child: const Text(
                            '2024/1/72712EC',
                            // maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                                color: Colors.white, fontSize: 12),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.all(1),
            decoration: BoxDecoration(
              color: Colors.white,
              shape: BoxShape.rectangle,
              borderRadius: BorderRadius.circular(18),
            ),
            child: const Row(
              children: [
                CircleAvatar(
                  radius: 18,
                  backgroundColor: Colors.green,
                  child: Icon(
                    Icons.energy_savings_leaf,
                    size: 20,
                    color: Colors.white,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 8.0),
                  child: Text(
                    '1000',
                    style: TextStyle(color: Colors.black),
                    maxLines: 2,
                    overflow: TextOverflow.fade,
                  ),
                ),
              ],
            ),
          ),
          ],
        ),

        SizedBox(
          height: screenHeight * 0.05,
        ),

        //Profile Container
        Container(
          height: 120,
          width: screenWidth,
          decoration: BoxDecoration(
              gradient: const LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [Colors.lightBlueAccent, Colors.cyanAccent]),
              // border: Border.all(width: 1, color: Colors.white),
              borderRadius: BorderRadius.circular(20),
              boxShadow: const [
                BoxShadow(
                  color: Colors.black26,
                  offset: Offset(2.0, 2.0),
                  blurRadius: 2,
                  spreadRadius: 1.0,
                )
              ]),
          child: Row(
            children: [
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 10.0),
                //Recent Quiz Image
                child: FittedBox(
                    child: Image(
                      image: AssetImage('assets/images/quiz2.png'),
                      height: 100,
                    )),
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  //Recent Quiz and No of Questions
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Recent Quiz',
                            style: kMediumText,
                          ),
                          Text(
                            '30 Questions',
                            style: kSmallText,
                          ),
                        ],
                      ),
                      SizedBox(
                        width: screenWidth * 0.14,
                      ),
                      const CircleAvatar(
                        radius: 16,
                        backgroundColor: Colors.white,
                        child: Icon(
                          Icons.quiz_outlined,
                          size: 18,
                        ),
                      ),
                    ],
                  ),
                  const Divider(
                    thickness: 2,
                    color: Colors.green,
                  ),
                ],
              ),
            ],
          ),
        ),

        SizedBox(
          height: screenHeight * 0.05,
        ),

        const Text(
          'Available Quizes',
          style: kMediumText,
        ),
        //Available Quizes
        SizedBox(
          height: 100,
          child: ListView(
            scrollDirection: Axis.horizontal,
            children: [
              courseContainer(
                'mat101',
                const AssetImage('assets/images/maths.png'),
              ),
              courseContainer(
                'mat113',
                const AssetImage('assets/images/math.png'),
              ),
              courseContainer(
                'chm101',
                const AssetImage('assets/images/chemistry.png'),
              ),
              courseContainer(
                'phy101',
                const AssetImage('assets/images/physics.png'),
              ),
              courseContainer(
                'gst101',
                const AssetImage('assets/images/chemistry.png'),
              ),
            ],
          ),
        ),

        Expanded(
          child: GridView.count(
              crossAxisCount: 2,
              children: [
          GestureDetector(
          onTap: navigator('take_quiz'),
          child: gridContainer(
          'Take Quiz',
          'Explore Available Quizes',
          const AssetImage('assets/images/dashboard.png'),
          Icons.school,
        ),
      ),
      gridContainer('Past Questions', 'Check Past Questions',
          const AssetImage('assets/images/quiz1.png'), null),
      gridContainer(
          'Recent Activities',
          'Check your performance',
          const AssetImage('assets/images/activity.png'),
          null),
      gridContainer(
          'Leaderboards',
          'Explore the leaderboards',
          const AssetImage('assets/images/leaderboard.png'),
          null),
      ],
    ),
    ),
    ],
    ),
    )
    ],
    ))
    ,
    );
  }

  courseContainer(String courseName, AssetImage imagePath) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            decoration: BoxDecoration(
              border: Border.all(width: 1, color: Colors.white60),
              borderRadius: BorderRadius.circular(10),
              color: Colors.white54,
            ),
            width: 80,
            padding: const EdgeInsets.all(5),
            child: Image(
                image: imagePath, fit: BoxFit.contain, width: 40, height: 40),
          ),
        ),
        Text(
          courseName,
          style: kSmallText,
        ),
      ],
    );
  }

  gridContainer(String toWhere, String underCaption, AssetImage imagePath,
      IconData? directIcon) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: Container(
          height: 200,
          padding: const EdgeInsets.all(5.0),
          color: Colors.white,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(5.0),
                  child: Container(
                      width: double.infinity,
                      color: Colors.black12,
                      child: FittedBox(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Center(
                                child: Image(
                                  image: imagePath,
                                  fit: BoxFit.contain,
                                  height: 80,
                                )),
                          ))),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(toWhere),
                        SizedBox(
                            width: directIcon != null ? 80 : 120,
                            child: Text(
                              underCaption,
                              style: kSmallTextBlack,
                              overflow: TextOverflow.ellipsis,
                            )),
                      ],
                    ),
                    if (directIcon != null)
                      Expanded(
                        child: CircleAvatar(
                          radius: 15,
                          backgroundColor: Colors.green,
                          child: Icon(
                            directIcon,
                            color: Colors.white,
                            size: 18,
                          ),
                        ),
                      )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}


// new CircularPercentIndicator(
// radius: 100.0,
// lineWidth: 10.0,
// percent: 0.8,
// header: new Text("Icon header"),
// center: new Icon(
// Icons.person_pin,
// size: 50.0,
// color: Colors.blue,
// ),
// backgroundColor: Colors.grey,
// progressColor: Colors.blue,
// ),


