import 'package:flutter/material.dart';
import 'package:flutter_img/flutter_img.dart';
import 'package:flutter_project_store/components/button.dart';
import 'package:flutter_project_store/components/my_drawer.dart';
import 'package:flutter_project_store/components/my_textfield.dart';
import 'package:flutter_project_store/pages/home_page/categories.dart';
import 'package:flutter_project_store/pages/home_page/recommend_products.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
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
            margin: const EdgeInsets.symmetric(vertical: 0, horizontal: 20),
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
                          TextStyle(fontSize: 24, fontWeight: FontWeight.w900),
                    ),
                    const SizedBox(
                      height: 25,
                    ),
                    MyButton(text: "Redeem", onTap: () {})
                  ],
                ),
                const Img(
                  "assets/images/dogfood.png",
                  height: 200,
                  width: 200,
                )
              ],
            ),
          ),
          Container(
            margin: const EdgeInsets.symmetric(vertical: 40, horizontal: 20),
            child: MyTextField(
                hintText: "Search...",
                obscureText: false,
                controller: searchController,
                icon: const Icon(Icons.search)),
          ),
          Categories(),
          const SizedBox(
            height: 40,
          ),
          RecommendProducts(),
          const SizedBox(
            height: 20,
          ),
        ]));
  }
}
