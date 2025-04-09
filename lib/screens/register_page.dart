import 'package:flutter/material.dart';
import 'package:roshtech/services/registration.dart';
import '../Shared/TextField.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {

 late bool checkBoxToggle = false;
 final _emailController = TextEditingController();
 final _matricNumberController = TextEditingController();
 final _departmentController = TextEditingController();
 final _fullNameController = TextEditingController();

 @override
  void dispose() {
    // TODO: implement dispose
   _departmentController.dispose();
   _emailController.dispose();
   _fullNameController.dispose();
   _matricNumberController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
          resizeToAvoidBottomInset: false,
      body: Stack(
        children: [
          const SizedBox(
            width: double.infinity,
            child: Image(
              image: AssetImage('assets/images/roshy1.jpg'),
              fit: BoxFit.cover,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(10),

            /*
            *  Upper Text
            *  Upper Text
            *  Upper Text
            *
            * */
            child: Column(
              children: [
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    alignment: Alignment.centerLeft,
                    child: const Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Spacer(),
                        Text(
                          // textAlign: TextAlign.start,
                          'Register',
                          style: TextStyle(
                              fontSize: 50,
                              height: 0.9,
                              fontWeight: FontWeight.bold),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Text(
                          'Hello! Sign up and join us 😎',
                          style: TextStyle(fontSize: 16),
                        ),
                      ],
                    ),
                  ),
                ),

                /*
              *
              * Detail Collection
              * Detail Collection
              * Detail Collection
              *
              * */
                Expanded(
                  flex: 2,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        width: double.infinity,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10.0),
                          child: MyTextField(
                              labelText: 'Your Department',
                              textFieldIcon: Icons.school,
                              textEditingController: _departmentController,
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      SizedBox(
                        width: double.infinity,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10.0),
                          child: MyTextField(
                              labelText: 'Your Full Name',
                              textFieldIcon: Icons.account_circle,
                              textEditingController: _fullNameController,
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 15,
                      ),
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
                        height: 15,
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
                      Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Row(
                          children: [
                            Checkbox(value: checkBoxToggle,
                                onChanged: (value){
                                setState(() {
                                  checkBoxToggle = !checkBoxToggle;
                                });
                                }
                            ),
                            const Text('I agree with privacy policy')
                          ],
                        )
                      )
                    ],
                  ),
                ),


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
                              String matricNumber = _matricNumberController.text.trim();
                              String fullName = _fullNameController.text.trim();
                              String department = _departmentController.text.trim();

                              if (email.isNotEmpty && matricNumber.isNotEmpty && fullName.isNotEmpty && department.isNotEmpty) {
                                await registerUser(email, matricNumber, department, fullName, context);

                              } else {
                                // Check mounted before using ScaffoldMessenger
                                if (mounted) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(content: Text('Please fill all the fields')),
                                  );
                                }
                              }
                            },
                            child: const Text(
                              'REGISTER',
                              style: TextStyle(
                                  fontSize: 25, fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 18.0),
                        child: Row(
                          children: [
                            const Text(
                              'You already have an account? ',
                              style: TextStyle(color: Colors.white),
                            ),
                            GestureDetector(
                              onTap: () {
                                Navigator.pop(context);
                              },
                              child: const Text('Sign in..', style: TextStyle(color: Colors.lightBlueAccent),),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          )
        ],
      ),
    ));
  }
}


// theDropDownButton() {
//   return DropdownButton(
//       icon: const Icon(Icons.keyboard_arrow_down_sharp),
//       // underline:
//       iconSize: 34,
//       dropdownColor: Colors.deepPurple,
//       iconEnabledColor: Colors.grey,
//       style: const TextStyle(color: Colors.white, fontSize: 20),
//       // value: _selectedValue,
//       // hint: ,
//       items: cityList,
//       onChanged: (newValue) {
//         // setState(() {});
//       }
//   );
// }

// static const List<DropdownMenuItem> cityList = [
//   DropdownMenuItem(value: 'Civil ', child: Text('civil'),),
//   DropdownMenuItem(value: 'Lagos', child: Text('Lagos'),),
//   DropdownMenuItem(value: 'Cairo', child: Text('Cairo'),),
//   DropdownMenuItem(value: 'Nairobi', child: Text('Nairobi'),),
//   DropdownMenuItem(value: 'Accra', child: Text('Accra'),),
//   DropdownMenuItem(value: 'Sydney', child: Text('Sydney'),),
//   DropdownMenuItem(value: 'Hong Kong', child: Text('Hong Kong'),),
//   DropdownMenuItem(value: 'Abidjan', child: Text('Abid'),),
// ];