import 'package:flutter/material.dart';
import 'package:gooloads/src/blocs/database_bloc/database_bloc.dart';
import 'package:gooloads/src/models/cart_product_dart.dart';
import 'package:gooloads/src/models/product_model.dart';
import 'package:gooloads/src/services/database/db_service.dart';
import 'package:gooloads/src/utils/constants/constants.dart';
import 'package:gooloads/src/utils/constants/palette.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gooloads/src/utils/service_locator.dart';
import 'package:gooloads/src/view/global_widgets/custom_black_button.dart';
import 'package:gooloads/src/view/global_widgets/custom_text.dart';
import 'package:gooloads/src/view/shimmer_widgets/cart/carts_list_shimmer.dart';
import 'local_widgets/cart_app_bar.dart';
import 'local_widgets/cart_product_tile.dart';
import 'local_widgets/checkout_details_list.dart';

class CartScreen extends StatefulWidget {
  CartScreen({Key? key}) : super(key: key);

  @override
  _CartScreenState createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  late ScrollController _scrollController;
  bool cartProductsIdsGotten = false;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
    _scrollController.addListener(() {});
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  bool _buildCondition(DatabaseState state) => (state is CartProductsResult || state is DatabaseError || state is DatabaseLoading);

  void _showCheckoutDetailsList(){
    showModalBottomSheet(
    context: context,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.only(topLeft: Radius.circular(KDefaultPadd), topRight: Radius.circular(KDefaultPadd)),
      ),
    backgroundColor: Palette.KWhiteClr,
    builder: (context) {
      return CheckoutDetailsList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        child: CartAppBar(onNext: _showCheckoutDetailsList,),
        preferredSize: Size.fromHeight(56)),
      body: StreamBuilder<List<CartProduct>>(
            stream: serviceLocator<DataBaseService>().getCartProductsFromDB(),
            builder: (context, snapshot) {
              final _hasData = snapshot.hasData ? snapshot.data != null : false;
              if (_hasData) {
                print('data: ${snapshot.data!.first.cartProductId}');
                print('cartProductsIdsGotten: $cartProductsIdsGotten');
                if (!cartProductsIdsGotten) {
                  final cartProductsIds = [for (CartProduct cartProduct in snapshot.data??[]) cartProduct.cartProductId ?? '' ];
                  List<String> productsIds = [for (CartProduct cartProduct in snapshot.data??[]) cartProduct.productId ?? '' ];
                  context.read<DatabaseBloc>().add(GetProductsFromCartEvent(productsIds: productsIds, cartProductsIds: cartProductsIds));
                  cartProductsIdsGotten = true;
                }
                return BlocBuilder<DatabaseBloc, DatabaseState>(
                  buildWhen: (oldState, newState) => _buildCondition(newState),
                  builder: (context, state) {
                    if (state is CartProductsResult)
                      return _buildCartproductTiles(state);
                    else if (state is DatabaseError) {
                      return Center(child: Text("Error"));
                    } else
                      return CartProductsListShimmer();
                  },
                );
              }
              return CartProductsListShimmer();
            },
          ),
    );
  }

  Widget _buildCartproductTiles(CartProductsResult state) {
    final List<Product> _products = [for(Map map in state.cartProductsFromDB) map['product']];
    final List<String> _cartProductsIds = [for(Map map in state.cartProductsFromDB) map['cartProductId']];
    print('pro: $_products');
    print('cpro: $_cartProductsIds');
    if (state.cartProductsFromDB.isNotEmpty) {
      return SingleChildScrollView(
        child: Column(
          children: [
            MEDIUM_VSPACING,
            ...List.generate(_products.length,
            (index) => CartProductTile(product: _products[index], index: index, cartProductId: _cartProductsIds[index])),
            MEDIUM_VSPACING,
          ],
        ),
      );
    } else if (_products.isEmpty) {
      return Column(
        children: [
          Spacer(),
          MyText(txt: "🙁", size: 40),
          TINY_VSPACING,
          MyText(
            txt: "You have no products added\nto your cart yet!",
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
    } else {
      return Text("Unknown Error");
    }
  }
}
