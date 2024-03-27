import 'dart:convert';

class CardProductModel {
  final String? productId;
  final String? appSalePrice;
  final String? appSalePriceCurrency;
  final String? evaluateRate;
  final String? productMainImageUrl;
  final String? productTitle;

  CardProductModel(
      {this.productId,
      this.appSalePrice,
      this.appSalePriceCurrency,
      this.evaluateRate,
      this.productMainImageUrl,
      this.productTitle});

  Map<String, dynamic> toMap() {
    return {
      'productId': productId,
      'appSalePrice': appSalePrice,
      'appSalePriceCurrency': appSalePriceCurrency,
      'evaluateRate': evaluateRate,
      'productMainImageUrl': productMainImageUrl,
      'productTitle': productTitle,
    };
  }

  factory CardProductModel.fromMap(Map<String, dynamic> map) {
     String _foramtEvaluationRate(){
        String evalRate = '';
        if(map.containsKey('evaluate_rate')){
        if(map['evaluate_rate'].toString().contains("%") &&  double.parse(map['evaluate_rate'].toString().replaceAll("%", '')) > 5) 
        evalRate = map['evaluate_rate'].toString().replaceAll("%", '');
        else if(map['evaluate_rate'].toString().contains("%") &&  double.parse(map['evaluate_rate'].toString().replaceAll("%", '')) <= 5){
        evalRate = ((double.parse(map['evaluate_rate'].toString().replaceAll("%", ''))/5.0)*100).toString();    
        }else if(double.parse(map['evaluate_rate'].toString().replaceAll("%", '')) < 5 && !map['evaluate_rate'].toString().contains("%")){
        evalRate = ((double.parse(map['evaluate_rate'].toString())/5.0)*100).toString();
        }else{
        evalRate = map['evaluate_rate'].toString();}}
        return evalRate;
      }
    return CardProductModel(
      productId: map['product_id']?.toString() ?? "",
      appSalePrice: map['app_sale_price']?.toString()?? "",
      appSalePriceCurrency: map['app_sale_price_currency'],
      evaluateRate: _foramtEvaluationRate(),
      productMainImageUrl: map['product_main_image_url'],
      productTitle: map['product_title'],
    );
  }

  String toJson() => json.encode(toMap());

  factory CardProductModel.fromJson(String source) =>
      CardProductModel.fromMap(json.decode(source));

 
 
}
