import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:gooloads/src/services/api/api_service.dart';
import 'package:gooloads/src/utils/service_locator.dart';
import 'package:meta/meta.dart';

part 'search_products_event.dart';
part 'search_products_state.dart';

class SearchProductsBloc extends Bloc<SearchProductsEvent, SearchProductsState> {
  SearchProductsBloc() : super(SearchProductsInitial());

  @override
  Stream<SearchProductsState> mapEventToState(SearchProductsEvent event) async* {
    try {
        final List result = await serviceLocator<ApiService>().getSearchProducts();
        if (event is GetSearchProductsEvent) {
        final bool isSuccess = result.first == "success";
        if (isSuccess) yield SearchProductsResult(isSuccess: isSuccess, data: result[1]);
        else yield SearchProductsError(error: result[1]);        
        } else if (event is SearchProductsByNameEvent) {
        List filterdSearchProducts = [];
        final bool isSuccess = result.first == "success";
        if (isSuccess) {
          for (var element in result[1]) {
            if (element.productTitle!.toLowerCase().contains(event.query.toLowerCase())) 
              filterdSearchProducts.add(element);            
          }
          yield SearchProductsResult(isSuccess: isSuccess, data: filterdSearchProducts);
        } else {yield SearchProductsError(error: result[1]);}
      }
    } catch (e) {print(e);}
  }
}
