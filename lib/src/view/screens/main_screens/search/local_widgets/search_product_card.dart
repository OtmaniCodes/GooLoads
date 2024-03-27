import 'dart:ui';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:gooloads/src/models/card_product_model.dart';
import 'package:gooloads/src/utils/constants/constants.dart';
import 'package:gooloads/src/utils/constants/palette.dart';
import 'package:gooloads/src/utils/reuesed_widgets.dart';
import 'package:gooloads/src/view/global_widgets/custom_container.dart';
import 'package:gooloads/src/view/global_widgets/custom_rating_stars.dart';
import 'package:gooloads/src/view/global_widgets/custom_text.dart';

class SearchProductCard extends StatelessWidget {
  final CardProductModel product;
  const SearchProductCard({Key? key, required this.product}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MyContainer( 
      givenPadd: EdgeInsets.zero,
      kiddo: ClipRRect(
        borderRadius: BorderRadius.circular(KDefaultPadd),
        child: Stack(
          children: [
            CachedNetworkImage(imageUrl: product.productMainImageUrl??'',
            placeholder: (context, url) => ReusedWidgets.shimmerLoading,
            errorWidget: (context, url, error) => ReusedWidgets.shimmerLoading),            
            Positioned.fill(child: Container(padding: const EdgeInsets.all(KDefaultPadd),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.bottomCenter,
                    end: Alignment.topCenter,
                    colors: [
                      Palette.KKGreyShade01Clr,
                      Palette.KTransparentClr,
                      Palette.KWhiteClr
                    ],
                    stops: [0.0, 0.79, 1.0],
                  ),
                ),
               child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [MyRatingStars(percentage: double.parse(product.evaluateRate!.isNotEmpty? product.evaluateRate??"0.0" : "0.0" )),                        
                        MyText(txt: product.productTitle!.length > 30
                            ? product.productTitle!.substring(0, 30).trim() + "..."
                            : product.productTitle!, boldness:  FontWeight.w500)
                    ],
                  ),                 
                ),
              ),            
          ],
        ),
      ),
    );
  }
}
