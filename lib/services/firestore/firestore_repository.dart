import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import '../../model/cart_item.dart';
import '../../model/shoppipng_cart.dart';
import '../../model/product.dart';
import '../../model/shop.dart';
import '../../services/repository.dart';

import 'api_paths.dart';

class FirestoreRepository implements Repository {
  final FirebaseFirestore store = FirebaseFirestore.instance;

  @override
  Stream<Shop?> getShopStream(String shopId) =>
      _getDocumentStream<Shop>(ApiPaths.shop(shopId), Shop.fromMap);

  @override
  Stream<Product?> getProductStream(String productId) =>
      _getDocumentStream<Product>(ApiPaths.product(productId), Product.fromMap);

  @override
  Stream<ShoppingCart?> getShoppingCartStream(String cartId) =>
      _getDocumentStream(ApiPaths.cart(cartId), ShoppingCart.fromMap);

  @override
  Stream<Iterable<CartItem>> getCartItemStream(String cartId) =>
      _getCollectionStream(ApiPaths.cartItems(cartId), CartItem.fromMap);

  /// Get a stream for a document stored at a specific path.
  /// Automatically convert each snapshot to an object of corresponding type
  /// Use the provided [converter] function for the conversion
  Stream<T?> _getDocumentStream<T>(
      String path, T Function(Map<String, dynamic>) converter) {
    print("Get document at $path");
    // Get snapshot stream first
    final Stream<DocumentSnapshot<Map<String, dynamic>>> snapshots =
        store.doc(path).snapshots();

    // Then we need to convert it to Stream<T?> - take every snapshot and
    // convert it to a T object. This effectively creates a new Stream
    // where for each item on the "old stream" the conversion function is
    // called and the result of that function is "sent" to the new stream.
    return snapshots.map((documentSnapshot) {
      final Map<String, dynamic>? document = documentSnapshot.data();
      return document != null ? converter(document) : null;
    });
  }

  /// Get a stream for a collection stored at a specific path.
  /// Automatically convert each item in the collection to an object of
  /// corresponding type using the provided [converter] function
  Stream<Iterable<T>> _getCollectionStream<T>(
      String path, T Function(Map<String, dynamic>) converter) {
    print("Get collection items at $path");
    // Get snapshot stream first
    final Stream<QuerySnapshot<Map<String, dynamic>>> snapshots =
        store.collection(path).snapshots();

    // Then we traverse all the documents (as QueryDocumentSnapshot)
    // For each document, we extract the key-value pairs as Map<String, dynamic>
    // Then we convert eah Map to the desired object of type T,
    // return Iterable<T> in the end
    return snapshots.map((collectionSnapshot) {
      // Let's write out all the types explicitly, just for learning - so that
      // we see type of the variable at each step
      final List<QueryDocumentSnapshot<Map<String, dynamic>>> documents =
          collectionSnapshot.docs;
      return documents
          .map((QueryDocumentSnapshot<Map<String, dynamic>> document) {
        final Map<String, dynamic> data = document.data();
        return converter(data);
      });
    });
  }
}
