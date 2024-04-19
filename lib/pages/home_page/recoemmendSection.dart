import 'package:flutter/material.dart';
import 'package:flutter_img/flutter_img.dart';
import 'package:flutter_project_store/database/firebase.dart';
import 'package:flutter_project_store/helper/helper_function.dart';

class RecommendSection extends StatelessWidget {
  RecommendSection({super.key});

  final FirebaseDatabase database = FirebaseDatabase();

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
                // dispalyMessageToUser("Something went wrong", context);
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
                    return Container(
                      padding:
                          EdgeInsets.symmetric(vertical: 20, horizontal: 40),
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
                          // Container(
                          //   height: 45,
                          //   width: 130,
                          //   decoration: BoxDecoration(
                          //       gradient: LinearGradient(colors: [
                          //         diets[index].viewIsSelected
                          //             ? const Color(0xff9DCEFF)
                          //             : Colors.transparent,
                          //         diets[index].viewIsSelected
                          //             ? const Color(0xff92A3FD)
                          //             : Colors.transparent
                          //       ]),
                          //       borderRadius: BorderRadius.circular(50)),
                          //   child: Center(
                          //     child: Text(
                          //       'View',
                          //       style: TextStyle(
                          //           color: diets[index].viewIsSelected
                          //               ? Colors.white
                          //               : const Color(0xffC58BF2),
                          //           fontWeight: FontWeight.w600,
                          //           fontSize: 14),
                          //     ),
                          //   ),
                          // )
                        ],
                      ),
                    );
                  },
                ),
              );
            })
      ],
    );
  }
}
