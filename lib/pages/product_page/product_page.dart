import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_img/flutter_img.dart';
import 'package:flutter_project_store/components/button.dart';
import 'package:flutter_project_store/helper/helper_function.dart';

class ProductPage extends StatefulWidget {
  final String productId;
  final dynamic product;
  const ProductPage(
      {super.key, required this.productId, required this.product});

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

    void addToCart(Object object) {
      // if (quantityCount > 0) {
      //   final shop = context.read()<Shop>();

      //   shop.addToCart(widget.productId, quantityCount);

      //   showDialog(
      //       context: context,
      //       builder: (context) => AlertDialog(
      //             content: Text("Successfully added to cart"),
      //             actions: [
      //               IconButton(onPressed: () {}, icon: Icon(Icons.done))
      //             ],
      //           ));
      // }

      print(widget.product.id);
    }

    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
        ),
        body: Container(
          // width: auto,
          decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.primary.withOpacity(0.7),
              borderRadius: BorderRadius.circular(20)),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Img(
                      "assets/images/product.png",
                      width: 200,
                      height: 200,
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Text(
                      widget.product.name,
                      style: const TextStyle(
                        fontWeight: FontWeight.w900,
                        fontSize: 24,
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    const Text(
                      'Description',
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 16,
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    const Text(
                      'Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry s standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.',
                      style: TextStyle(
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                padding:
                    const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
                decoration: BoxDecoration(
                  gradient: LinearGradient(colors: [
                    const Color(0xff9DCEFF).withOpacity(0.7),
                    const Color(0xff92A3FD).withOpacity(0.7)
                  ]),
                ),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          formatPrice(widget.product.count),
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
                                icon: const Icon(
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
                                  style: const TextStyle(
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
                                icon: const Icon(
                                  Icons.add,
                                ),
                                onPressed: icrementQuantity,
                              ),
                            )
                          ],
                        )
                      ],
                    ),
                    const SizedBox(
                      height: 25,
                    ),
                    MyButton(
                        text: 'Add Cart',
                        onTap: () {
                          // addToCart(product);
                        })
                  ],
                ),
              ),
            ],
          ),
        ));
  }
}
