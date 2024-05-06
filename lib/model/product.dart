class Product {
  final String id;
  final String categoryId;
  final int count;
  final String name;
  final int price;

  Product({
    required this.name,
    required this.price,
    required this.id,
    required this.categoryId,
    required this.count,
  });

  factory Product.fromMap(Map<String, dynamic> map) {
    return Product(
      id: map['id'],
      categoryId: map['categoryId'],
      count: map['count'],
      name: map['name'],
      price: map['price'],
    );
  }
}
