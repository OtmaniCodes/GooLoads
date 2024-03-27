import 'dart:convert';

class FavouriteProduct {
  final String? productId;
  final String? favouriteProductId;
  final String? owner;
  final bool isHearted;


  FavouriteProduct({
    this.productId,
    this.favouriteProductId,
    this.owner,
    this.isHearted = false,
  });

  Map<String, dynamic> toMap() {
    return {
      'productId': productId,
      'favouriteProductId': favouriteProductId,
      'owner': owner,
      'isHearted': isHearted,
    };
  }

  factory FavouriteProduct.fromMap(Map<String, dynamic> map) {
    return FavouriteProduct(
      productId: map['productId'],
      favouriteProductId: map['favouriteProductId'],
      owner: map['owner'],
      isHearted: map['isHearted'],
    );
  }

  String toJson() => json.encode(toMap());

  factory FavouriteProduct.fromJson(String source) => FavouriteProduct.fromMap(json.decode(source));
}
