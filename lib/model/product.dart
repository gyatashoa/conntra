import 'package:contra/model/category.dart';
import 'package:equatable/equatable.dart';

class Product extends Equatable {
  final int id;
  final Category category;
  final String name;
  final String productCode;
  final String? image;
  final double? price;
  final String description;
  final String? stock;

  Product(
      {required this.id,
      required this.category,
      required this.productCode,
      required this.name,
      required this.stock,
      required this.description,
      required this.price,
      required this.image});

  Product.fromJson(Map<String, dynamic> data)
      : name = data['name'] ?? data['product_name'],
        description = data['description'] ?? '',
        price = data['price'] == null
            ? null
            : (data['price'] is double
                ? data['price']
                : double.tryParse(data['price'])),
        image = data['image'],
        category = data['category'] is String
            ? Category(categoryName: data['category'], categoryId: 1)
            : Category.fromJson(data['category']),
        stock = data['stock'] ?? data['status'],
        id = data['id'],
        productCode = data['productCode'] ?? '';

  Map<String, dynamic> get toJson => {
        'name': name,
        'description': description,
        'price': price,
        'image': image,
        'category': category.categoryName,
        'id': id,
        'productCode': productCode
      };

  bool equals(Product product) => id == product.id;

  @override
  List<Object?> get props =>
      [id, category, name, productCode, image, price, description, stock];
}
