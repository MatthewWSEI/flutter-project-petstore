import 'package:flutter/material.dart';
import 'package:flutter_img/flutter_img.dart';
import 'package:flutter_project_store/database/firebase.dart';

class Categories extends StatelessWidget {
  Categories({super.key});

  final FirebaseDatabase database = FirebaseDatabase();

  // List<CategoryModel> categories = [];

  // void _getInitialInfo() {
  //   categories = CategoryModel.getCategories();
  // }

  @override
  Widget build(BuildContext context) {
    // _getInitialInfo();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.only(left: 20),
          child: Text(
            'Category',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
          ),
        ),
        const SizedBox(
          height: 15,
        ),
        StreamBuilder(
            stream: database.getCategoriesStream(),
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

              final categories = snapshot.data!.docs;
              return SizedBox(
                height: 140,
                child: ListView.separated(
                  itemCount: categories.length,
                  scrollDirection: Axis.horizontal,
                  padding: const EdgeInsets.only(left: 20, right: 20),
                  separatorBuilder: (context, index) => const SizedBox(
                    width: 20,
                  ),
                  itemBuilder: (context, index) {
                    final category = categories[index];
                    String name = category["name"];
                    String iconName = category["iconName"];
                    return Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 20),
                      width: 100,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(16),
                          gradient: LinearGradient(colors: [
                            const Color(0xff9DCEFF).withOpacity(0.7),
                            const Color(0xff92A3FD).withOpacity(0.7)
                          ])),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Container(
                            width: 50,
                            height: 50,
                            decoration: const BoxDecoration(
                                color: Colors.white, shape: BoxShape.circle),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Img(
                                "assets/images/$iconName.png",
                                fit: BoxFit.fill,
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Text(
                            name,
                            style: const TextStyle(
                                fontWeight: FontWeight.w400, fontSize: 14),
                            textAlign: TextAlign.center,
                          ),
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
