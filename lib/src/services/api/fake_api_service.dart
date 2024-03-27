import 'package:flutter/services.dart' show rootBundle;

const String filePath = "lib/src/services/api/fake_commerce_api/";

class FakeApiService {
  Future<String> getAllCategoriesFake() async {
    print("GETTING FAKE DATA OF [getAllCategories]");
    return await rootBundle.loadString(filePath + "all_categories_api.json");
  }

    Future<String> getBestProductsFake() async {
    print("GETTING FAKE DATA OF [getBestProducts]");
    return await rootBundle.loadString(filePath + "best_products.json");
  }

  Future<String> getSearchProductsFake() async {
    print("GETTING FAKE DATA OF [getSearchProducts]");
    return await rootBundle.loadString(filePath + "search_products.json");
  }

  Future<String> getProductsByCategoryIdFake(String categoryId) async {
    print("GETTING FAKE DATA OF [getProductsByCategoryId]");
    late String selectedFile;
    switch (categoryId) {
       case '0':
        selectedFile = 'products_by_categoty_id_01.json';
        break;
      case '1':
        selectedFile = 'products_by_categoty_id_03.json';
        break;
      case '2':
        selectedFile = 'products_by_categoty_id_02.json';
        break;
      case '3':
        selectedFile = 'products_by_categoty_id_03.json';
        break;
    }
    return await rootBundle.loadString(filePath + selectedFile);
  }
  Future<String> getProductsByIdFake(String productId) async {
    print("GETTING FAKE DATA OF [getProductsById]");
     late String selectedFile;
    switch (productId) {
       case '0':
        selectedFile = 'product_by_id_01.json';
        break;
      case '1':
        selectedFile = 'product_by_id_02.json';
        break;
      case '2':
        selectedFile = 'product_by_id_03.json';
        break;
      case '3':
        selectedFile = 'product_by_id_04.json';
        break;
        case '4':
        selectedFile = 'product_by_id_05.json';
        break;
    }
    return await rootBundle.loadString(filePath + selectedFile);
  }
}
