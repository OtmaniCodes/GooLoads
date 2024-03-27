part of 'product_by_category_id_bloc.dart';

@immutable
abstract class ProductByCategoryIdState {}

class ProductByCategoryIdInitial extends ProductByCategoryIdState {}
class ProductByCategoryIdError extends ProductByCategoryIdState {
  final String? error;
  ProductByCategoryIdError({this.error});
}
class ProductsByCategoryIdResult extends ProductByCategoryIdState {
  final bool isSuccess;
  final List? data;

  ProductsByCategoryIdResult({required this.isSuccess, this.data});
}