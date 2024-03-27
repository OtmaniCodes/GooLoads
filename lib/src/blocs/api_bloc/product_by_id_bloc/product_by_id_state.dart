part of 'product_by_id_bloc.dart';

@immutable
abstract class ProductByIdState {}

class ProductByIdInitial extends ProductByIdState {}
class APiProductByIdResult extends ProductByIdState {
  final bool isSuccess;
  final Product? data;

  APiProductByIdResult({required this.isSuccess, this.data});
}

class ProductByIdError extends ProductByIdState {
  final String? error;
  ProductByIdError({this.error});
}