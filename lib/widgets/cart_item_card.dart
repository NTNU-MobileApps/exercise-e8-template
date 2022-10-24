import 'package:flutter/material.dart';

import '../model/cart_item.dart';

/// Creates a Card displaying a single shopping-cart item
class CartItemCard extends StatelessWidget {
  final CartItem item;

  const CartItemCard(this.item, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              item.imageUrl != null
                  ? Image.network(item.imageUrl!, height: 30)
                  : const Text("No image"),
              const SizedBox(width: 16),
              Text(
                "${item.quantity}x ${item.name} (${item.price} Kr)",
                style: const TextStyle(fontSize: 16),
              ),
              const SizedBox(width: 16),
              const IconButton(
                onPressed: null, // We don't need to delete in this exercise
                icon: Icon(Icons.delete),
              )
            ],
          ),
        ),
      ),
    );
  }
}
