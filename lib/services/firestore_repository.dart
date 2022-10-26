import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:exercise_e8/model/shop.dart';

import 'repository.dart';

/// Provides access to the Cloud Firestore database
class FirestoreRepository implements Repository {
  /// Singleton instance of the repository
  static final instance = FirestoreRepository();

  /// Retrieve one shop with specific Id
  @override
  Stream<Shop?> getShop(int shopId) {
    final DocumentReference<Map<String, dynamic>> documentReference =
        FirebaseFirestore.instance.doc("/shops/$shopId");
    final Stream<DocumentSnapshot<Map<String, dynamic>>> snapshotStream =
        documentReference.snapshots();
    final Stream<Map<String, dynamic>?> documentStream =
        snapshotStream.map((DocumentSnapshot<Map<String, dynamic>?> snapshot) {
      return snapshot.data();
    });
    final Stream<Shop?> shopStream = documentStream.map((document) {
      return document != null
          ? Shop(name: document["name"], address: document["address"])
          : null;
    });

    return shopStream;
  }
}
