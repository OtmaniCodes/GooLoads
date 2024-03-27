import 'package:animate_do/animate_do.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gooloads/src/blocs/database_bloc/database_bloc.dart';
import 'package:gooloads/src/models/card_product_model.dart';
import 'package:gooloads/src/models/cart_product_dart.dart';
import 'package:gooloads/src/services/authentication/auth_service.dart';
import 'package:gooloads/src/services/database/db_service.dart';
import 'package:gooloads/src/utils/actions_feedbacks/add_product_to_cart_feedback.dart';
import 'package:gooloads/src/utils/constants/constants.dart';
import 'package:gooloads/src/utils/constants/palette.dart';
import 'package:gooloads/src/utils/logger.dart';
import 'package:gooloads/src/utils/reuesed_widgets.dart';
import 'package:gooloads/src/utils/service_locator.dart';
import 'package:gooloads/src/view/global_widgets/custom_container.dart';
import 'package:provider/provider.dart';
import 'custom_corner_button.dart';
import 'custom_rating_stars.dart';
import 'custom_text.dart';
import 'package:uuid/uuid.dart' as uuid;


class MyProductCard extends StatefulWidget {
  final CardProductModel product;
  final bool isForFavourite;
   MyProductCard({
    Key? key,
    required this.product,
    this.isForFavourite = false,
  }) : super(key: key);

  @override
  State<MyProductCard> createState() => _MyProductCardState();
}

class _MyProductCardState extends State<MyProductCard> {
  bool addedOne = false;

  Future<void> _showPlusOneEffect() async {
    setState.call(() => addedOne = true);
    await Future.delayed(Duration(seconds: 1), (){setState.call(() => addedOne = false);});
  }

  @override
  Widget build(BuildContext context) {
    final _authUser = serviceLocator<AuthService>().getUserCredentials();
    return MyContainer(
      givenMarg: widget.isForFavourite ? EdgeInsets.zero : EdgeInsets.symmetric(horizontal: KDefaultPadd, vertical: 5.0),
      givenPadd: EdgeInsets.zero,
      kiddo: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Padding(padding: const EdgeInsets.only(left: KDefaultPadd, right: KDefaultPadd, top: KDefaultPadd),
            child: Column(
              children: [                
                Container(
                    margin: const EdgeInsets.all(KDefaultPadd),
                    height: 150,
                    width: double.infinity,
                    decoration: BoxDecoration(                     
                      borderRadius: BorderRadius.circular(KDefaultPadd),
                      border: Border.all(width: 1.0, color: Palette.KBlackClr),
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(KDefaultPadd),
                      child: CachedNetworkImage(imageUrl: this.widget.product.productMainImageUrl??'',
                      fit: BoxFit.fill,
                      placeholder: (context, url) => ReusedWidgets.shimmerLoading,
                      errorWidget: (context, url, error)=>ReusedWidgets.shimmerLoading,
                      ),
                    ),
                  ),
                Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    MyText(
                      maxLines: 2,
                      alignment: TextAlign.center,
                      isOverflow: true,
                      txt: this.widget.product.productTitle!,
                      clr: Palette.KBlackClr,
                      boldness: FontWeight.bold,
                    ),
                    SMALL_VSPACING,
                    MyRatingStars(
                      percentage: this.widget.product.evaluateRate != ''
                          ?  double.parse(this.widget.product.evaluateRate??'0')
                          : 0.0,
                    )
                  ],
                ),
              ],
            ),
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: MyText(txt: "\$"+this.widget.product.appSalePrice!, clr: Palette.KBlackClr),
              ),
              addedOne
              ? ElasticIn(child: Container(
                margin: EdgeInsets.only(right: 8.0, bottom: 8.0),
                child: Icon(Icons.plus_one, color: Palette.KWhiteClr),
                decoration: BoxDecoration(color: Palette.KBlackClr,
                shape: BoxShape.circle),
                height: 30, width: 30,
              ) )
              : MyCornerButton(
                  icon: widget.isForFavourite ? Icons.favorite_border :  Icons.add,
                  onPressed: widget.isForFavourite
                      ? () async {
                        HapticFeedback.mediumImpact();
                        try{
                        QuerySnapshot<Map<String, dynamic>> querySnap = await FirebaseFirestore.instance.collection(KUserCollection)
                          .doc(_authUser?.uid).collection(KFavouritesCollection)
                          .where('productId', isEqualTo: widget.product.productId).get();
                        print("DOCS: ${querySnap.docs.length}");
                        final String _favProductId = (querySnap.docs.isNotEmpty && querySnap.docs.length == 1) 
                          ? querySnap.docs.first.exists ? querySnap.docs.first.data()['favouriteProductId'] : '' : '';
                        print(_favProductId);
                        if(_favProductId.isNotEmpty) serviceLocator<DataBaseService>().deleteFavouriteProductFromDB(_favProductId);
                        else DevLogger.log('favourite product id is an empty string, therefore not deleted');
                        }catch(e){
                          print(e);
                        }
                      }
                      : () async {
                        HapticFeedback.mediumImpact();
                          Map<String, String> _productsCartProductIds = {};
                          QuerySnapshot<Map<String, dynamic>> querySnap = await FirebaseFirestore.instance.collection(KCartCollection)
                          .where('owner', isEqualTo: _authUser?.uid??'').get();
                          for(QueryDocumentSnapshot<Map<String, dynamic>> doc in querySnap.docs){
                            _productsCartProductIds.addAll({doc.data()['productId']: doc.data()['cartProductId']});
                          }
                          if(_productsCartProductIds.keys.toList().contains(widget.product.productId)){
                          final _cartProductId = _productsCartProductIds[widget.product.productId];
                          FirebaseFirestore.instance.collection(KCartCollection).doc(_cartProductId).get().then((cartProductSnap) {
                            if(cartProductSnap.exists){
                              int newProductsCount;
                              final _productsCount = cartProductSnap.data()!['productsCount'];
                              newProductsCount = _productsCount + 1;
                              FirebaseFirestore.instance.collection(KCartCollection).doc(_cartProductId).set({'productsCount' : newProductsCount}, SetOptions(merge: true));
                            }
                            _showPlusOneEffect();
                          });
                          }else{
                            CartProduct _newCartProduct = CartProduct(
                              cartProductId: uuid.Uuid().v1(),
                              isAddedToCart: true,
                              owner: _authUser?.uid??'',
                              productId: widget.product.productId??'',
                              productsCount: 1
                            );
                            context.read<DatabaseBloc>().add(SaveProductToCartEvent(cartProduct: _newCartProduct));
                            // serviceLocator<DataBaseService>().addCartProductToDB(_newCartProduct);
                            AddProductToCartFeedBack.addProductToCartFeedBack(context);
                          }
                        })
            
            ],
          )
        ],
      ),
    );
  }
}
