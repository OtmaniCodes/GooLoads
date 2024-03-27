import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gooloads/src/blocs/database_bloc/database_bloc.dart';
import 'package:gooloads/src/models/card_product_model.dart';
import 'package:gooloads/src/models/favourite_product_model.dart';
import 'package:gooloads/src/services/database/db_service.dart';
import 'package:gooloads/src/utils/constants/constants.dart';
import 'package:gooloads/src/utils/constants/palette.dart';
import 'package:gooloads/src/utils/service_locator.dart';
import 'package:gooloads/src/view/global_widgets/custom_black_button.dart';
import 'package:gooloads/src/view/global_widgets/custom_product_card.dart';
import 'package:gooloads/src/view/global_widgets/custom_text.dart';
import 'package:gooloads/src/view/shimmer_widgets/favourite/fav_grid_ahimmer.dart';

import 'local_widgets/favourite_app_bar.dart';

class FavouriteScreen extends StatefulWidget {
  const FavouriteScreen({Key? key}) : super(key: key);

  @override
  _FavouriteScreenState createState() => _FavouriteScreenState();
}

class _FavouriteScreenState extends State<FavouriteScreen> {
  late ScrollController _scrollController;
  Color appBarClr = Palette.KTransparentClr;
  double appBarElevation = 0.0;
  bool cartProductsIdsGotten = false;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
    _scrollController..addListener(() {});
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _getFavProductsIds(List<FavouriteProduct> data) {
    List<String> productsIds = [for (FavouriteProduct cartProduct in data) cartProduct.productId ?? ''];
    context.read<DatabaseBloc>().add(GetFavProductsEvent(productsIds: productsIds));
    // if(mounted) setState.call(()=>cartProductsIdsGotten = true);
    cartProductsIdsGotten = true;
  }

  bool buildCondition(state) => (state is FavProductsResult ||
      state is DatabaseError ||
      state is DatabaseLoading);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        child: FavouriteAppBar(),
        preferredSize: Size.fromHeight(56),
      ),
      body: Padding(
        padding: const EdgeInsets.only(left: 10, right: 10),
        child: StreamBuilder<List<FavouriteProduct>>(
            stream: serviceLocator<DataBaseService>().getFavouriteProductsFromDB(),
            builder: (context, favouriteSnap) {
              final _hasData = favouriteSnap.hasData ? favouriteSnap.data != null : false;
              if (_hasData) {
                if (!cartProductsIdsGotten)
                  _getFavProductsIds(favouriteSnap.data ?? []);
                return BlocBuilder<DatabaseBloc, DatabaseState>(
                    buildWhen: (oldState, newState) => buildCondition(newState),
                    builder: (context, state) {
                      if (state is FavProductsResult)
                        return _buildFavProductCards(state);
                      else if (state is DatabaseError) {
                        return Center(child: Text("Error"));
                      } else
                        return FavGridShimmer();
                    });
              } else {
                return FavGridShimmer();
              }
            }),
      ),
    );
  }

  Widget _buildFavProductCards(FavProductsResult state) {
    if (state.favProductsFromDB.isNotEmpty) {
      return GridView.count(
        padding: EdgeInsets.symmetric(vertical: 20),
        childAspectRatio: 0.62,
          crossAxisCount: 2,
          mainAxisSpacing: 15.0,
          crossAxisSpacing: 15.0,
          children: [
            ...List.generate(state.favProductsFromDB.length,
                (index){
                  print(state.favProductsFromDB[index].evaluateRate);
                  final CardProductModel _productModel = CardProductModel(
                    appSalePrice: state.favProductsFromDB[index].salePrice,
                    productTitle: state.favProductsFromDB[index].productTitle,
                    evaluateRate: state.favProductsFromDB[index].evaluateRate.toString().replaceAll('%', ''),
                    appSalePriceCurrency: state.favProductsFromDB[index].priceCurrency,
                    productId: state.favProductsFromDB[index].productId,
                    productMainImageUrl: state.favProductsFromDB[index].productMainImageUrl,
                  );
                  return GestureDetector(
                  onTap: (){
                    Navigator.pushNamed(context, KItemRoute, arguments: _productModel.productId);
                  },
                  child: MyProductCard(
                      product: _productModel,
                      isForFavourite: true),
                );}
                ),
          ]);
    } else {
      return Column(
        children: [
          Spacer(),
          MyText(txt: "❤", size: 40),
          TINY_VSPACING,
          MyText(
            txt: "You have no products added\nto favourites yet!",
            alignment: TextAlign.center,
            clr: Palette.KBlackClr,
          ),
          MEDIUM_VSPACING,
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 100),
            child: MyBlackButton(
              txt: "Go shopping",
              onPressed: (){
                Navigator.pop(context);
              }),
          ),
          Spacer(flex: 2)
        ],
      );
    }
  }
}
