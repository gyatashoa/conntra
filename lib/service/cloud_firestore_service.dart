import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:contra/model/product.dart';

import '../model/order.dart';

class CloudFirestoreService {
  late FirebaseFirestore _firebaseFirestore;

  CloudFirestoreService() {
    _firebaseFirestore = FirebaseFirestore.instance;
  }

  Future<void> placeOrder(Order order) async {
    try {
      _firebaseFirestore.collection('orders').add(order.toJson());
    } on Exception {}
  }

  Stream<QuerySnapshot<Order>> getOrders(String email) async* {
    yield* _firebaseFirestore
        .collection('orders')
        .where('email', isEqualTo: email)
        .withConverter<Order>(
            fromFirestore: ((snapshot, options) =>
                Order.fromJson({...snapshot.data() ?? {}, 'id': snapshot.id})),
            toFirestore: (value, _) => value.toJson())
        .snapshots();
  }
}
