import 'package:contra/model/cart.dart';
import 'package:contra/model/product.dart';
import 'package:flutter/foundation.dart';

class CartProvider extends ChangeNotifier {
  late List<Cart> _products;

  CartProvider() {
    _products = [];
  }

  List<Cart> get products => _products;

  bool addProduct(Product product) {
    if (_exist(product)) return true;
    _products.add(Cart(count: 1, product: product));
    notifyListeners();
    return false;
  }

  void removeCart(Cart cart) {
    _products.removeWhere((element) => element.product.equals(cart.product));
    notifyListeners();
  }

  double get computePrice => _products.fold(
      0,
      (previousValue, element) =>
          previousValue + ((element.product.price ?? 0) * element.count));

  void reduceProductCount(Cart cart) {
    if (_products
            .where((element) => element.product.equals(cart.product))
            .first
            .count ==
        1) return;
    _products
        .where((element) => element.product.equals(cart.product))
        .first
        .count--;
    notifyListeners();
  }

  void clear() {
    _products = [];
    notifyListeners();
  }

  void increaseProductCount(Cart cart) {
    _products
        .where((element) => element.product.equals(cart.product))
        .first
        .count++;
    notifyListeners();
  }

  bool _exist(Product product) =>
      _products.any((element) => element.product.equals(product));
}
