import 'package:flutter/material.dart';
import 'package:flutter_project_store/components/product_tile.dart';
import 'package:flutter_project_store/database/firebase.dart';
import 'package:flutter_project_store/helper/helper_function.dart';
import 'package:flutter_project_store/pages/product_page/product_page.dart';

class RecommendProducts extends StatelessWidget {
  RecommendProducts({super.key});

  final FirebaseDatabase database = FirebaseDatabase();

  @override
  Widget build(BuildContext context) {
    void navigateToCategories(String index) {
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: ((context) =>
                  ProductPage(productId: index.toString()))));
    }

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
                    int price = product['price'];
                    return ProductTile(
                      name: name,
                      price: price,
                      onTap: () {
                        navigateToCategories(product.id.toString());
                        // print(index);
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
