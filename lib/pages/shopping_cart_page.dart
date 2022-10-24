import 'package:exercise_e8/services/repository.dart';
import 'package:provider/provider.dart';

import '../model/cart_item.dart';
import 'package:flutter/material.dart';

import '../model/shoppipng_cart.dart';
import '../widgets/cart_item_card.dart';

/// Represents the "Shopping cart" page
class ShoppingCartPage extends StatelessWidget {
  const ShoppingCartPage({Key? key}) : super(key: key);
  static const emptyCartMessage = "The cart is empty";
  static const cartId = "user_42";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Shopping cart"),
      ),
      body: Padding(
        padding: const EdgeInsets.only(top: 16),
        child: _buildContent(context),
      ),
    );
  }

  /// Build the content for the shopping cart page
  Widget _buildContent(BuildContext context) {
    final List<Widget> columnItems = [];
    columnItems.addAll(_buildCartItems());
    columnItems.add(_buildTotalPriceStream(context));
    return Column(children: columnItems);
  }

  /// Build the cards displaying cart items
  Iterable<CartItemCard> _buildCartItems() {
    // TODO - the real items must be loaded from Cloud Firestore
    final shoppingCartItems = [
      CartItem("Sweater", 666, 2, "http://129.241.152.12/sweater.jpg"),
      CartItem("Boots", 700, 1, "http://129.241.152.12/boots.jpg"),
    ];
    return shoppingCartItems.map((item) => CartItemCard(item));
  }

  /// Build a StreamBuilder for the shopping cart totals
  Widget _buildTotalPriceStream(BuildContext context) {
    final repository = Provider.of<Repository>(context, listen: false);
    return StreamBuilder<ShoppingCart?>(
      stream: repository.getShoppingCartStream(cartId),
      builder: (context, snapshot) {
        if (snapshot.connectionState != ConnectionState.active ||
            !snapshot.hasData) {
          return const Text("Loading...");
        }
        return _buildTotalPrice(snapshot.data!);
      },
    );
  }

  /// Build total price for the cart
  Widget _buildTotalPrice(ShoppingCart cart) {
    return Padding(
      padding: const EdgeInsets.only(top: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          const Text("Total:", style: TextStyle(fontSize: 24)),
          const SizedBox(width: 4),
          Text(
            "${cart.totalPrice} Kr",
            style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          const SizedBox(width: 32)
        ],
      ),
    );
  }
}
