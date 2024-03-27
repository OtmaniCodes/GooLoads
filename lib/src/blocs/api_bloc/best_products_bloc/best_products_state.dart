part of 'best_products_bloc.dart';

@immutable
abstract class BestProductsState {}

class BestProductsInitial extends BestProductsState {}
class BestProductsResult extends BestProductsState {
  final bool isSuccess;
  final List? data;

  BestProductsResult({required this.isSuccess, this.data});
}

class BestProductsError extends BestProductsState {
  final String? error;
  BestProductsError({this.error});
}