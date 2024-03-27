part of 'product_by_id_bloc.dart';

@immutable
abstract class ProductByIdEvent {}
class GetProductByIdEvent extends ProductByIdEvent {
  final int productId;

  GetProductByIdEvent({required this.productId});
}