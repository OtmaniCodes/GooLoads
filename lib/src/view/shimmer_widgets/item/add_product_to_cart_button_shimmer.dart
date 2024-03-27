import 'package:flutter/cupertino.dart';
import 'package:gooloads/src/utils/constants/constants.dart';
import 'package:gooloads/src/view/shimmer_widgets/shimmer_box.dart';

class AddProductToCartButtonShimmer extends StatelessWidget {
  const AddProductToCartButtonShimmer({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(KDefaultPadd),
      padding: const EdgeInsets.symmetric(
                        horizontal: KMediumPadd, vertical: KDefaultPadd),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(KDefaultPadd),
        child: ShimmerBox(height: 60, width: double.infinity,)),
      
    );
  }
}