import 'package:animate_do/animate_do.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gooloads/src/blocs/database_bloc/database_bloc.dart';
import 'package:gooloads/src/models/cart_product_dart.dart';
import 'package:gooloads/src/providers/products_count_provider.dart';
import 'package:gooloads/src/services/authentication/auth_service.dart';
import 'package:gooloads/src/utils/actions_feedbacks/add_product_to_cart_feedback.dart';
import 'package:gooloads/src/utils/constants/constants.dart';
import 'package:gooloads/src/utils/constants/palette.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gooloads/src/utils/reuesed_widgets.dart';
import 'package:gooloads/src/utils/service_locator.dart';
import 'package:gooloads/src/view/global_widgets/custom_black_button.dart';
import 'package:gooloads/src/view/global_widgets/custom_container.dart';
import 'package:gooloads/src/view/global_widgets/custom_products_count_counter.dart';
import 'package:gooloads/src/view/global_widgets/custom_text.dart';
import 'package:gooloads/src/view/shimmer_widgets/item/add_product_to_cart_button_shimmer.dart';
import 'package:provider/provider.dart';
import 'package:uuid/uuid.dart' as uuid;

class AddProductToCartButton extends StatelessWidget {
  final String productId;
  const AddProductToCartButton({Key? key, required this.productId})
      : super(key: key);

  void addProductToCart(BuildContext context) {
    HapticFeedback.mediumImpact();
    final productsCountProvider = Provider.of<ProductsCountProvider>(context, listen: false);
    try {
      context.read<DatabaseBloc>().add(
            SaveProductToCartEvent(
              cartProduct: CartProduct(
                productId: this.productId,
                owner: serviceLocator<AuthService>().getUserCredentials()?.uid??'',
                productsCount: productsCountProvider.getProductsCount,
                cartProductId: uuid.Uuid().v1(),
                isAddedToCart: true,
              ),
            ),
          );
      AddProductToCartFeedBack.addProductToCartFeedBack(context);
      // Navigator.pushReplacementNamed(context, '/cart');
    } catch (error) {
      print(error);
    }
  }

  @override
  Widget build(BuildContext context) {
    // final productsCountProvider = context.read<ProductsCountProvider>();
    final _authUser = serviceLocator<AuthService>().getUserCredentials();
    return StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
      stream: FirebaseFirestore.instance.collection(KCartCollection)
      .where('owner', isEqualTo: _authUser?.uid).snapshots(),
      builder: (context, productsSnap){
        final _hasData = productsSnap.hasData ? productsSnap.data != null : false;
        if(_hasData){
          final _myCartProducts = [for(var doc in productsSnap.data!.docs) if(doc.exists) doc.data()['productId']];
          final bool _isProductAddedToCart = _myCartProducts.contains(productId);
          return MyContainer(
            withBorder: true,
            givenPadd: EdgeInsets.zero,
            givenClr: Palette.KKGreyShade03Clr,
            kiddo: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: KDefaultPadd),
                  child: MyProductsCountCounter(),
                ),
                MyContainer(
                  withShadow: false,
                  givenClr: Palette.KBlackClr,
                  givenMarg: EdgeInsets.zero,
                  givenPadd: EdgeInsets.zero,
                  kiddo: Material(
                    color: Palette.KTransparentClr,
                    child: InkWell(
                      borderRadius: BorderRadius.circular(KDefaultPadd),
                      onTap: () => !_isProductAddedToCart ? addProductToCart(context):
                      showDialog(context: context, builder: (context){
                        return ReusedWidgets.blurryBg(
                          widget: ElasticIn(
                            child: MyContainer(
                              givenMarg: const EdgeInsets.symmetric(horizontal: 20),
                              kiddo: Column(
                                mainAxisSize: MainAxisSize.min,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  MyText(txt: '🙁', size: 40),
                                  MyText(txt: 'This product is already added\nto your cart!\n\nCare for some more shopping?',
                                  alignment: TextAlign.center,
                                  clr: Palette.KBlackClr,),
                                  MEDIUM_VSPACING,
                                  Padding(
                                    padding: const EdgeInsets.symmetric(horizontal: 60.0),
                                    child: MyBlackButton(txt: 'Go shopping', onPressed: (){Navigator.pop(context);Navigator.pop(context);}),
                                  )
                                ],
                              )),
                          ));
                      }),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: KMediumPadd, vertical: KDefaultPadd),
                        child: SvgPicture.asset(KCartAddIco),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );
        }else {
          return AddProductToCartButtonShimmer();
        }
    });
  }
}
