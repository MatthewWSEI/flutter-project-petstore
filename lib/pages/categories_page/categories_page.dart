import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_img/flutter_img.dart';
import 'package:flutter_project_store/database/firebase.dart';
import 'package:flutter_project_store/helper/helper_function.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class CategoriesPage extends StatefulWidget {
  final String categoryId;
  const CategoriesPage({super.key, required this.categoryId});

  @override
  State<CategoriesPage> createState() => _CategoriesPageState();
}

final FirebaseDatabase database = FirebaseDatabase();

Future<String> getCategoryName(String categoryId) async {
  DocumentSnapshot category = await FirebaseFirestore.instance
      .collection('categories')
      .doc(categoryId)
      .get();
  String categoryName;
  if (category.exists) {
    Map<String, dynamic> data = category.data() as Map<String, dynamic>;
    categoryName = data['name'];
  } else {
    categoryName = 'No such category!';
  }
  return categoryName;
}

class _CategoriesPageState extends State<CategoriesPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
        ),
        body: Column(
          children: [
            FutureBuilder<String>(
              future: getCategoryName(
                  widget.categoryId.toString()), // funkcja asynchroniczna
              builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
                // Sprawdzamy, czy dane są już dostępne
                if (snapshot.connectionState == ConnectionState.done) {
                  // Jeśli wystąpił błąd podczas pobierania danych, wyświetlamy błąd
                  if (snapshot.hasError) {
                    return Text('Wystąpił błąd: ${snapshot.error}');
                  }
                  // Jeśli dane są dostępne, wyświetlamy je w widżecie Text
                  return Text(
                    snapshot.data!,
                    style: const TextStyle(
                        fontSize: 20, fontWeight: FontWeight.w600),
                  );
                } else {
                  // Jeśli dane nie są jeszcze dostępne, wyświetlamy wskaźnik ładowania
                  return const CircularProgressIndicator();
                }
              },
            ),
            const SizedBox(
              height: 15,
            ),
            StreamBuilder(
                stream: database.getProductStream(widget.categoryId),
                builder: (context, snapshot) {
                  if (snapshot.hasError) {
                    dispalyMessageToUser("Something went wrong", context);
                  }
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                  if (snapshot.data == null) {
                    return const Text("No data");
                  }

                  final product = snapshot.data!.docs;
                  return Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 10, vertical: 20),
                    child: Wrap(
                      spacing: 20, // odstęp między elementami wiersza
                      runSpacing: 20,
                      children: product.map((product) {
                        String name = product['name'];
                        int price = product['price'];
                        return Container(
                          padding: const EdgeInsets.symmetric(
                              vertical: 20, horizontal: 40),
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
                        );
                      }).toList(),
                    ),
                  );
                })
          ],
        ));
  }
}
