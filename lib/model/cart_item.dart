/// An immutable shopping cart item
class CartItem {
  /// Used to generate unique IDs for the items
  static int _itemCounter = 1;

  final int id;
  final String name;
  final double price;
  final int quantity;
  final String? imageUrl;

  /// Create a shopping cart item
  /// name: the name of the product
  /// price: Price of one unit
  /// count: how many units of the product are included in this cart-item
  CartItem(this.name, this.price, this.quantity, [this.imageUrl])
      : id = _itemCounter++;

  /// Returns true if the item contains valid values
  bool isValid() => price > 0 && quantity > 0;

  @override
  String toString() {
    return 'CartItem{${quantity}x${price}Kr $name, id: $id}';
  }
}
