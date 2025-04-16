import 'package:flutter/material.dart';
import '../Shared/constants.dart';
import '../services/get_user_data.dart';
import '../services/logout_user.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({super.key});

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  String userName = '';
  String userMatricNumber = '';
  bool isLoading = true;
  String? errorMessage;

  /// Fetches user data and updates state with full name and matric number.
  Future<void> setUser() async {
    try {
      Map<String, String> userData = await getUserData();
      if (context.mounted) {
        setState(() {
          userName = userData['fullName'] ?? "Unknown";
          userMatricNumber = userData['matricNumber'] ?? '';
          isLoading = false;
        });
      }
    } catch (e) {
      if (context.mounted) {
        setState(() {
          errorMessage = 'Failed to load user data: $e';
          isLoading = false;
        });
      }
    }
  }

  /// Navigates to the specified page based on the provided route.
  void navigator(String toPage) {
    if (toPage == 'take_quiz') {
      Navigator.pushNamed(context, '/home');
    } else if (toPage == 'leaderboards') {
      Navigator.pushNamed(context, '/leaderboards');
    } else if (toPage == 'recent_activity') {
      Navigator.pushNamed(context, '/recentActivity', arguments: 'mat101');
    }
  }

  @override
  void initState() {
    super.initState();
    setUser();
  }

  @override
  Widget build(BuildContext context) {
    final double screenHeight = MediaQuery.of(context).size.height;
    final double screenWidth = MediaQuery.of(context).size.width;

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            onPressed: () {
              Scaffold.of(context).openDrawer(); // Placeholder for drawer
            },
            icon: const Icon(Icons.menu),
          ),
          title: const Text('Dashboard'),
          backgroundColor: Colors.deepPurple,
        ),
        backgroundColor: Colors.transparent,
        body: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                Colors.deepPurple.withAlpha(200),
                Colors.deepPurple.withAlpha(100),
                Colors.deepPurple.withAlpha(150),
                Colors.deepPurple.withAlpha(80),
              ],
            ),
          ),
          child: isLoading
              ? const Center(child: CircularProgressIndicator())
              : errorMessage != null
              ? Center(child: Text(errorMessage!, style: kMediumText))
              : SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // User Info
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Flexible(
                        child: Row(
                          children: [
                            const CircleAvatar(
                              radius: 20,
                              backgroundColor: Colors.white,
                              child: Icon(
                                Icons.person_2_rounded,
                                size: 24,
                                color: Colors.deepPurple,
                              ),
                            ),
                            const SizedBox(width: 8),
                            Flexible(
                              child: Column(
                                crossAxisAlignment:
                                CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    userName,
                                    style: kMediumText.copyWith(
                                        color: Colors.white),
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  Container(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 8, vertical: 4),
                                    decoration: BoxDecoration(
                                      color: Colors.black26,
                                      borderRadius:
                                      BorderRadius.circular(12),
                                    ),
                                    child: Text(
                                      userMatricNumber,
                                      style: kSmallText.copyWith(
                                          color: Colors.white),
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.all(2),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Row(
                          children: [
                            InkWell(
                              onTap: () async =>
                              await signOutUser(context),
                              child: const CircleAvatar(
                                radius: 20,
                                backgroundColor: Colors.green,
                                child: Icon(
                                  Icons.energy_savings_leaf,
                                  size: 20,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                            const Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 8.0),
                              child: Text(
                                '1000',
                                style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),

                  SizedBox(height: screenHeight * 0.03),

                  // Profile Container
                  Container(
                    height: screenHeight * 0.15,
                    decoration: BoxDecoration(
                      gradient: const LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: [
                          Colors.lightBlueAccent,
                          Colors.cyanAccent,
                        ],
                      ),
                      borderRadius: BorderRadius.circular(16),
                      boxShadow: const [
                        BoxShadow(
                          color: Colors.black26,
                          offset: Offset(2.0, 2.0),
                          blurRadius: 4,
                          spreadRadius: 1.0,
                        ),
                      ],
                    ),
                    child: Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Image.asset(
                            'assets/images/quiz2.png',
                            height: screenHeight * 0.1,
                            fit: BoxFit.contain,
                          ),
                        ),
                        const Expanded(
                          child: Padding(
                            padding: EdgeInsets.symmetric(
                                vertical: 8.0),
                            child: Column(
                              mainAxisAlignment:
                              MainAxisAlignment.center,
                              crossAxisAlignment:
                              CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Recent Quizzes',
                                  style: kMediumText,
                                ),
                                Text(
                                  '30 Questions',
                                  style: kSmallText,
                                ),
                              ],
                            ),
                          ),
                        ),
                        const Padding(
                          padding: EdgeInsets.all(8.0),
                          child: CircleAvatar(
                            radius: 18,
                            backgroundColor: Colors.white,
                            child: Icon(
                              Icons.quiz_outlined,
                              size: 20,
                              color: Colors.deepPurple,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),

                  SizedBox(height: screenHeight * 0.03),

                  // Available Quizzes
                  Text(
                    'Available Quizzes',
                    style: kMediumText.copyWith(color: Colors.white),
                  ),

                  SizedBox(
                    height: screenHeight * 0.15,
                    child: ListView(
                      scrollDirection: Axis.horizontal,
                      children: [
                        courseContainer(
                          'MAT101',
                          const AssetImage('assets/images/maths.png'),
                          screenWidth,
                        ),
                        courseContainer(
                          'MAT113',
                          const AssetImage('assets/images/math.png'),
                          screenWidth,
                        ),
                        courseContainer(
                          'CHM101',
                          const AssetImage(
                              'assets/images/chemistry.png'),
                          screenWidth,
                        ),
                        courseContainer(
                          'PHY101',
                          const AssetImage(
                              'assets/images/physics.png'),
                          screenWidth,
                        ),
                        courseContainer(
                          'GST101',
                          const AssetImage(
                              'assets/images/chemistry.png'),
                          screenWidth,
                        ),
                      ],
                    ),
                  ),

                  SizedBox(height: screenHeight * 0.03),

                  // Navigation Grid
                  LayoutBuilder(
                    builder: (context, constraints) {
                      final crossAxisCount =
                      screenWidth > 600 ? 3 : 2;
                      return GridView.count(
                        crossAxisCount: crossAxisCount,
                        shrinkWrap: true,
                        physics:
                        const NeverScrollableScrollPhysics(),
                        mainAxisSpacing: 8,
                        crossAxisSpacing: 8,
                        childAspectRatio: 1,
                        children: [
                          GestureDetector(
                            onTap: () => navigator('take_quiz'),
                            child: gridContainer(
                              'Take Quiz',
                              'Explore Available Quizzes',
                              const AssetImage(
                                  'assets/images/dashboard.png'),
                              Icons.school,
                              screenWidth,
                            ),
                          ),
                          GestureDetector(
                            onTap: () => navigator('recent_activity'),
                            child: gridContainer(
                              'Recent Activities',
                              'Check your performance',
                              const AssetImage(
                                  'assets/images/activity.png'),
                              Icons.history,
                              screenWidth,
                            ),
                          ),
                          GestureDetector(
                            onTap: () => navigator('leaderboards'),
                            child: gridContainer(
                              'Leaderboards',
                              'Explore the leaderboards',
                              const AssetImage(
                                  'assets/images/leaderboard.png'),
                              Icons.leaderboard,
                              screenWidth,
                            ),
                          ),
                        ],
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  /// Builds a course tile for the horizontal ListView.
  Widget courseContainer(String courseName, AssetImage imagePath, double screenWidth) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: screenWidth * 0.2,
            height: screenWidth * 0.2,
            decoration: BoxDecoration(
              border: Border.all(width: 1, color: Colors.white60),
              borderRadius: BorderRadius.circular(12),
              color: Colors.white54,
            ),
            padding: const EdgeInsets.all(8),
            child: Image(
              image: imagePath,
              fit: BoxFit.contain,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            courseName,
            style: kSmallText.copyWith(color: Colors.white),
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }

  /// Builds a grid tile for navigation options.
  Widget gridContainer(String title, String subtitle, AssetImage imagePath,
      IconData? icon, double screenWidth) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: ClipRRect(
              borderRadius:
              const BorderRadius.vertical(top: Radius.circular(12)),
              child: Image(
                image: imagePath,
                fit: BoxFit.cover,
                width: double.infinity,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Flexible(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title,
                        style: kMediumText.copyWith(
                            fontSize: 16, color: Colors.black87),
                      ),
                      Text(
                        subtitle,
                        style: kSmallText.copyWith(color: Colors.black54),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ),
                if (icon != null)
                  CircleAvatar(
                    radius: 16,
                    backgroundColor: Colors.green,
                    child: Icon(
                      icon,
                      size: 18,
                      color: Colors.white,
                    ),
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}



// import 'package:flutter/material.dart';
// import '../Shared/constants.dart';
// import '../services/get_user_data.dart';
// import '../services/logout_user.dart';
//
// class Dashboard extends StatefulWidget {
//   const Dashboard({super.key});
//
//   @override
//   State<Dashboard> createState() => _DashboardState();
// }
//
// class _DashboardState extends State<Dashboard> {
//   String userName = '';
//   String userMatricNumber = '';
//
//   setUser() async {
//     Map<String, String> userData = await getUserData();
//     String fullName = userData['fullName'] ?? "Unknown";
//     String userMatricNum = userData['matricNumber'] ?? '';
//     if (context.mounted) {
//       setState(() {
//         userName = fullName;
//         userMatricNumber = userMatricNum;
//       });
//     }
//   }
//
//   navigator(String toPage) {
//     if (toPage == 'take_quiz') {
//       Navigator.pushNamed(context, '/home');
//     } else if(toPage == 'leaderboards'){
//       Navigator.pushNamed(context, '/leaderboards');
//     } else if(toPage == 'recent_activity'){
//       Navigator.pushNamed(context, '/recentActivity', arguments: 'mat101');
//     }
//   }
//
//   @override
//   void initState() {
//     // TODO: implement initState
//     super.initState();
//     setUser();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     double screenHeight = MediaQuery.of(context).size.height;
//     double screenWidth = MediaQuery.of(context).size.width;
//
//     return SafeArea(
//       child: Scaffold(
//         appBar: AppBar(
//           leading: IconButton(onPressed: (){}, icon: const Icon(Icons.menu)),
//           title: const Text('Dashboard'),
//         ),
//           body: Stack(
//                   children: [
//           //Background
//           Container(
//             width: double.infinity,
//             height: double.infinity,
//             decoration: BoxDecoration(
//               gradient: LinearGradient(
//                   begin: Alignment.topLeft,
//                   end: Alignment.bottomRight,
//                   colors: [
//                     Colors.deepPurple.withAlpha(200),
//                     Colors.deepPurple.withAlpha(100),
//                     Colors.deepPurple.withAlpha(150),
//                     Colors.deepPurple.withAlpha(80),
//                   ]),
//             ),
//           ),
//           SingleChildScrollView(
//             child: Padding(
//               padding: const EdgeInsets.all(15.0),
//               child: SizedBox(
//                 height: screenHeight,
//                 width: screenWidth,
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     //Top Information
//                     Row(
//                       children: [
//                         Row(
//                           children: [
//                             const CircleAvatar(
//                               radius: 18,
//                               child: Icon(
//                                 Icons.person_2_rounded,
//                                 size: 24,
//                               ),
//                             ),
//                             Padding(
//                               padding:
//                                   const EdgeInsets.symmetric(horizontal: 5.0),
//                               child: SizedBox(
//                                 width: screenWidth * 0.5,
//                                 child: Column(
//                                   mainAxisAlignment: MainAxisAlignment.start,
//                                   crossAxisAlignment: CrossAxisAlignment.start,
//                                   children: [
//                                     Text(
//                                       userName,
//                                       // maxLines: 2,
//                                       overflow: TextOverflow.ellipsis,
//                                       style:
//                                           const TextStyle(color: Colors.white),
//                                     ),
//                                     Container(
//                                       padding: const EdgeInsets.symmetric(
//                                           horizontal: 8, vertical: 2),
//                                       decoration: BoxDecoration(
//                                         color: Colors.black12,
//                                         borderRadius: BorderRadius.circular(15),
//                                       ),
//                                       child: Text(
//                                         userMatricNumber,
//                                         // maxLines: 2,
//                                         overflow: TextOverflow.ellipsis,
//                                         style: const TextStyle(
//                                             color: Colors.white, fontSize: 12),
//                                       ),
//                                     ),
//                                   ],
//                                 ),
//                               ),
//                             ),
//                           ],
//                         ),
//                         Container(
//                           padding: const EdgeInsets.all(1),
//                           decoration: BoxDecoration(
//                             color: Colors.white,
//                             shape: BoxShape.rectangle,
//                             borderRadius: BorderRadius.circular(18),
//                           ),
//                           child: Row(
//                             children: [
//                               InkWell(
//                                 onTap : () async =>  await signOutUser(context),
//                                 child: const CircleAvatar(
//                                   radius: 18,
//                                   backgroundColor: Colors.green,
//                                   child: Icon(
//                                     Icons.energy_savings_leaf,
//                                     size: 20,
//                                     color: Colors.white,
//                                   ),
//                                 ),
//                               ),
//                               const Padding(
//                                 padding: EdgeInsets.symmetric(horizontal: 8.0),
//                                 child: Text(
//                                   '1000',
//                                   style: TextStyle(color: Colors.black),
//                                   maxLines: 2,
//                                   overflow: TextOverflow.fade,
//                                 ),
//                               ),
//                             ],
//                           ),
//                         ),
//                       ],
//                     ),
//
//                     SizedBox(
//                       height: screenHeight * 0.05,
//                     ),
//                     //Profile Container
//                     Container(
//                       height: 120,
//                       width: screenWidth,
//                       decoration: BoxDecoration(
//                           gradient: const LinearGradient(
//                               begin: Alignment.topLeft,
//                               end: Alignment.bottomRight,
//                               colors: [
//                                 Colors.lightBlueAccent,
//                                 Colors.cyanAccent
//                               ]),
//                           // border: Border.all(width: 1, color: Colors.white),
//                           borderRadius: BorderRadius.circular(20),
//                           boxShadow: const [
//                             BoxShadow(
//                               color: Colors.black26,
//                               offset: Offset(2.0, 2.0),
//                               blurRadius: 2,
//                               spreadRadius: 1.0,
//                             )
//                           ]),
//                       child: Row(
//                         children: [
//                           const Padding(
//                             padding: EdgeInsets.symmetric(horizontal: 10.0),
//                             //Recent Quiz Image
//                             child: FittedBox(
//                                 child: Image(
//                               image: AssetImage('assets/images/quiz2.png'),
//                               height: 100,
//                             )),
//                           ),
//                           Column(
//                             mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                             children: [
//                               //Recent Quiz and No of Questions
//                               Row(
//                                 mainAxisAlignment:
//                                     MainAxisAlignment.spaceBetween,
//                                 crossAxisAlignment: CrossAxisAlignment.start,
//                                 children: [
//                                   const Column(
//                                     crossAxisAlignment:
//                                         CrossAxisAlignment.start,
//                                     children: [
//                                       Text(
//                                         'Recent Quizes',
//                                         style: kMediumText,
//                                       ),
//                                       Text(
//                                         '30 Questions',
//                                         style: kSmallText,
//                                       ),
//                                     ],
//                                   ),
//                                   SizedBox(
//                                     width: screenWidth * 0.14,
//                                   ),
//                                   const CircleAvatar(
//                                     radius: 16,
//                                     backgroundColor: Colors.white,
//                                     child: Icon(
//                                       Icons.quiz_outlined,
//                                       size: 18,
//                                     ),
//                                   ),
//                                 ],
//                               ),
//                               const Divider(
//                                 thickness: 2,
//                                 color: Colors.green,
//                               ),
//                             ],
//                           ),
//                         ],
//                       ),
//                     ),
//
//                     SizedBox(
//                       height: screenHeight * 0.05,
//                     ),
//
//                     const Text(
//                       'Available Quizes',
//                       style: kMediumText,
//                     ),
//
//                     //Available Quizes
//                     SizedBox(
//                       width: double.infinity,
//                       height: 100,
//                       child: ListView(
//                         scrollDirection: Axis.horizontal,
//                         children: [
//                           courseContainer(
//                             'mat101',
//                             const AssetImage('assets/images/maths.png'),
//                           ),
//                           courseContainer(
//                             'mat113',
//                             const AssetImage('assets/images/math.png'),
//                           ),
//                           courseContainer(
//                             'chm101',
//                             const AssetImage('assets/images/chemistry.png'),
//                           ),
//                           courseContainer(
//                             'phy101',
//                             const AssetImage('assets/images/physics.png'),
//                           ),
//                           courseContainer(
//                             'gst101',
//                             const AssetImage('assets/images/chemistry.png'),
//                           ),
//                         ],
//                       ),
//                     ),
//
//                     //Direction indicator
//                     SizedBox(
//                       width: double.infinity,
//                       height: screenHeight * 0.5,
//                       child: GridView.count(
//                         crossAxisCount: 2,
//                         shrinkWrap: true,
//                         physics: const NeverScrollableScrollPhysics(),
//                         children: [
//                           GestureDetector(
//                             onTap: () => navigator('take_quiz'),
//                             child: gridContainer(
//                               'Take Quiz',
//                               'Explore Available Quizes',
//                               const AssetImage('assets/images/dashboard.png'),
//                               Icons.school,
//                             ),
//                           ),
//                           GestureDetector(
//                             onTap: () => navigator('past_question'),
//                             child: gridContainer(
//                                 'Past Questions',
//                                 'Check Past Questions',
//                                 const AssetImage('assets/images/quiz1.png'),
//                                 null),
//                           ),
//                           GestureDetector(
//                             onTap: () => navigator('recent_activity'),
//                             child: gridContainer(
//                                 'Recent Activities',
//                                 'Check your performance',
//                                 const AssetImage('assets/images/activity.png'),
//                                 null),
//                           ),
//                           GestureDetector(
//                             onTap: () => navigator('leaderboards'),
//                             child: gridContainer(
//                                 'Leaderboards',
//                                 'Explore the leaderboards',
//                                 const AssetImage(
//                                     'assets/images/leaderboard.png'),
//                                 null),
//                           ),
//                         ],
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//           )
//                   ],
//                 )),
//     );
//   }
//
//   courseContainer(String courseName, AssetImage imagePath) {
//     return Column(
//       children: [
//         Padding(
//           padding: const EdgeInsets.all(8.0),
//           child: Container(
//             decoration: BoxDecoration(
//               border: Border.all(width: 1, color: Colors.white60),
//               borderRadius: BorderRadius.circular(10),
//               color: Colors.white54,
//             ),
//             width: 80,
//             // height: 100,
//             padding: const EdgeInsets.all(5),
//             child: Image(
//                 image: imagePath, fit: BoxFit.contain, width: 40, height: 40),
//           ),
//         ),
//         Text(
//           courseName,
//           style: kSmallText,
//         ),
//       ],
//     );
//   }
//
//   gridContainer(String toWhere, String underCaption, AssetImage imagePath,
//       IconData? directIcon) {
//     return Padding(
//       padding: const EdgeInsets.all(8.0),
//       child: ClipRRect(
//         borderRadius: BorderRadius.circular(10),
//         child: Container(
//           height: 200,
//           padding: const EdgeInsets.all(5.0),
//           color: Colors.white,
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Expanded(
//                 child: ClipRRect(
//                   borderRadius: BorderRadius.circular(5.0),
//                   child: Container(
//                       width: double.infinity,
//                       color: Colors.black12,
//                       child: FittedBox(
//                           child: Padding(
//                         padding: const EdgeInsets.all(8.0),
//                         child: Center(
//                             child: Image(
//                           image: imagePath,
//                           fit: BoxFit.contain,
//                           height: 80,
//                         )),
//                       ))),
//                 ),
//               ),
//               Padding(
//                 padding: const EdgeInsets.all(8.0),
//                 child: Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   children: [
//                     Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         Text(toWhere),
//                         SizedBox(
//                             width: directIcon != null ? 80 : 120,
//                             child: Text(
//                               underCaption,
//                               style: kSmallTextBlack,
//                               overflow: TextOverflow.ellipsis,
//                             )),
//                       ],
//                     ),
//                     const Spacer(),
//                     if (directIcon != null)
//                       Expanded(
//                         child: CircleAvatar(
//                           radius: 15,
//                           backgroundColor: Colors.green,
//                           child: Icon(
//                             directIcon,
//                             color: Colors.white,
//                             size: 18,
//                           ),
//                         ),
//                       )
//                   ],
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
