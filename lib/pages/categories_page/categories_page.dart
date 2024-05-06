import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_img/flutter_img.dart';
import 'package:flutter_project_store/components/product_tile.dart';
import 'package:flutter_project_store/database/firebase.dart';
import 'package:flutter_project_store/helper/helper_function.dart';
import 'package:flutter_project_store/model/product.dart';
import 'package:flutter_project_store/pages/product_page/product_page.dart';

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
  void navigateToCategories(String id, Product item) {
    // final shop = context.read<Shop>();
    // final product = shop.product;
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: ((context) =>
                ProductPage(productId: id.toString(), product: item))));
  }

  @override
  Widget build(BuildContext context) {
    // final shop = context.read<Shop>();
    // final product = shop.product;

    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              FutureBuilder<String>(
                future: getCategoryName(widget.categoryId.toString()),
                builder:
                    (BuildContext context, AsyncSnapshot<String> snapshot) {
                  if (snapshot.connectionState == ConnectionState.done) {
                    if (snapshot.hasError) {
                      return Text('Something went wrong: ${snapshot.error}');
                    }
                    return Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                          snapshot.data!,
                          style: const TextStyle(
                              fontSize: 20, fontWeight: FontWeight.w600),
                        ),
                      ],
                    );
                  } else {
                    return const CircularProgressIndicator();
                  }
                },
              ),
              const SizedBox(
                height: 15,
              ),
              StreamBuilder(
                  stream:
                      database.getProductStreambyCategoryId(widget.categoryId),
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

                    final products = snapshot.data!.docs;
                    return Wrap(
                      alignment: WrapAlignment.start,
                      runSpacing: 20,
                      children: products.map((product) {
                        String name = product['name'];
                        String categoryId = product['categoryId'];
                        int count = product['count'];
                        int price = product['price'];
                        String productId = product.id.toString();
                        return GestureDetector(
                            onTap: () {
                              final productCreate = Product(
                                id: productId,
                                categoryId: categoryId,
                                count: count,
                                name: name,
                                price: price,
                              );
                              navigateToCategories(productId, productCreate);
                            },
                            child: Container(
                              height: 150,
                              padding: const EdgeInsets.symmetric(
                                  vertical: 10, horizontal: 10),
                              decoration: BoxDecoration(
                                  gradient: LinearGradient(colors: [
                                    const Color(0xff9DCEFF).withOpacity(0.7),
                                    const Color(0xff92A3FD).withOpacity(0.7)
                                  ]),
                                  borderRadius: BorderRadius.circular(20)),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  const Img(
                                    "assets/images/product.png",
                                    width: 150,
                                    height: 150,
                                  ),
                                  const SizedBox(
                                    width: 25,
                                  ),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
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
                      }).toList(),
                    );
                  })
            ],
          ),
        ));
  }
}


// GridView.builder(
//                       gridDelegate:
//                           const SliverGridDelegateWithFixedCrossAxisCount(
//                         crossAxisCount: 3, // Liczba kolumn
//                         crossAxisSpacing: 10, // Przestrzeń między kolumnami
//                         mainAxisSpacing: 10, // Przestrzeń między wierszami
//                       ),
//                       itemCount: products.length,
//                       itemBuilder: (context, index) {
//                         final product = products[index];
//                         String name = product['name'];
//                         String categoryId = product['categoryId'];
//                         int count = product['count'];
//                         int price = product['price'];
//                         String productId = product.id.toString();

                        
//                         return ProductTile(
//                           name: name,
//                           price: price,
//                           onTap: () {
//                             final productCreate = Product(
//                               id: productId,
//                               categoryId: categoryId,
//                               count: count,
//                               name: name,
//                               price: price,
//                             );
//                             navigateToCategories(productId, productCreate);
//                           },
//                         );
//                       },
//                     ),