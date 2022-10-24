import '../model/cart_item.dart';
import '../model/product.dart';
import '../model/shop.dart';
import '../model/shoppipng_cart.dart';

abstract class Repository {
  /// Get a stream with Shop snapshots for a specific shop with given ID
  Stream<Shop?> getShopStream(String shopId);

  /// Get a stream with Product snapshots for a specific product with given ID
  Stream<Product?> getProductStream(String productId);

  /// Get a stream with ShoppingCart snapshots for a specific cart with given ID
  Stream<ShoppingCart?> getShoppingCartStream(String cartId);

  /// Get a stream with all items for a shopping cart with given ID
  Stream<Iterable<CartItem>> getCartItemStream(String cartId);
}
