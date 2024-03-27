import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gooloads/src/models/cart_product_dart.dart';
import 'package:gooloads/src/services/authentication/auth_service.dart';
import 'package:gooloads/src/services/database/db_service.dart';
import 'package:gooloads/src/utils/constants/constants.dart';
import 'package:gooloads/src/utils/constants/palette.dart';
import 'package:gooloads/src/utils/service_locator.dart';
import 'package:gooloads/src/view/global_widgets/custom_text.dart';

class MyAppbarActionBtn extends StatelessWidget {
  final int? iconIndex;
  final IconData icon;
  final String? routeName;
  final VoidCallback? onPressed;
  final bool wrapForAppBarSizing;
  const MyAppbarActionBtn({
    Key? key,
    this.iconIndex,
    required this.icon,
    this.routeName,
    this.onPressed,
    this.wrapForAppBarSizing = false,
  }) : super(key: key);

  _wrappForAppBarSizing(Widget kid) {
    if (wrapForAppBarSizing)
      return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Stack(
          alignment: Alignment.bottomRight,
          children: [
            kid,
            iconIndex == 0 ? StreamBuilder<List<CartProduct>>(
              stream: serviceLocator<DataBaseService>().getCartProductsFromDB(),
              builder: (context,  productsSnap){
                final _hasData = productsSnap.hasData ? productsSnap.data != null : false;
                if(_hasData){
                  final _cartProductsCount = productsSnap.data!.length;
                  print(_cartProductsCount);
                  return _cartProductsCount > 0 ? Container(
                    alignment: Alignment.center,
                    child: MyText(txt: " $_cartProductsCount",
                    size: 8,
                    ),
                    height: 18,
                    width: 18,
                    decoration: BoxDecoration(color: Colors.red,
                    shape: BoxShape.circle
                    ),
                  ) : VoidSpacing;
                }else{
                  return VoidSpacing;
                }
            }) : VoidSpacing
          ],
        )],
      );
    else
      return kid;
  }

  @override
  Widget build(BuildContext context) {
    return _wrappForAppBarSizing(
      Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.elliptical(9999, 9999)),
          color: Palette.KWhiteClr,
          boxShadow: [
            BoxShadow(
              color: Palette.KShadowClr,
              offset: Offset(0, 3),
              blurRadius: 6,
            ),
          ],
        ),
        child: Material(
          color: Palette.KTransparentClr,
          child: InkWell(
            borderRadius: BorderRadius.all(Radius.elliptical(9999, 9999)),
            onTap: () {
              HapticFeedback.lightImpact();
              if (onPressed != null) this.onPressed!();
              if (routeName != null)
                Navigator.pushNamed(context, this.routeName!);
            },
            child: Container(
              padding: const EdgeInsets.all(KSmallPadd),
              alignment: Alignment.center,
              child: Icon(icon, color: Theme.of(context).accentColor),
            ),
          ),
        ),
      ),
    );
  }
}
