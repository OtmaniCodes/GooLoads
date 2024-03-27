import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gooloads/src/providers/products_count_provider.dart';
import 'package:gooloads/src/services/authentication/auth_service.dart';
import 'package:gooloads/src/utils/constants/constants.dart';
import 'package:gooloads/src/utils/service_locator.dart';
import 'package:provider/provider.dart';
import 'package:gooloads/src/utils/constants/palette.dart';
import 'package:gooloads/src/view/global_widgets/custom_text.dart';
import 'package:shimmer/shimmer.dart';

enum CounterAction { INCREMENT, DECREMENT }

class MyProductsCountCounter extends StatelessWidget {
  final bool fromCart;
  final String? cartProductId;

  MyProductsCountCounter({this.fromCart = false, this.cartProductId});

  @override
  Widget build(BuildContext context) {
    final productsCountProvider = Provider.of<ProductsCountProvider>(context);
    final _authUser = serviceLocator<AuthService>().getUserCredentials();
    Widget _retWidget(String count) {
      return Row(
        children: [
          _getActionButton(context, CounterAction.DECREMENT),
          SizedBox(width: 50, child: Center(child: MyText(clr: Palette.KBlackClr, txt: count)),
          ),
          _getActionButton(context, CounterAction.INCREMENT),
        ],
      );
    }
    return !fromCart 
    ? _retWidget(productsCountProvider.getProductsCount.toString())
    : StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
      stream: fromCart ? FirebaseFirestore.instance
        .collection(KCartCollection)
        .where('owner', isEqualTo: _authUser?.uid)
        .where('cartProductId', isEqualTo: cartProductId)
        .snapshots() : null,
      builder: (context, productCountSnap) {
        final _hasData = productCountSnap.hasData ? productCountSnap.data != null : false;
        if (_hasData) {
          final count = productCountSnap.data!.docs.first.exists ? 
            productCountSnap.data!.docs.first.data()['productsCount'].toString() : '';
          return _retWidget(count);
        } else {
          return Shimmer.fromColors(
              child: _retWidget(''),
              baseColor: Palette.KWhitishClr,
              highlightColor: Palette.KWhiteClr);
        }
      },
    );
  }

  Widget _getActionButton(BuildContext context, CounterAction counterAction) {
    final productsCountProvider = Provider.of<ProductsCountProvider>(context);
    return GestureDetector(
      onTap: () {
        HapticFeedback.mediumImpact();
        switch (counterAction) {
          case CounterAction.DECREMENT:
          if(!fromCart){
            if (productsCountProvider.getProductsCount <= 1) productsCountProvider.setProductsCount = 1;
            else productsCountProvider.setProductsCount = productsCountProvider.getProductsCount - 1;
          }else{
            FirebaseFirestore.instance.collection(KCartCollection).doc(cartProductId).get()
            .then((querySnap){
              if(querySnap.exists){
                int newProductsCount;
                final _productsCount = querySnap.data()!['productsCount'];
                if(_productsCount <= 1) newProductsCount = 1;
                else newProductsCount = _productsCount - 1;
                FirebaseFirestore.instance.collection(KCartCollection).doc(cartProductId)
                  .set({'productsCount': newProductsCount}, SetOptions(merge: true));
              }
            });
          }
          break;
          case CounterAction.INCREMENT:
            if(!fromCart){
              productsCountProvider.setProductsCount = productsCountProvider.getProductsCount + 1;
            }else{
              FirebaseFirestore.instance.collection(KCartCollection).doc(cartProductId).get()
              .then((querySnap){
                if(querySnap.exists){
                  int newProductsCount;
                  final _productsCount = querySnap.data()!['productsCount'];
                  newProductsCount = _productsCount + 1;
                  FirebaseFirestore.instance.collection(KCartCollection).doc(cartProductId).set({'productsCount': newProductsCount}, SetOptions(merge: true));
                }
              });
            }
            break;
          }
      },
      child: Container(
        alignment: Alignment.center,
        height: 25, width: 25,
        child: MyText(
          size: 15,
          clr: !(counterAction == CounterAction.DECREMENT)
              ? Palette.KWhiteClr
              : Palette.KBlackClr,
          txt: counterAction == CounterAction.DECREMENT ? "-" : "+",
        ),
        decoration: BoxDecoration(
          color: counterAction == CounterAction.DECREMENT
              ? Palette.KWhiteClr
              : Palette.KBlackClr,
          shape: BoxShape.circle,
          border: Border.all(color: Palette.KBlackClr),
        ),
      ),
    );
  }
}
