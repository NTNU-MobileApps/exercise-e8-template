import '../model/shop.dart';

/// Describes the operations provided by the database
/// For storing and loading data
abstract class Repository {
  /// Retrieve one shop with specific Id
  Stream<Shop?> getShop(int shopId);
}