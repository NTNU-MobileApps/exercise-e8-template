/// Represents one product
class Product {
  final String name;
  final num price;
  final String imageUrl;

  Product({
    required this.name,
    required this.price,
    required this.imageUrl,
  });

  static Product fromMap(Map<String, dynamic> document) {
    return Product(
      name: document["name"],
      price: document["price"],
      imageUrl: document["imageUrl"],
    );
  }

  @override
  String toString() {
    return 'Product{name: $name, price: $price, imageUrl: $imageUrl}';
  }
}
