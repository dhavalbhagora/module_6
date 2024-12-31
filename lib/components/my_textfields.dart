import 'package:flutter/material.dart';

class MyTextFields extends StatelessWidget {
  final String hintext;
  final bool obscureText;
  final TextEditingController controller;
  final FocusNode? focusnode;

  const MyTextFields({
    super.key,
    required this.hintext,
    required this.obscureText,
    required this.controller,
    required this.focusnode,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25.0),
      child: TextField(
        obscureText: obscureText,
        controller: controller,
        focusNode: focusnode,
        decoration: InputDecoration(
            enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(
              color: Theme.of(context).colorScheme.tertiary,
            )),
            focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(
              color: Theme.of(context).colorScheme.primary,
            )),
            fillColor: Theme.of(context).colorScheme.secondary,
            filled: true,
            hintText: hintext,
            hintStyle: TextStyle(color: Theme.of(context).colorScheme.primary)),
      ),
    );
  }
}
