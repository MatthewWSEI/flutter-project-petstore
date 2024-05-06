import 'package:flutter/material.dart';
import 'package:flutter_project_store/components/category_tile.dart';
import 'package:flutter_project_store/database/firebase.dart';
import 'package:flutter_project_store/helper/helper_function.dart';
import 'package:flutter_project_store/pages/categories_page/categories_page.dart';

class Categories extends StatefulWidget {
  Categories({super.key});

  @override
  State<Categories> createState() => _CategoriesState();
}

class _CategoriesState extends State<Categories> {
  final FirebaseDatabase database = FirebaseDatabase();

  void navigateToCategories(String index) {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: ((context) =>
                CategoriesPage(categoryId: index.toString()))));
  }

  @override
  Widget build(BuildContext context) {
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

              final categories = snapshot.data!.docs;
              return SizedBox(
                height: 150,
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
                    int newIndex = index + 1;
                    return CategoryTile(
                      name: name,
                      iconName: iconName,
                      onTap: () {
                        navigateToCategories(newIndex.toString());
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
