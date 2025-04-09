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
        // autofillHints: "emailAddress",
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
