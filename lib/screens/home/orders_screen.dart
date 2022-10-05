import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:contra/model/cart.dart';
import 'package:contra/model/order.dart';
import 'package:contra/providers/user_provider.dart';
import 'package:contra/screens/order_full_screen.dart';
import 'package:contra/service/cloud_firestore_service.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:provider/provider.dart';
import 'package:timeago/timeago.dart' as ta;

class OrdersScreen extends StatelessWidget {
  const OrdersScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<UserProvider>(
      builder: (context, value, child) {
        return StreamBuilder<QuerySnapshot<Order>>(
            stream: GetIt.instance<CloudFirestoreService>()
                .getOrders(value.getUser?.email ?? ''),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
              if (snapshot.hasError) {
                return const Center(
                  child: Text('Error connecting to backend'),
                );
              }
              if (snapshot.hasData) {
                final data = snapshot.data?.docs.map((e) => e.data()).toList();
                return Column(
                  children: [
                    AppBar(
                      backgroundColor: Colors.white,
                      title: const Text(
                        'My Orders',
                        style: TextStyle(color: Colors.black),
                      ),
                    ),
                    Expanded(
                      child: data == null || data.isEmpty
                          ? const Center(
                              child: Text('You have no orders'),
                            )
                          : ListView.builder(
                              itemCount: data.length,
                              itemBuilder: (_, i) => ListTile(
                                    onTap: () => Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (_) => OrderFullScreen(
                                                order: data[i]))),
                                    title: Text(
                                      data[i].cart.getName,
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                    leading: const Icon(Icons.shopping_bag),
                                    trailing:
                                        Text(ta.format(data[i].createdAt)),
                                    subtitle: Text('Price: ${data[i].price}'),
                                  )),
                    ),
                  ],
                );
              }
              return Container();
            });
      },
    );
  }
}

extension on List<Cart> {
  String get getName => this.map((e) => e.product.name).join(',').toString();
}
