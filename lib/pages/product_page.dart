import 'package:flutter/material.dart';

import 'shopping_cart_page.dart';

/// Represents the product page
class ProductPage extends StatelessWidget {
  const ProductPage({Key? key}) : super(key: key);
  static const addToCartKey = Key("add_to_cart_button");
  static const openCartKey = Key("open_cart_button");

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // TODO - load the shop name from Cloud Firestore
        title: const Text("M&H Molde"),
        actions: [_buildShoppingCartButton(context)],
      ),
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            _buildProductTitle(),
            _buildImage(),
            _buildPriceText(),
            _buildButton()
          ],
        ),
      ),
    );
  }

  /// Build the action-button to be shown in the action bar.
  /// On click it takes to the shopping-cart page
  Widget _buildShoppingCartButton(BuildContext context) {
    return Row(
      children: [
        IconButton(
          key: openCartKey,
          onPressed: () => _showShoppingCartPage(context),
          icon: const Icon(Icons.shopping_cart),
        ),
      ],
    );
  }

  /// Build the title for the product
  Widget _buildProductTitle() {
    return const Padding(
      padding: EdgeInsets.only(bottom: 8),
      child: Text(
        // TODO - here we want to have product title from Cloud Firestore
        "A nice sweater",
        style: TextStyle(fontSize: 24),
      ),
    );
  }

  /// Build the price text for the product
  Widget _buildPriceText() {
    return const Padding(
      padding: EdgeInsets.only(top: 8, bottom: 8),
      child: Text(
        // TODO - here we want to have product price from Cloud Firestore
        "666 Kr",
        style: TextStyle(fontSize: 16),
      ),
    );
  }

  /// Build the product image
  Widget _buildImage() {
    // TODO - here we want to use image URL from Cloud Firestore
    return Image.network(
      "http://129.241.152.12/sweater.jpg",
      height: 200,
    );
  }

  /// Build the "Add to cart" button
  Widget _buildButton() {
    return const ElevatedButton(
      key: addToCartKey,
      onPressed: null, // We don't need any action in this exercise
      child: Padding(
        padding: EdgeInsets.all(8.0),
        child: Text("Add to cart"),
      ),
    );
  }

  /// Navigate to the shopping cart page
  void _showShoppingCartPage(BuildContext context) {
    Navigator.of(context).push(MaterialPageRoute(
      builder: (context) => const ShoppingCartPage(),
    ));
  }
}
