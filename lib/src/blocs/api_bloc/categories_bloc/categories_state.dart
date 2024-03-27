part of 'categories_bloc.dart';

@immutable
abstract class CategoriesState {}

class CategoriesInitial extends CategoriesState {}
class ApiAllCategoriesResult extends CategoriesState {  
  final bool isSuccess;
  final List? data;

  ApiAllCategoriesResult({required this.isSuccess, this.data});
}

class CategoriesError extends CategoriesState {
  final String? error;
  CategoriesError({this.error});
}