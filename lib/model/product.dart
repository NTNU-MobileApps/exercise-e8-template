/// Represents a product
class Product {
  final String name;
  final num price;
  final String imageUrl;

  Product(this.name, this.price, this.imageUrl);

  /// Create a product from a map (JSON)
  static Product fromMap(Map<String, dynamic> data) {
    assert(data.containsKey("name"), "Missing name property for a product");
    assert(data.containsKey("price"), "Missing price property for a product");
    assert(data.containsKey("imageUrl"),
        "Missing imageUrl property for a product");
    return Product(data["name"], data["price"], data["imageUrl"]);
  }
}
