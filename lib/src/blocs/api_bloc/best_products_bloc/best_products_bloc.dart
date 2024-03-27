import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:gooloads/src/services/api/api_service.dart';
import 'package:gooloads/src/utils/service_locator.dart';
import 'package:meta/meta.dart';
part 'best_products_event.dart';
part 'best_products_state.dart';

class BestProductsBloc extends Bloc<BestProductsEvent, BestProductsState> {
  BestProductsBloc() : super(BestProductsInitial());

  @override
  Stream<BestProductsState> mapEventToState(BestProductsEvent event) async* {
  try{
    if (event is GetBestProductsEvent) {
        List result = await serviceLocator<ApiService>().getBestProducts();
        bool isSuccess = result[0] == "success";
        if (isSuccess) yield BestProductsResult(isSuccess: isSuccess, data: result[1]);
        else yield BestProductsError(error: result[1]);        
      } 
    }catch(e){print(e);}
  }
}
