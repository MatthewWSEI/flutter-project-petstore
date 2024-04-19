import 'package:flutter/material.dart';

class MyMainButton extends StatelessWidget {
  final String text;
  final void Function()? onTap;

  const MyMainButton({
    super.key,
    required this.text,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
            // color: Theme.of(context).colorScheme.primary,
            borderRadius: BorderRadius.circular(12),
            gradient: const LinearGradient(
                colors: [Color(0xff9DCEFF), Color(0xff92A3FD)])),
        padding: const EdgeInsets.all(25),
        child: Center(
          child: Text(
            text,
            style: const TextStyle(
                color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16),
          ),
        ),
      ),
    );
  }
}
