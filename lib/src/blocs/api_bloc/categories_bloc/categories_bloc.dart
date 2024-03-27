import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:gooloads/src/models/product_category_model.dart';
import 'package:gooloads/src/services/api/api_service.dart';
import 'package:gooloads/src/utils/service_locator.dart';
import 'package:meta/meta.dart';

part 'categories_event.dart';
part 'categories_state.dart';

class CategoriesBloc extends Bloc<CategoriesEvent, CategoriesState> {
  CategoriesBloc() : super(CategoriesInitial());

  @override
  Stream<CategoriesState> mapEventToState(CategoriesEvent event) async* {
     try{
       if (event is GetAllCategoriesEvent) {
        List result = await serviceLocator<ApiService>().getAllCategories();
        final bool isSuccess = result[0] == "success";
        if (isSuccess) {
          // The following few lines are responsible for removing all the categories
          // that have either a null [categoryName] or a null [apiCategoryApi]

          Set<ProductCategory> categories = Set();
          for (ProductCategory element in result[1]) 
            if (element.apiCategoryId != null && element.categoryName != null) categories.add(element);          
          yield ApiAllCategoriesResult(isSuccess: isSuccess, data: categories.toList());
        } else {
          yield CategoriesError(error: result[1]);
        }
      }
     }catch(e){print(e);}
  }
}
