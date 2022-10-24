import 'package:provider/provider.dart';

import 'package:flutter/material.dart';

import '../model/cart_item.dart';
import '../model/shoppipng_cart.dart';
import '../services/repository.dart';
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
    return Column(children: [
      _buildCartItems(context),
      _buildTotalPriceStream(context),
    ]);
  }

  /// Build the cards displaying cart items
  Widget _buildCartItems(BuildContext context) {
    final repository = Provider.of<Repository>(context, listen: false);
    return StreamBuilder<Iterable<CartItem>?>(
      stream: repository.getCartItemStream(cartId),
      builder: (context, snapshot) {
        // If there is no data yet, show a temporary message
        if (snapshot.connectionState != ConnectionState.active ||
            !snapshot.hasData ||
            snapshot.data == null) {
          return const Text("Loading cart items...");
        }
        // Let's get all the CartItems from the database
        final Iterable<CartItem> items = snapshot.data!;
        // And then create a CartItemCard widget for each item
        final List<CartItemCard> itemCards =
            items.map((item) => CartItemCard(item)).toList();

        return Column(children: itemCards);
      },
    );
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
