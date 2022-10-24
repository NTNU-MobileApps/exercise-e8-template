/// Collects all the possible paths used in the API for Cloud Firestore
class ApiPaths {
  /// Get document for a shop with given id
  static String shop(String shopId) => "shops/$shopId";

  /// Get document for a product with given id
  static String product(String productId) => "products/$productId";
}