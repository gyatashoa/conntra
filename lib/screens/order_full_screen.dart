import 'package:contra/model/order.dart';
import 'package:flutter/material.dart';

class OrderFullScreen extends StatelessWidget {
  const OrderFullScreen({super.key, required this.order});
  final Order order;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          Center(
              child: Text(
            'TOTAL: GHS${order.price}',
            style: TextStyle(fontSize: 20),
          ))
        ],
      ),
      body: SingleChildScrollView(
          child: Column(
        children: [
          ...order.cart.map((e) => ListTile(
                leading: CircleAvatar(
                  backgroundImage: NetworkImage(e.product.image ?? ''),
                ),
                title: Text(
                  e.product.name,
                ),
                subtitle: Text('Units: ${e.count}'),
                trailing: Text('GHS ${e.product.price}'),
              )),
          const SizedBox(
            height: 10,
          ),
          Text('Destination: ${order.location}')
        ],
      )),
    );
  }
}
