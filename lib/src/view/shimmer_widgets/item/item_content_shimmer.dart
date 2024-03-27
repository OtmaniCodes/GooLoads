import 'package:flutter/material.dart';
import 'package:gooloads/src/utils/constants/constants.dart';

import 'add_product_to_cart_button_shimmer.dart';
import 'categories_row_shimmer.dart';
import 'swipe_able_product_images_shimmer.dart';

class ItemContentShimmer extends StatelessWidget {
  const ItemContentShimmer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Column(
          children: [
            MEDIUM_VSPACING,
            SwipeableProductImagesShimmer(),
            MEDIUM_VSPACING,
            CategoriesRowShimmer(),
             Padding(
                        padding: const EdgeInsets.symmetric(horizontal: KDefaultPadd),
                        child: AddProductToCartButtonShimmer(),
                      ),
          ],
        )
      ],
    );
  }
}
