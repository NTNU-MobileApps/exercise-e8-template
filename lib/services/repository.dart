import '../model/product.dart';
import '../model/shop.dart';

abstract class Repository {
  Stream<Shop?> getShopStream(String shopId);
  Stream<Product?> getProductStream(String productId);
}