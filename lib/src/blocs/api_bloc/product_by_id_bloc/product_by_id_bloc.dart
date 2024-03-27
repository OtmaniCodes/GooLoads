import 'dart:async';
import 'dart:math';

import 'package:bloc/bloc.dart';
import 'package:gooloads/src/models/product_model.dart';
import 'package:gooloads/src/services/api/api_service.dart';
import 'package:gooloads/src/utils/service_locator.dart';
import 'package:meta/meta.dart';

part 'product_by_id_event.dart';
part 'product_by_id_state.dart';

class ProductByIdBloc extends Bloc<ProductByIdEvent, ProductByIdState> {
  ProductByIdBloc() : super(ProductByIdInitial());

  @override
  Stream<ProductByIdState> mapEventToState(ProductByIdEvent event) async* {
    try {
        if (event is GetProductByIdEvent) {
        final List result = await serviceLocator<ApiService>().getProductById(event.productId);//Random().nextInt(5));
        final bool isSuccess = result.first == "success";        
        if (isSuccess) yield APiProductByIdResult(isSuccess: isSuccess, data: result[1]);
        else yield ProductByIdError(error: result[1]);}
      } catch (e) {print(e);}
  }
}
