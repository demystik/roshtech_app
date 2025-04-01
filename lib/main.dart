import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:roshtech/firebase_options.dart';
import 'package:roshtech/screens/home.dart';
import 'package:roshtech/screens/login_page.dart';
import 'package:roshtech/screens/register_page.dart';
import 'package:roshtech/screens/thank_you_page.dart';
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
      home: const WelcomePage(),
      routes: {
        '/loginPage' : (context) => const LoginPage(),
        '/RegisterPage' : (context) => const RegisterPage(),
        '/home' : (context) => const HomeScreen(),
        '/ThankYouPage' : (context) => const ThankYouPage(),
      },
    );
  }
}
