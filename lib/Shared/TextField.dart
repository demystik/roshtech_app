// import 'dart:ffi';

import 'package:flutter/material.dart';

class MyTextField extends StatelessWidget {
  const MyTextField({
    required this.labelText,
    required this.textFieldIcon,
    required this.textEditingController,
    super.key,
  });

  final String labelText;
  final IconData textFieldIcon;
  final TextEditingController textEditingController;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.grey.withOpacity(0.1),
        borderRadius: BorderRadius.circular(18),
      ),
      child: TextField(
        // autofillHints: ,
        controller: textEditingController,
        keyboardType: TextInputType.emailAddress,
        decoration: InputDecoration(
          enabledBorder: const UnderlineInputBorder(
            borderSide: BorderSide.none,
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: Colors.deepPurple, width: 1.0),
            borderRadius: BorderRadius.circular(18),
          ),
          labelText: labelText,
          labelStyle: const TextStyle(color: Colors.black26),
          prefixIcon: Icon(textFieldIcon),
          prefixIconColor: Colors.black26,
        ),
      ),
    );
  }
}

void test() {
  List<String> allCourses = [
    'Math',
    'Englis',
    'Computer',
    'Science',
  ];

  List<String> selectedCourses = [];

  allCourses.map((course) {
    return Padding(
      padding: EdgeInsets.all(8),
      child: CheckboxListTile(
        title: Text(course),
        value: selectedCourses.contains(course),
        onChanged: (bool? isChanged) {
          if (isChanged == true) {
            if (selectedCourses.length < 3) {
              selectedCourses.add(course);
            } else {
              print('You can only select 3 courses');
            }
          } else {
            selectedCourses.remove(course);
          }
        },
      ),
    );
  });
}
