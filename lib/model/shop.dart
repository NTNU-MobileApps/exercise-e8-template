/// Represents a shop
class Shop {
  final String name;
  final String address;

  Shop({required this.name, required this.address});

  /// Construct a Shop object from a (JSON) map
  static Shop fromMap(Map<String, dynamic> document) {
    return Shop(
      name: document["name"],
      address: document["address"],
    );
  }
}
