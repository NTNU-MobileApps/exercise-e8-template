/// Collection of all the allowed API paths we use in our Cloud Firestore database
class ApiPaths {
  /// Get path to one specific shop
  static String shop(int shopId) => "shops/$shopId";

  /// Get path to one specific product
  static String product(int productId) => "products/$productId";
}
