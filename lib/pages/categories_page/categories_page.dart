import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_project_store/components/product_tile.dart';
import 'package:flutter_project_store/database/firebase.dart';
import 'package:flutter_project_store/helper/helper_function.dart';
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
  @override
  Widget build(BuildContext context) {
    void navigateToCategories(String index) {
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: ((context) =>
                  ProductPage(productId: index.toString()))));
    }

    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
        ),
        body: Column(
          children: [
            FutureBuilder<String>(
              future: getCategoryName(widget.categoryId.toString()),
              builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
                if (snapshot.connectionState == ConnectionState.done) {
                  if (snapshot.hasError) {
                    return Text('Something went wrong: ${snapshot.error}');
                  }
                  return Text(
                    snapshot.data!,
                    style: const TextStyle(
                        fontSize: 20, fontWeight: FontWeight.w600),
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
                  return Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 10, vertical: 20),
                    child: Wrap(
                      spacing: 20,
                      runSpacing: 20,
                      children: products.map((product) {
                        String name = product['name'];
                        int price = product['price'];
                        String productId = product.id.toString();
                        return ProductTile(
                          name: name,
                          price: price,
                          onTap: () {
                            navigateToCategories(productId);
                          },
                        );
                      }).toList(),
                    ),
                  );
                })
          ],
        ));
  }
}
