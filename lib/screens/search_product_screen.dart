import 'package:contra/model/product.dart';
import 'package:contra/screens/products/product_screen.dart';
import 'package:flutter/material.dart';

class SearchProductScreen extends SearchDelegate {
  SearchProductScreen({required this.products});

  final List<Product> products;

  @override
  List<Widget>? buildActions(BuildContext context) {
    return [IconButton(onPressed: () => query = '', icon: Icon(Icons.clear))];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
        onPressed: () => Navigator.pop(context), icon: Icon(Icons.arrow_back));
  }

  @override
  Widget buildResults(BuildContext context) {
    final res = products
        .where((e) => e.name.toLowerCase().contains(query.toLowerCase()))
        .toList();
    return ListView.builder(
        itemCount: res.length,
        itemBuilder: (_, i) => ListTile(
              title: Text(res[i].name),
              onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (_) => ProductScreen(product: res[i]))),
              leading: CircleAvatar(
                backgroundImage: NetworkImage(res[i].image ?? ''),
              ),
            ));
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    final res = products
        .where((e) => e.name.toLowerCase().contains(query.toLowerCase()))
        .toList();
    return ListView.builder(
        itemCount: res.length,
        itemBuilder: (_, i) => ListTile(
              title: Text(res[i].name),
              onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (_) => ProductScreen(product: res[i]))),
              leading: CircleAvatar(
                backgroundImage: NetworkImage(res[i].image ?? ''),
              ),
            ));
  }
}
