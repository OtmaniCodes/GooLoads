import 'dart:convert';
import 'package:gooloads/src/models/best_product_module.dart';
import 'package:gooloads/src/models/card_product_model.dart';
import 'package:gooloads/src/models/product_category_model.dart';
import 'package:gooloads/src/models/product_model.dart';
import 'package:gooloads/src/utils/constants/constants.dart';
import 'package:http/http.dart' as http;
import './fake_api_service.dart' show FakeApiService;

const Map<String, String> headers = {
  'x-rapidapi-key': KApiKey,
  'x-rapidapi-host': KApiHost
};

class ApiService {
  Uri getUri(String path) {
    return Uri(scheme: KApiScheme, host: KApiHost, path: path);
  }

  Future getAllCategories() async {
    List retVal = ["error"];
    final Uri uri = getUri("api/v2/categories");
    try {
      http.Response response = await http.get(uri, headers: headers);
      // String responseBody = await FakeApiService().getAllCategoriesFake();
      if (response.statusCode == KSuccessGetCode) {
      List allCategories = 
          json.
          decode(response.body)
          // decode(responseBody)
          .map((map) => ProductCategory.fromMap(map))
          .toList();

      retVal[0] = "success";
      retVal.add(allCategories);
      }
    } catch (error) {
      retVal.add(error);
      print(error);
    }
    return retVal;
  }

  Future getProductsByCategoryId(int categoryId) async {
    List retVal = ["error"];
    final Uri uri = getUri("api/category/${categoryId.toString()}/products");
    try {
      http.Response response = await http.get(uri, headers: headers);
      // String responseBody = await FakeApiService().getProductsByCategoryIdFake(categoryId.toString());
      if (response.statusCode == KSuccessGetCode) {
        final _decodedData = json
        .decode(response.body);
        //  .decode(responseBody);
        List productsByCategoryId = _decodedData["docs"].map((map) => CardProductModel.fromMap(map)).toList();

      print('==========================================================================================================');
      print([for (CardProductModel cate in productsByCategoryId) cate.productTitle]);
        retVal[0] = "success";
        retVal.add(productsByCategoryId);
      }
    } catch (error) {
      retVal.add(error.toString());
    }
    return retVal;
  }

  Future getProductById(int productId) async {
    List retVal = ["error"];
    final Uri uri = getUri("api/product/${productId.toString()}");
    try {
      http.Response response = await http.get(uri, headers: headers);
      // String responseBody = await FakeApiService().getProductsByIdFake(productId.toString());

      if (response.statusCode == KSuccessGetCode) {
        Product productById = Product.fromJson(response.body);//responseBody);
        retVal[0] = "success";
        retVal.add(productById);
      }
    } catch (error) {
      print(error);
      retVal.add(error);
    }
    return retVal;
  }

  Future getBestProducts() async {
    List retVal = ["error"];
    final Uri uri = getUri("api/bestSales/SortedByNewest");
    try {
      // String responseBody = await FakeApiService().getBestProductsFake();
      http.Response response = await http.get(uri, headers: headers);//comment
      if (response.statusCode == KSuccessGetCode) {//comment
        List bestProducts = json
            .decode(response.body) //comment
            // .decode(responseBody)
            .map((map) => BestProduct.fromMap(map))
            .toList();
        retVal[0] = "success";
        retVal.add(bestProducts);
      }//comment
    } catch (error) {
      print(error);
      retVal.add(error);
    }
    return retVal;
  }

  Future getSearchProducts() async {
    List retVal = ["error"];
    final Uri uri = getUri("api/products/search");
    try {
      http.Response response = await http.get(uri, headers: headers);
      // String responseBody = await FakeApiService().getSearchProductsFake();
      if (response.statusCode == KSuccessGetCode) {
        List searchProducts = json
            // .decode(responseBody)["docs"]
            .decode(response.body)["docs"]
            .map((map) => CardProductModel.fromMap(map))
            .toList();

        searchProducts.forEach((element) {
          print(element.productId);
        });
        retVal[0] = "success";
        retVal.add(searchProducts);
      }
    } catch (error) {
      retVal.add(error);
      
    }
    return retVal;
  }
}
