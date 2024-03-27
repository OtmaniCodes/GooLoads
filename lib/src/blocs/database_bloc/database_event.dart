part of 'database_bloc.dart';

@immutable
abstract class DatabaseEvent {}

class SaveProductToCartEvent extends DatabaseEvent {
  final CartProduct cartProduct;

  SaveProductToCartEvent({required this.cartProduct});
}

class SaveFavouriteProductEvent extends DatabaseEvent {
  final FavouriteProduct favProduct;

  SaveFavouriteProductEvent({required this.favProduct});
}

class GetProductsFromCartEvent extends DatabaseEvent {
  final List cartProductsIds;
  final List productsIds;

  GetProductsFromCartEvent({required this.productsIds, required this.cartProductsIds});
}

class GetFavProductsEvent extends DatabaseEvent {

  final List productsIds;

  GetFavProductsEvent({required this.productsIds});
}