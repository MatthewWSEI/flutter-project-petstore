import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_img/flutter_img.dart';
import 'package:flutter_project_store/helper/helper_function.dart';

class ProductPage extends StatefulWidget {
  final String productId;
  const ProductPage({super.key, required this.productId});

  @override
  State<ProductPage> createState() => _ProductPageState();
}

class _ProductPageState extends State<ProductPage> {
  int quantityCount = 0;

  @override
  Widget build(BuildContext context) {
    Future<DocumentSnapshot<Map<String, dynamic>>> getProductDetails(
        String id) async {
      return await FirebaseFirestore.instance
          .collection("products")
          .doc(id)
          .get();
    }

    void decrementQuantity() {
      if (quantityCount > 0) {
        setState(() {
          quantityCount--;
        });
      }
    }

    void icrementQuantity() {
      setState(() {
        quantityCount++;
      });
    }

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: FutureBuilder<DocumentSnapshot<Map<String, dynamic>>>(
        future: getProductDetails(widget.productId),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapshot.hasError) {
            return Text("Error: ${snapshot.error}");
          } else if (snapshot.hasData) {
            Map<String, dynamic>? product = snapshot.data!.data();
            return Container(
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
              // width: auto,
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
                        product!["name"],
                        style: const TextStyle(
                          fontWeight: FontWeight.w900,
                          fontSize: 20,
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            formatPrice(product["price"]),
                            style: const TextStyle(
                                // color: Color(0xff7B6F72),
                                fontSize: 16,
                                fontWeight: FontWeight.w400),
                          ),
                          Row(
                            children: [
                              Container(
                                decoration: BoxDecoration(
                                    color: Theme.of(context)
                                        .colorScheme
                                        .inversePrimary
                                        .withOpacity(0.3),
                                    shape: BoxShape.circle),
                                child: IconButton(
                                  icon: Icon(
                                    Icons.remove,
                                  ),
                                  onPressed: decrementQuantity,
                                ),
                              ),
                              SizedBox(
                                width: 20,
                                child: Center(
                                  child: Text(
                                    quantityCount.toString(),
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16),
                                  ),
                                ),
                              ),
                              Container(
                                decoration: BoxDecoration(
                                    color: Theme.of(context)
                                        .colorScheme
                                        .inversePrimary
                                        .withOpacity(0.3),
                                    shape: BoxShape.circle),
                                child: IconButton(
                                  icon: Icon(
                                    Icons.add,
                                  ),
                                  onPressed: icrementQuantity,
                                ),
                              )
                            ],
                          )
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            );
          } else {
            return const Text("No data");
          }
        },
      ),
    );
  }
}
