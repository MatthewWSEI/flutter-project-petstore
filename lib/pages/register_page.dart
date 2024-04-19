import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_img/flutter_img.dart';
import 'package:flutter_project_store/components/my_main_button.dart';
import 'package:flutter_project_store/components/mytextfield.dart';
import 'package:flutter_project_store/helper/helper_function.dart';

class RegisterPage extends StatefulWidget {
  final void Function()? onTap;

  const RegisterPage({super.key, required this.onTap});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  TextEditingController userNameController = TextEditingController();

  TextEditingController emailController = TextEditingController();

  TextEditingController passwordController = TextEditingController();

  TextEditingController confirmPasswordController = TextEditingController();

  void registerUser() async {
    showDialog(
        context: context,
        builder: (context) => const Center(
              child: CircularProgressIndicator(),
            ));

    if (passwordController.text != confirmPasswordController.text) {
      Navigator.pop(context);
      dispalyMessageToUser("Password don't match!", context);
    } else {
      try {
        UserCredential? userCredential = await FirebaseAuth.instance
            .createUserWithEmailAndPassword(
                email: emailController.text, password: passwordController.text);

        createUserDocument(userCredential);

        if (context.mounted) {
          Navigator.pop(context);
        }
      } on FirebaseAuthException catch (e) {
        Navigator.pop(context);
        dispalyMessageToUser(e.code, context);
      }
    }
  }

  Future<void> createUserDocument(UserCredential? userCredential) async {
    if (userCredential != null && userCredential.user != null) {
      await FirebaseFirestore.instance
          .collection("Users")
          .doc(userCredential.user!.email)
          .set({
        'email': userCredential.user!.email,
        "username": userNameController.text
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(25.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              const Column(
                children: [
                  Img(
                    "assets/images/store.png",
                    width: 100,
                    height: 100,
                  ),
                  // Icon(
                  //   Icons.store,
                  //   size: 80,
                  //   color: Theme.of(context).colorScheme.inversePrimary,
                  // ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    "Pet Store",
                    style: TextStyle(fontSize: 40),
                  ),
                ],
              ),
              Column(
                children: [
                  MyTextField(
                    hintText: "Username",
                    obscureText: false,
                    controller: userNameController,
                    icon: const Icon(
                      Icons.person,
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  MyTextField(
                    hintText: "Email",
                    obscureText: false,
                    controller: emailController,
                    icon: const Icon(Icons.email),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  MyTextField(
                    hintText: "Password",
                    obscureText: true,
                    controller: passwordController,
                    icon: const Icon(Icons.key),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  MyTextField(
                    hintText: "Confirm Password",
                    obscureText: true,
                    controller: confirmPasswordController,
                    icon: const Icon(Icons.repeat),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  const SizedBox(
                    height: 25,
                  ),
                  MyMainButton(text: "Register", onTap: registerUser),
                  const SizedBox(
                    height: 25,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text("Already have an account? "),
                      GestureDetector(
                        onTap: widget.onTap,
                        child: const Text(
                          "Login here",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ),
                    ],
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
