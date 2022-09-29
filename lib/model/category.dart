import 'package:equatable/equatable.dart';

class Category extends Equatable {
  final int categoryId;
  final String categoryName;

  Category({required this.categoryName, required this.categoryId});

  Category.fromJson(Map<String, dynamic> data)
      : categoryId = data['category_id'],
        categoryName = data['category_name'];

  Map<String, dynamic> get toJson =>
      {'category_id': categoryId, 'category_name': categoryName};

  bool equals(Category category) =>
      categoryId == category.categoryId && categoryName == categoryName;

  @override
  List<Object?> get props => [categoryId, categoryName];
}
