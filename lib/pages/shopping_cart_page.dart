import '../model/cart_item.dart';
import 'package:flutter/material.dart';

import '../widgets/cart_item_card.dart';

/// Represents the "Shopping cart" page
class ShoppingCartPage extends StatelessWidget {
  const ShoppingCartPage({Key? key}) : super(key: key);
  static const emptyCartMessage = "The cart is empty";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Shopping cart"),
      ),
      body: Padding(
        padding: const EdgeInsets.only(top: 16),
        child: Column(
          children: [..._buildCartItems(), _buildTotalPriceRow()],
        ),
      ),
    );
  }

  /// Build a list of cards, displaying the items currently in the cart
  List<Widget> _buildCartItems() {
    // TODO - the real items must be loaded from Cloud Firestore
    final shoppingCartItems = [
      CartItem("Sweater", 666, 2, "http://129.241.152.12/sweater.jpg"),
      CartItem("Boots", 700, 1, "http://129.241.152.12/boots.jpg"),
    ];
    return shoppingCartItems.map((item) => CartItemCard(item)).toList();
  }

  Widget _buildTotalPriceRow() {
    return Padding(
      padding: const EdgeInsets.only(top: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: const [
          Text("Total:", style: TextStyle(fontSize: 24)),
          SizedBox(width: 4),
          Text(
            // TODO - load the total price from Cloud Firestore
            "2032 Kr",
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          SizedBox(width: 32)
        ],
      ),
    );
  }
}
