part of 'search_products_bloc.dart';

@immutable
abstract class SearchProductsState {}

class SearchProductsInitial extends SearchProductsState {}
class SearchProductsResult extends SearchProductsState {
  final bool isSuccess;
  final List? data;

  SearchProductsResult({required this.isSuccess, this.data});
}

class SearchProductsError extends SearchProductsState {
  final String? error;
  SearchProductsError({this.error});
}