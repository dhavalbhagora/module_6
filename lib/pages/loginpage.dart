import 'package:flutter/material.dart';

import '../components/my_button.dart';
import '../components/my_textfields.dart';
import '../services/auth/auth_service.dart';

class LoginPage extends StatelessWidget {
  final TextEditingController _emailcontroller = TextEditingController();
  final TextEditingController _passcontroller = TextEditingController();

  final void Function()? onTap;

  LoginPage({super.key, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Logo
          Icon(
            Icons.messenger,
            size: 60,
            color: Theme.of(context).colorScheme.primary,
          ),
          SizedBox(height: 50),

          // Welcome message
          Text(
            "Welcome Back, you've been missed",
            style: TextStyle(
              color: Theme.of(context).colorScheme.primary,
              fontSize: 16,
            ),
          ),
          SizedBox(height: 25),

          // Email TextField
          MyTextFields(
            hintext: "Enter Email",
            obscureText: false,
            controller: _emailcontroller,
            focusnode: null,
          ),
          SizedBox(height: 10),

          // Password TextField
          MyTextFields(
            hintext: "Enter Password",
            obscureText: true,
            controller: _passcontroller,
            focusnode: null,
          ),
          SizedBox(height: 25),

          // Login Button
          MyButton(
            text: "Login",
            onTap: () => login(context),
          ),
          SizedBox(height: 25),

          // Register Now Link
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Not a Member?",
                style: TextStyle(color: Theme.of(context).colorScheme.primary),
              ),
              GestureDetector(
                onTap: onTap, // Ensure onTap is correctly passed
                child: Text(
                  "Register Now",
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.primary,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  void login(BuildContext context) async {
    final authService = AuthService();

    try {
      await authService.signInWithEmailPassword(
        _emailcontroller.text,
        _passcontroller.text,
      );
    } catch (e) {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text("Error"),
          content: Text(e.toString()),
        ),
      );
    }
  }
}
