/// Represents info about the whole shopping cart, not including the items
class ShoppingCart {
  final num totalPrice;

  static ShoppingCart fromMap(Map<String, dynamic> data) {
    assert(data.containsKey("totalPrice"),
        "Missing totalPrice property for a shopping cart");
    return ShoppingCart(data["totalPrice"]);
  }

  ShoppingCart(this.totalPrice);
}
