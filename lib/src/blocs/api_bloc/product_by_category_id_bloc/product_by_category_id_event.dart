part of 'product_by_category_id_bloc.dart';

@immutable
abstract class ProductByCategoryIdEvent {}
class GetProductsByCategoryIdEvent extends ProductByCategoryIdEvent {
  final int categoryId;

  GetProductsByCategoryIdEvent({required this.categoryId});
}