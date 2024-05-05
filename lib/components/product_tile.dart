import 'package:flutter/material.dart';
import 'package:flutter_img/flutter_img.dart';
import 'package:flutter_project_store/helper/helper_function.dart';

class ProductTile extends StatelessWidget {
  final String name;
  final int price;
  final void Function()? onTap;
  const ProductTile(
      {super.key,
      required this.name,
      required this.price,
      required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 40),
          width: 220,
          decoration: BoxDecoration(
              gradient: LinearGradient(colors: [
                const Color(0xff9DCEFF).withOpacity(0.7),
                const Color(0xff92A3FD).withOpacity(0.7)
              ]),
              borderRadius: BorderRadius.circular(20)),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const Img(
                "assets/images/product.png",
                width: 150,
                height: 150,
              ),
              const SizedBox(
                height: 10,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    name,
                    style: const TextStyle(
                      fontWeight: FontWeight.w900,
                      fontSize: 20,
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Row(
                    children: [
                      Text(
                        formatPrice(price),
                        style: const TextStyle(
                            // color: Color(0xff7B6F72),
                            fontSize: 16,
                            fontWeight: FontWeight.w400),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ));
  }
}
