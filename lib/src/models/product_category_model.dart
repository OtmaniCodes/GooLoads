import 'dart:convert';

class ProductCategory {
  final String? categoryName;
  final int? apiCategoryId;

  ProductCategory({this.categoryName, this.apiCategoryId});

  Map<String, dynamic> toMap() {
    return {
      'category_name': categoryName,
      'api_category_id': apiCategoryId,
    };
  }

  factory ProductCategory.fromMap(Map<String, dynamic> map) {
    return ProductCategory(
      categoryName: map['category_name'],
      apiCategoryId: map['api_category_id'],
    );
  }

  String toJson() => json.encode(toMap());

  factory ProductCategory.fromJson(String source) => ProductCategory.fromMap(json.decode(source));
}
