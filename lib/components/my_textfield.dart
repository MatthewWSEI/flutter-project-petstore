import 'package:flutter/material.dart';

class MyTextField extends StatelessWidget {
  final String hintText;
  final bool obscureText;
  final TextEditingController controller;
  final Icon icon;

  const MyTextField(
      {super.key,
      required this.hintText,
      required this.obscureText,
      required this.controller,
      required this.icon});

//   @override
//   Widget build(BuildContext context) {
//     return TextField(
//       controller: controller,
//       decoration: InputDecoration(
//           border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
//           hintText: hintText),
//       obscureText: obscureText,
//     );
//   }
// }

  @override
  Widget build(BuildContext context) {
    return Container(
      // margin: const EdgeInsets.only(top: 40, left: 20, right: 20),
      decoration: BoxDecoration(boxShadow: [
        BoxShadow(
            color: const Color(0xff1D1617).withOpacity(0.11),
            blurRadius: 40,
            spreadRadius: 0.0)
      ]),
      child: TextField(
        controller: controller,
        obscureText: obscureText,
        decoration: InputDecoration(
            filled: true,
            // fillColor: Colors.white,
            // contentPadding: const EdgeInsets.all(15),
            hintText: hintText,
            hintStyle: TextStyle(
                color: Theme.of(context).colorScheme.secondary, fontSize: 14),
            prefixIcon: Padding(
              padding: const EdgeInsets.all(12),
              child: icon,
            ),
            border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide.none)),
      ),
    );
  }
}
