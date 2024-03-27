import 'dart:convert';

class Product {
  final String? productId;
  final String? salePrice;
  final String? evaluateRate;
  final String? priceCurrency;
  final String? productTitle;
  final String? productDescription;
  final String? productMainImageUrl;
  final List? productSmallImageUrls;
  final String? productDetailUrl;
  final String? productKeywords;
  final List? productCategoriesBreadcrumb;

  Product(
      {this.productId,
      this.salePrice,
      this.evaluateRate,
      this.priceCurrency,
      this.productTitle,
      this.productDescription,
      this.productMainImageUrl,
      this.productSmallImageUrls,
      this.productDetailUrl,
      this.productKeywords,
      this.productCategoriesBreadcrumb});

  Map<String, dynamic> toMap() {
    return {
      'product_id': productId,
      'app_sale_price': salePrice,
      'evaluate_rate': evaluateRate,
      'app_sale_price_currency': priceCurrency,
      'product_title': productTitle,
      'product_description': productDescription,
      'product_main_image_url': productMainImageUrl,
      'product_small_image_urls': productSmallImageUrls,
      'product_detail_url': productDetailUrl,
      'keywords': productKeywords,
      'productCategoriesBreadcrumb':productCategoriesBreadcrumb
    };
  }

  factory Product.fromMap(Map<String, dynamic> map) {
    return Product(
      productId: map['product_id']?.toString()??"Unknown",
      salePrice: map['app_sale_price']?.toString()??"Unknown",
      evaluateRate: map['evaluate_rate']?.toString()??"Unknown",
      priceCurrency: map['app_sale_price_currency'],
      productTitle: map['metadata']['titleModule']['product_title'],
      productDescription: map['metadata']['titleModule']['product_description'],
      productMainImageUrl: map['product_small_image_urls']["string"][0],
      productSmallImageUrls: map['product_small_image_urls']["string"],
      productDetailUrl: map['product_detail_url'],
      productKeywords: map['metadata']['pageModule']['keywords'],
      productCategoriesBreadcrumb: map["productCategoriesBreadcrumb"]
    );
  }

  String toJson() => json.encode(toMap());

  factory Product.fromJson(String source) =>
      Product.fromMap(json.decode(source));
}
