import 'package:exercise_e8/model/shoppipng_cart.dart';

import '../model/product.dart';
import '../model/shop.dart';

abstract class Repository {
  /// Get a stream with Shop snapshots for a specific shop with given ID
  Stream<Shop?> getShopStream(String shopId);

  /// Get a stream with Product snapshots for a specific product with given ID
  Stream<Product?> getProductStream(String productId);

  /// Get a stream with ShoppingCart snapshots for a specific cart with given ID
  Stream<ShoppingCart?> getShoppingCartStream(String cartId);
}
