part of 'database_bloc.dart';

@immutable
abstract class DatabaseState {}

class DatabaseLoading extends DatabaseState {}

class SaveProductToCartResult extends DatabaseState{
final bool productIsAddedSuccessfuly;

  SaveProductToCartResult({required this.productIsAddedSuccessfuly});
}
class SaveFavouriteProductResult extends DatabaseState{
final bool productIsAddedSuccessfuly;

  SaveFavouriteProductResult({required this.productIsAddedSuccessfuly});
}




class CartProductsResult extends DatabaseState{
  final  List<Map> cartProductsFromDB;

  CartProductsResult({required this.cartProductsFromDB});

}

class FavProductsResult extends DatabaseState{
  final List favProductsFromDB;

  FavProductsResult({required this.favProductsFromDB});

}


class DatabaseError extends DatabaseState{
  final Error? error;

  DatabaseError({this.error});
  
}
