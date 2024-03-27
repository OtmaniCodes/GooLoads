import 'dart:convert';

class BestProduct {
  final String? productId;
  final String? salePrice;
  final String? evaluateRate;
  final String? priceCurrency;
  final String? productTitle;

  final String? productMainImageUrl;
  final List? productSmallImageUrls;
  final String? productDetailUrl;

  BestProduct({
    this.productId,
    this.salePrice,
    this.evaluateRate,
    this.priceCurrency,
    this.productTitle,
    this.productMainImageUrl,
    this.productSmallImageUrls,
    this.productDetailUrl,
  });

  Map<String, dynamic> toMap() {
    return {
      'product_id': productId,
      'app_sale_price': salePrice,
      'evaluate_rate': evaluateRate,
      'app_sale_price_currency': priceCurrency,
      'product_title': productTitle,
      'product_main_image_url': productMainImageUrl,
      'product_small_image_urls': productSmallImageUrls,
      'product_detail_url': productDetailUrl,
    };
  }

  factory BestProduct.fromMap(Map<String, dynamic> map) {
    return BestProduct(
      productId: map['product_id']?.toString() ?? "Unknown",
      salePrice: map['app_sale_price']?.toString() ?? "Unknown",
      evaluateRate: map['evaluate_rate']?.toString() ?? "Unknown",
      priceCurrency: map['app_sale_price_currency'],
      productTitle: map['product_title'],
      productMainImageUrl: map['product_small_image_urls']["string"][0],
      productSmallImageUrls: map['product_small_image_urls']["string"],
      productDetailUrl: map['product_detail_url'],
    );
  }

  String toJson() => json.encode(toMap());

  factory BestProduct.fromJson(String source) =>
      BestProduct.fromMap(json.decode(source));
}
