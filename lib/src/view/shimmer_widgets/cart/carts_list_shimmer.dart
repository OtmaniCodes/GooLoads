import 'package:flutter/material.dart';
import 'package:gooloads/src/utils/constants/constants.dart';
import 'package:gooloads/src/utils/reuesed_widgets.dart';
import 'package:gooloads/src/view/shimmer_widgets/shimmer_box.dart';

class CartProductsListShimmer extends StatelessWidget {
  const CartProductsListShimmer({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: NeverScrollableScrollPhysics(),
      child: Column(
        children: 
        <Widget>[MEDIUM_VSPACING] +
        List.generate(10, (index) => Padding(
          padding: const EdgeInsets.symmetric(horizontal: KMediumPadd, vertical: KDefaultPadd),
          child: ClipRRect(
            borderRadius: ReusedWidgets.defaultBorRadCir,
            child: ShimmerBox.withHeight(120)),
        ))
      ),
    );
  }
}