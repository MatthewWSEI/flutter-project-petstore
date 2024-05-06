import 'package:flutter/material.dart';
import 'package:flutter_img/flutter_img.dart';

class CategoryTile extends StatelessWidget {
  final String name;
  final String iconName;
  final void Function()? onTap;
  const CategoryTile(
      {super.key,
      required this.name,
      required this.iconName,
      required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 10),
        width: 120,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            gradient: LinearGradient(colors: [
              const Color(0xff9DCEFF).withOpacity(0.7),
              const Color(0xff92A3FD).withOpacity(0.7)
            ])),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              width: 70,
              height: 70,
              decoration: const BoxDecoration(
                  color: Colors.white, shape: BoxShape.circle),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Img(
                  "assets/images/$iconName.png",
                  fit: BoxFit.fill,
                ),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Text(
              name,
              style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 16),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
