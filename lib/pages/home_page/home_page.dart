import 'package:flutter/material.dart';
import 'package:flutter_img/flutter_img.dart';
import 'package:flutter_project_store/components/button.dart';
import 'package:flutter_project_store/components/mydrawer.dart';
import 'package:flutter_project_store/components/mytextfield.dart';
import 'package:flutter_project_store/pages/home_page/categories.dart';
import 'package:flutter_project_store/pages/home_page/recoemmendSection.dart';

class HomePage extends StatelessWidget {
  HomePage({super.key});

  TextEditingController searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text(
            'PET STORE',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          backgroundColor: Colors.transparent,
          foregroundColor: Theme.of(context).colorScheme.inversePrimary,
          centerTitle: true,
          elevation: 0,
          actions: [
            GestureDetector(
              onTap: () {},
              child: Container(
                padding: const EdgeInsets.only(right: 25),
                alignment: Alignment.center,
                width: 40,
                child: const Icon(Icons.shopping_cart),
              ),
            ),
          ],
        ),
        drawer: const MyDrawer(),
        body: ListView(children: [
          Container(
            padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 40),
            margin: const EdgeInsets.only(top: 40, left: 20, right: 20),
            decoration: BoxDecoration(
                gradient: LinearGradient(colors: [
                  const Color(0xff9DCEFF).withOpacity(0.7),
                  const Color(0xff92A3FD).withOpacity(0.7)
                ]),
                borderRadius: BorderRadius.circular(20)),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "Get -20% Promo",
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.w900),
                    ),
                    const SizedBox(
                      height: 25,
                    ),
                    MyButton(text: "Redeem", onTap: () {})
                  ],
                ),
                const Img(
                  "assets/images/dogfood.png",
                  height: 150,
                  width: 150,
                )
              ],
            ),
          ),
          Container(
            margin: const EdgeInsets.only(top: 40, left: 20, right: 20),
            child: MyTextField(
                hintText: "Search...",
                obscureText: false,
                controller: searchController,
                icon: const Icon(Icons.search)),
          ),
          const SizedBox(
            height: 40,
          ),
          Categories(),
          const SizedBox(
            height: 40,
          ),
          RecommendSection(),
          const SizedBox(
            height: 40,
          ),
        ]));
  }
}
