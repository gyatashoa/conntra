import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:contra/model/cart.dart';
import 'package:contra/model/product.dart';

class Order {
  final String id;
  final List<Cart> cart;
  final double price;
  final String email;
  final String location;
  final DateTime createdAt;

  Order(
      {required this.id,
      required this.createdAt,
      required this.cart,
      required this.price,
      required this.email,
      required this.location});

  Order.fromJson(Map<String, dynamic> data)
      : id = data['id'],
        price = data['price'],
        email = data['email'],
        location = data['location'],
        createdAt = data['createdAt'] == null
            ? DateTime.now()
            : (data['createdAt']).toDate(),
        cart = (data['cart'] as List).map((e) => Cart.fromJson(e)).toList();

  Map<String, dynamic> toJson() => {
        'price': price,
        'location': location,
        'email': email,
        'createdAt': FieldValue.serverTimestamp(),
        'cart': cart.map((e) => e.toJson()).toList()
      };
}
