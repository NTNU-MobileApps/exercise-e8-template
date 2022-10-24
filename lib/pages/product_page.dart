import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../model/product.dart';
import '../model/shop.dart';
import '../services/repository.dart';
import 'shopping_cart_page.dart';

/// Represents the product page
class ProductPage extends StatelessWidget {
  static const String defaultShopName = "1";
  static const String productId = "14";

  const ProductPage({Key? key}) : super(key: key);
  static const addToCartKey = Key("add_to_cart_button");
  static const openCartKey = Key("open_cart_button");

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: _buildShopTitle(context),
        actions: [_buildShoppingCartButton(context)],
      ),
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[_buildProductInfo(context), _buildButton()],
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

  Widget _buildProductInfo(BuildContext context) {
    final repository = Provider.of<Repository>(context, listen: false);
    return StreamBuilder<Product?>(
        stream: repository.getProductStream(productId),
        builder: (context, snapshot) {
          // Check if we got something other than real data...
          if (snapshot.connectionState != ConnectionState.active) {
            return const Text("Loading...");
          } else if (snapshot.hasError) {
            return Text("Error: ${snapshot.error}");
          } else if (!snapshot.hasData || snapshot.data == null) {
            return const Text("Loading...");
          }

          // If we get so far, this means we got data!
          final Product product = snapshot.data!;

          return Column(
            children: [
              _buildProductTitle(product.name),
              _buildProductImage(product.imageUrl),
              _buildPriceText(product.price),
            ],
          );
        });
  }

  /// Build the title for the product
  Widget _buildProductTitle(String productName) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Text(
        productName,
        style: const TextStyle(fontSize: 24),
      ),
    );
  }

  /// Build the price text for the product
  Widget _buildPriceText(num price) {
    return Padding(
      padding: const EdgeInsets.only(top: 8, bottom: 8),
      child: Text(
        "$price Kr",
        style: const TextStyle(fontSize: 16),
      ),
    );
  }

  /// Build the product image
  Widget _buildProductImage(String imageUrl) {
    return Image.network(imageUrl, height: 200);
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

  /// Build widget for displaying shop title
  Widget _buildShopTitle(BuildContext context) {
    final repository = Provider.of<Repository>(context, listen: false);
    return StreamBuilder<Shop?>(
      stream: repository.getShopStream(defaultShopName),
      builder: (BuildContext context, AsyncSnapshot<Shop?> snapshot) {
        if (snapshot.connectionState != ConnectionState.active) {
          return const Text("Loading...");
        } else if (snapshot.hasError) {
          return Text("Error: ${snapshot.error}");
        } else if (!snapshot.hasData || snapshot.data == null) {
          return const Text("Loading...");
        }
        final Shop shop = snapshot.data!;
        return Text(shop.title);
      },
    );
  }
}
