import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:exercise_e8/model/shop.dart';
import 'package:exercise_e8/services/repository.dart';

import 'api_paths.dart';

class FirestoreRepository implements Repository {
  final FirebaseFirestore store = FirebaseFirestore.instance;

  @override
  Stream<Shop?> getShopStream(String shopId) {
    // Get snapshot stream first
    final Stream<DocumentSnapshot<Map<String, dynamic>>> snapshots =
        store.doc(ApiPaths.shop(shopId)).snapshots();

    // Then we need to convert it to Shop-stream - take every snapshot and
    // convert it to a Shop object. This effectively creates a new Stream
    // where for each item on the "old stream" the conversion function is
    // called and the result of that function is "sent" to the new stream.
    return snapshots.map(_convertSnapshotToShop);
  }

  Shop? _convertSnapshotToShop(
      DocumentSnapshot<Map<String, dynamic>> snapshot) {
    final Map<String, dynamic>? data = snapshot.data();
    if (data != null && data.containsKey("name")) {
      return Shop(data["name"]);
    } else {
      return null;
    }
  }
}
