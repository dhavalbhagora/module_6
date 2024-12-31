import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../components/my_button.dart';
import '../components/my_textfields.dart';

class RegisterPage extends StatelessWidget {
  final TextEditingController _emailcontroller = TextEditingController();
  final TextEditingController _passcontroller = TextEditingController();
  final TextEditingController _cpasscontroller = TextEditingController();
  void Function()? onTap;

  CollectionReference addUser =
      FirebaseFirestore.instance.collection('chatapp1');

  RegisterPage({super.key, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          //logo
          Icon(
            Icons.messenger,
            size: 60,
            color: Theme.of(context).colorScheme.primary,
          ),

          SizedBox(
            height: 50,
          ),

          //welcome back message
          Text(
            "Let's Create Account For You",
            style: TextStyle(
              color: Theme.of(context).colorScheme.primary,
              fontSize: 16,
            ),
          ),

          SizedBox(
            height: 25,
          ),

          //email textfields
          MyTextFields(
            hintext: "Enter Emails",
            obscureText: false,
            controller: _emailcontroller,
            focusnode: null,
          ),
          SizedBox(
            height: 10,
          ),

          //pw textfields
          MyTextFields(
            hintext: "Enter Passwords",
            obscureText: true,
            controller: _passcontroller,
            focusnode: null,
          ),
          SizedBox(
            height: 10,
          ),

          //cpw textfields
          MyTextFields(
            hintext: "Enter Conform Passwords",
            obscureText: true,
            controller: _cpasscontroller,
            focusnode: null,
          ),

          SizedBox(
            height: 25,
          ),

          //login button
          MyButton(
            text: "Register",
            onTap: () => register(context),
          ),

          SizedBox(
            height: 25,
          ),
          //register now
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Already Have Account",
                style: TextStyle(color: Theme.of(context).colorScheme.primary),
              ),
              GestureDetector(
                onTap: onTap,
                child: Text(
                  "Login Now",
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.primary,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              )
            ],
          )
        ],
      ),
    );
  }

  /*void register(BuildContext context) async {
    final email = _emailcontroller.text.trim();
    final password = _passcontroller.text.trim();
    final confirmPassword = _cpasscontroller.text.trim();

    if (email.isEmpty || password.isEmpty || confirmPassword.isEmpty) {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text("Error"),
          content: Text("All fields are required!"),
        ),
      );
      return;
    }

    if (password != confirmPassword) {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text("Error"),
          content: Text("Passwords do not match!"),
        ),
      );
      return;
    }

    try {
      // Register the user with Firebase Auth
      final auth = FirebaseAuth.instance;
      UserCredential userCredential = await auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      // Add user data to Firestore
      await addUser.add({
        'email': email,
        'createdAt': FieldValue.serverTimestamp(),
        'uid': userCredential.user?.uid,
      });

      // Success message
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text("Success"),
          content: Text("Account created successfully!"),
        ),
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
  }*/
  void register(BuildContext context) async {
    final email = _emailcontroller.text.trim();
    final password = _passcontroller.text.trim();
    final confirmPassword = _cpasscontroller.text.trim();

    if (email.isEmpty || password.isEmpty || confirmPassword.isEmpty) {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text("Error"),
          content: Text("All fields are required!"),
        ),
      );
      return;
    }

    if (password != confirmPassword) {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text("Error"),
          content: Text("Passwords do not match!"),
        ),
      );
      return;
    }

    try {
      // Register the user with Firebase Auth
      final auth = FirebaseAuth.instance;
      UserCredential userCredential = await auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      // Add user data to Firestore
      await addUser.add({
        'email': email,
        'createdAt': FieldValue.serverTimestamp(),
        'uid': userCredential.user?.uid,
      });

      // Success message
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text("Success"),
          content: Text("Account created successfully!"),
        ),
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
