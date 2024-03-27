import 'package:flutter_test/flutter_test.dart';
import 'package:gooloads/src/models/product_model.dart';
import 'package:gooloads/src/services/api/api_service.dart';

class MockApiService extends ApiService {
  @override
  Future getProductById(int productId) {
    Product mockedProduct = Product(
      productId: productId.toString(),
      evaluateRate: '4.6',
      priceCurrency: r'$',
      productDescription: 'good product ma boy!',
      productTitle: 'laptop mouse',
      salePrice: '100',
    );
    return Future.value(['success', mockedProduct]);
  }
}

void main() {
  group('Api components should fetch occurate data', (){
    test('product\'s sales price is a string', () async {
      final result = await MockApiService().getProductById(3434343434);
      expect(result[1].salePrice is String, true);
    });

  test('the fetch is a success!', () async {
      final result = await MockApiService().getProductById(3434343434);
      expect(result[0], 'success');
    });
  });
}
