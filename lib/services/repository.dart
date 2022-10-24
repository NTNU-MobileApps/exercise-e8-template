import '../model/shop.dart';

abstract class Repository {
  Stream<Shop?> getShopStream(String shopId);
}