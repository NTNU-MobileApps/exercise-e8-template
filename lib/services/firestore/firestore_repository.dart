import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
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

  /// Get a stream for a document stored at a specific path.
  /// Automatically convert each snapshot to an object of corresponding type
  /// Use the provided [converter] function for the conversion
  Stream<T?> _getDocumentStream<T>(
      String path, T Function(Map<String, dynamic>) converter) {
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
}
