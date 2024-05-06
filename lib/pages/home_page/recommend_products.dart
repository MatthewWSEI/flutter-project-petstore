import 'package:flutter/material.dart';
import 'package:flutter_project_store/components/product_tile.dart';
import 'package:flutter_project_store/database/firebase.dart';
import 'package:flutter_project_store/helper/helper_function.dart';
import 'package:flutter_project_store/model/product.dart';
import 'package:flutter_project_store/pages/product_page/product_page.dart';

class RecommendProducts extends StatefulWidget {
  RecommendProducts({super.key});

  @override
  State<RecommendProducts> createState() => _RecommendProductsState();
}

class _RecommendProductsState extends State<RecommendProducts> {
  final FirebaseDatabase database = FirebaseDatabase();
  void navigateToCategories(String id, Product item) {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: ((context) =>
                ProductPage(productId: id.toString(), product: item))));
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.only(left: 20),
          child: Text(
            'Recommendation\nfor You',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
          ),
        ),
        const SizedBox(
          height: 15,
        ),
        StreamBuilder(
            stream: database.getProductsStream(),
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
              return SizedBox(
                height: 270,
                child: ListView.separated(
                  separatorBuilder: (context, index) => const SizedBox(
                    width: 25,
                  ),
                  itemCount: 3,
                  scrollDirection: Axis.horizontal,
                  padding: const EdgeInsets.only(left: 20, right: 20),
                  itemBuilder: (context, index) {
                    final product = products[index];
                    String name = product['name'];
                    String categoryId = product['categoryId'];
                    int count = product['count'];
                    int price = product['price'];
                    String productId = product.id.toString();
                    return ProductTile(
                      name: name,
                      price: price,
                      onTap: () {
                        final productCreate = Product(
                          id: productId,
                          categoryId: categoryId,
                          count: count,
                          name: name,
                          price: price,
                        );
                        navigateToCategories(productId, productCreate);
                        // print(product.data());
                        // print(product.id);
                      },
                    );
                  },
                ),
              );
            })
      ],
    );
  }
}
