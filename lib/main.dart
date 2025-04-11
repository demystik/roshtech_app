import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:roshtech/firebase_options.dart';
import 'package:roshtech/screens/dashboard.dart';
import 'package:roshtech/screens/home.dart';
import 'package:roshtech/screens/leaderboards.dart';
import 'package:roshtech/screens/login_page.dart';
import 'package:roshtech/screens/recent_activity.dart';
import 'package:roshtech/screens/register_page.dart';
import 'package:roshtech/screens/welcome_page.dart';




Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        fontFamily: 'neue'
      ),
      home: const AuthGate(),
      routes: {
        '/loginPage' : (context) => const LoginPage(),
        '/RegisterPage' : (context) => const RegisterPage(),
        '/home' : (context) => const HomeScreen(),
        '/dashboard' : (context) => const Dashboard(),
        '/leaderboards' : (context) => const LeaderBoards(),
        '/recentActivity' : (context) => const RecentActivity(),
      },
    );
  }
}


class AuthGate extends StatelessWidget {
  const AuthGate({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasData) {
          // ✅ User is logged in
          return const Dashboard();
        } else {
          // ❌ No user is logged in
          return const WelcomePage();
        }
      },
    );
  }
}