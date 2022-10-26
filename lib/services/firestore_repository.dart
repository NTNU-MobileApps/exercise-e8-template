import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:exercise_e8/model/shop.dart';

import '../model/product.dart';
import 'api_paths.dart';

/// Provides access to the Cloud Firestore database
class FirestoreRepository {
  /// Singleton instance of the repository
  static final instance = FirestoreRepository();

  /// Retrieve one shop with specific Id
  Stream<Shop?> getShop(int shopId) =>
      _getDocumentStream(ApiPaths.shop(shopId), Shop.fromMap);

  /// Retrieve one product with specific Id
  Stream<Product?> getProduct(int id) =>
      _getDocumentStream(ApiPaths.product(id), Product.fromMap);

  /// A Generic method for getting a document stream and converting the
  /// documents to usable objects
  Stream<T?> _getDocumentStream<T>(
      String path, T Function(Map<String, dynamic>) converter) {
    final DocumentReference<Map<String, dynamic>> documentReference =
        FirebaseFirestore.instance.doc(path);
    final Stream<DocumentSnapshot<Map<String, dynamic>>> snapshotStream =
        documentReference.snapshots();
    final Stream<Map<String, dynamic>?> documentStream =
        snapshotStream.map((DocumentSnapshot<Map<String, dynamic>?> snapshot) {
      return snapshot.data();
    });
    final Stream<T?> objectStream = documentStream.map((document) {
      return document != null ? converter(document) : null;
    });
    return objectStream;
  }
}