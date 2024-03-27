import 'dart:convert';

class CartProduct {
  final String? productId;
  final String? owner;
  final String? cartProductId;
  final int productsCount;
  final bool isAddedToCart;

  CartProduct({
    this.productId,
    this.owner,
    this.productsCount = 1,
    this.isAddedToCart = false,
    this.cartProductId,
  });

  Map<String, dynamic> toMap() {
    return {
      'productId': productId,
      'owner': owner,
      'cartProductId': cartProductId,
      'productsCount': productsCount,
      'isAddedToCart': isAddedToCart,
    };
  }

  factory CartProduct.fromMap(Map<String, dynamic> map) {
    return CartProduct(
      productId: map['productId'],
      owner: map['owner'],
      cartProductId: map['cartProductId'],
      productsCount: map['productsCount'],
      isAddedToCart: map['isAddedToCart'],
    );
  }

  String toJson() => json.encode(toMap());

  factory CartProduct.fromJson(String source) =>
      CartProduct.fromMap(json.decode(source));
}
