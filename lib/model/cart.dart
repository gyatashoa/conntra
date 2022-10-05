import 'package:contra/model/product.dart';

class Cart {
  int count;
  final Product product;

  Cart({required this.count, required this.product});

  Cart.fromJson(Map<String, dynamic> data)
      : count = data['count'],
        product = Product.fromJson(data['product']);

  Map<String, dynamic> toJson() => {'count': count, 'product': product.toJson};
}
