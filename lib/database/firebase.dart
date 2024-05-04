import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FirebaseDatabase {
  User? user = FirebaseAuth.instance.currentUser;

  final CollectionReference posts =
      FirebaseFirestore.instance.collection('Posts');

  // Future<void> addPost(String messsage) {
  //   return posts.add({
  //     'UserEmail': user!.email,
  //     "PostMessage": messsage,
  //     'TimeStamp': Timestamp.now(),
  //   });
  // }

  Stream<QuerySnapshot> getCategoriesStream() {
    final categoryStream =
        FirebaseFirestore.instance.collection('categories').snapshots();
    return categoryStream;
  }

  Stream<QuerySnapshot> getProductsStream() {
    final productStream =
        FirebaseFirestore.instance.collection('products').snapshots();
    return productStream;
  }

  Stream<QuerySnapshot> getProductStream(String categoryId) {
    final productStream = FirebaseFirestore.instance
        .collection('products')
        .where('categoryId', isEqualTo: categoryId)
        .snapshots();
    return productStream;
  }
}
