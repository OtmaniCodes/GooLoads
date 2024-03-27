part of 'search_products_bloc.dart';

@immutable
abstract class SearchProductsEvent {}
class GetSearchProductsEvent extends SearchProductsEvent {}

class SearchProductsByNameEvent extends SearchProductsEvent {
  final String query;

  SearchProductsByNameEvent({required this.query});
}