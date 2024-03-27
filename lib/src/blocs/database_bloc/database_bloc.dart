import 'dart:async';
import 'dart:math';

import 'package:bloc/bloc.dart';
import 'package:gooloads/src/models/cart_product_dart.dart';
import 'package:gooloads/src/models/favourite_product_model.dart';
import 'package:gooloads/src/models/product_model.dart';
import 'package:gooloads/src/services/api/api_service.dart';
import 'package:gooloads/src/services/database/db_service.dart';
import 'package:gooloads/src/utils/service_locator.dart';
import 'package:meta/meta.dart';

part 'database_event.dart';
part 'database_state.dart';

class DatabaseBloc extends Bloc<DatabaseEvent, DatabaseState> {
  DatabaseBloc() : super(DatabaseLoading());

  @override
  Stream<DatabaseState> mapEventToState(DatabaseEvent event) async* {
    yield DatabaseLoading();
    if (event is SaveProductToCartEvent) {
       String result = "error";
      try {
        await serviceLocator<DataBaseService>().addCartProductToDB(event.cartProduct);
        result = 'success';
      } catch (error) {
        print(error);
        yield DatabaseError();
      }
      if (result == 'success') {
        yield SaveProductToCartResult(productIsAddedSuccessfuly: true);
      } else {
        yield SaveProductToCartResult(productIsAddedSuccessfuly: false);
      }
         
    } else if (event is GetProductsFromCartEvent) {
      List<Map> returnedProducts = [];
      try {
        for (String productId in event.productsIds) {
          List resultFromApi = await serviceLocator<ApiService>().getProductById(int.parse(productId)); //Random().nextInt(5));
          if (resultFromApi.first == "success") {
            returnedProducts.add({'product':resultFromApi[1],'cartProductId': event.cartProductsIds[event.productsIds.indexOf(productId)]});
          }
          // await Future.delayed(Duration(seconds: 1)); //! uncomment this line if there is too much pressure on the server due to requests
        }
        yield CartProductsResult(cartProductsFromDB: returnedProducts);
      } catch (error) {
        print('ERROR: $error');
        yield DatabaseError();
      }
    }else if(event is SaveFavouriteProductEvent){
       String result = "error";
      try {
        await serviceLocator<DataBaseService>()
            .addFavouriteProductToDB(event.favProduct);
        result = 'success';
      } catch (error) {
        print(error);
        yield DatabaseError();
      }
      print(result);
      if (result == 'success') {
        yield SaveFavouriteProductResult(productIsAddedSuccessfuly: true);
      } else {
        yield SaveFavouriteProductResult(productIsAddedSuccessfuly: false);
      }
    }else if (event is GetFavProductsEvent) {
      List returnedProducts = [];
      try {
        for (String productId in event.productsIds) {
          List resultFromApi = await serviceLocator<ApiService>()
              .getProductById(int.parse(productId));//Random().nextInt(5));
          if (resultFromApi.first == "success") {
            returnedProducts.add(resultFromApi[1]);
          }
          // await Future.delayed(Duration(seconds: 1)); //! uncomment this line if there is too much pressure on the server due to requests
        }
        yield FavProductsResult(favProductsFromDB: returnedProducts);
      } catch (error) {
        print('ERROR: $error');
        yield DatabaseError();
      }
    }
  }

}
