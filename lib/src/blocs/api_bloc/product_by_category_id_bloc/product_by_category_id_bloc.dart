import 'dart:async';
import 'dart:math';

import 'package:bloc/bloc.dart';
import 'package:gooloads/src/services/api/api_service.dart';
import 'package:gooloads/src/utils/logger.dart';
import 'package:gooloads/src/utils/service_locator.dart';
import 'package:meta/meta.dart';

part 'product_by_category_id_event.dart';
part 'product_by_category_id_state.dart';

class ProductByCategoryIdBloc
    extends Bloc<ProductByCategoryIdEvent, ProductByCategoryIdState> {
  ProductByCategoryIdBloc() : super(ProductByCategoryIdInitial());

  @override
  Stream<ProductByCategoryIdState> mapEventToState(ProductByCategoryIdEvent event) async* {
    yield ProductByCategoryIdInitial();
    try {
      if (event is GetProductsByCategoryIdEvent) {
        List result = await serviceLocator<ApiService>().getProductsByCategoryId(event.categoryId); //Random().nextInt(3));
        bool isSuccess = result[0] == "success";
        if (isSuccess) {
          yield ProductsByCategoryIdResult(isSuccess: isSuccess, data: result[1]);
        } else {
          DevLogger.log(result[1], name: 'api error');
          yield ProductByCategoryIdError(error: result[1]);
        }
      }
    } catch (e) {
      print(e);
    }
  }
}
