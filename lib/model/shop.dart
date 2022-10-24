/// Represents information for a shop
class Shop {
  final String title;
  final String address;

  Shop(this.title, this.address);

  /// Create a shop from a map (JSON)
  static Shop fromMap(Map<String, dynamic> data) {
    assert(data.containsKey("name"), "Missing name property for a shop");
    assert(data.containsKey("address"), "Missing address property for a shop");
    return Shop(data["name"], data["address"]);
  }
}
