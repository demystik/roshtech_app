import 'package:flutter/material.dart';
import 'package:roshtech/services/login.dart';

import '../Shared/TextField.dart';
import '../services/exit_app.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _emailController = TextEditingController();
  final _matricNumberController = TextEditingController();

  @override
  void dispose() {
    // TODO: implement dispose
    _matricNumberController.dispose();
    _emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: Stack(children: [
          const SizedBox(
            width: double.infinity,
            child: Image(
              image: AssetImage('assets/images/roshy.jpg'),
              fit: BoxFit.cover,
            ),
          ),

          /*
          * Upper layer
          * Upper layer
          * */

          Padding(
            padding: const EdgeInsets.all(14.0),
            child: Column(
              // crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                //Welcome Back
                // and hey good to see you
                Expanded(
                  child: Container(
                    alignment: Alignment.centerLeft,
                    child: const Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Spacer(),
                        Text(
                          // textAlign: TextAlign.start,
                          'Welcome \nBack',
                          style: TextStyle(
                              fontSize: 50,
                              height: 0.9,
                              fontWeight: FontWeight.bold),
                        ),
                        Text(
                          'Hey! Good to see you again',
                          style: TextStyle(fontSize: 16),
                        ),
                      ],
                    ),
                  ),
                ),

                /*
                * The Buttons
                * Data Collection
                * */
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        width: double.infinity,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10.0),
                          child: MyTextField(
                            labelText: 'Your Email',
                            textFieldIcon: Icons.email_outlined,
                            textEditingController: _emailController,
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      SizedBox(
                        width: double.infinity,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10.0),
                          child: MyTextField(
                            labelText: 'Your Matric Number',
                            textFieldIcon: Icons.numbers,
                            textEditingController: _matricNumberController,
                          ),
                        ),
                      ),
                      const Padding(
                        padding: EdgeInsets.all(10.0),
                        child: Text(
                          'Forgot password?',
                          style: TextStyle(color: Colors.deepPurple),
                        ),
                      )
                    ],
                  ),
                ),

                /*
                *
                * Sign in Button
                *
                *
                * */
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        width: double.infinity,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 18.0),
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                padding: const EdgeInsets.all(10)),
                            onPressed: () async {
                              String email = _emailController.text.trim();
                              String matricNumber =
                                  _matricNumberController.text.trim();
                              if (email.isNotEmpty && matricNumber.isNotEmpty) {
                                // Dismiss the keyboard first
                                FocusScope.of(context).unfocus();
                                await loginUser(email, matricNumber, context);
                              } else {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    content: Text('Please Fill all the fields'),
                                  ),
                                );
                              }
                            },
                            child: const Text(
                              'SIGN IN',
                              style: TextStyle(
                                  fontSize: 25, fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 18.0),
                        child: Row(
                          children: [
                            const Text(
                              'Don\'t have an account? ',
                              style: TextStyle(color: Colors.white),
                            ),
                            GestureDetector(
                              onTap: () {
                                Navigator.pushNamed(context, '/RegisterPage');
                              },
                              child: const Text('Sign up..'),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 14),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 18.0),
                        child: Row(
                          children: [
                            const Icon(
                              Icons.exit_to_app_outlined,
                              size: 16,
                            ),
                            const SizedBox(width: 5),
                            GestureDetector(
                              onTap: () {
                                exitApp();
                              }, // Exit the app,
                              child: const Text('Exit...'),
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
        ]),
      ),
    );
  }
}
