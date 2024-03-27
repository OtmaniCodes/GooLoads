import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:gooloads/src/models/best_product_module.dart';
import 'package:gooloads/src/utils/constants/constants.dart';
import 'package:gooloads/src/utils/constants/palette.dart';
import 'package:gooloads/src/utils/reuesed_widgets.dart';
import 'package:gooloads/src/view/global_widgets/custom_container.dart';
import 'package:gooloads/src/view/global_widgets/custom_rating_stars.dart';
import 'package:gooloads/src/view/global_widgets/custom_text.dart';

class BestProductListTile extends StatelessWidget {
  final BestProduct product;

  const BestProductListTile({Key? key, required this.product})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: KDefaultPadd),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Container(
            child: ClipRRect(
              borderRadius: BorderRadius.circular(KDefaultPadd),
              child: CachedNetworkImage(
                fit: BoxFit.fill,
                imageUrl: product.productMainImageUrl ?? '',
                placeholder: (context, url) => ReusedWidgets.shimmerLoading,
                errorWidget: (context, url, error) => ReusedWidgets.shimmerLoading,
              ),
            ),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(KDefaultPadd),
              border: Border.all(width: 1.0, color: Palette.KBlackClr),
            ),
            height: 150,
            width: 150,
          ),
          SMALL_HSPACING,
          Expanded(
            child: Container(
              // color: Colors.red,
              height: 150,
              child: Column(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Align(
                    alignment: Alignment.topLeft,
                    child: Text(
                      product.productTitle!,
                      style: TextStyle(
                          fontSize: 18,
                          color: Palette.KBlackClr,
                          fontWeight: FontWeight.bold),
                      maxLines: 4,
                      overflow: TextOverflow.ellipsis,
                      textAlign: TextAlign.start,
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      MyText(
                        txt: "\$ " + product.salePrice!,
                        clr: Palette.KKGreyShade01Clr,
                      ),
                      MyRatingStars(
                        percentage: double.parse(product.evaluateRate!),
                      ),
                    ],
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
