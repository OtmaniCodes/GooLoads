import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:gooloads/src/models/product_model.dart';
import 'package:gooloads/src/services/database/db_service.dart';
import 'package:gooloads/src/utils/constants/constants.dart';
import 'package:gooloads/src/utils/constants/palette.dart';
import 'package:gooloads/src/utils/reuesed_widgets.dart';
import 'package:gooloads/src/utils/service_locator.dart';
import 'package:gooloads/src/view/global_widgets/custom_container.dart';
import 'package:gooloads/src/view/global_widgets/custom_products_count_counter.dart';
import 'package:gooloads/src/view/global_widgets/custom_rating_stars.dart';
import 'package:gooloads/src/view/global_widgets/custom_text.dart';
import 'package:readmore/readmore.dart';

class CartProductTile extends StatefulWidget {
  final Product product;
  final int? index;
  final String? cartProductId;
  const CartProductTile({Key? key, required this.product, this.index, this.cartProductId})
      : super(key: key);

  @override
  _CartProductTileState createState() => _CartProductTileState();
}

class _CartProductTileState extends State<CartProductTile> {

  Future<bool> _onConfirmDismiss(DismissDirection dismissDirection) async {
    bool shouldDelete = false;
    await showDialog(context: context,
      builder: (BuildContext context){
      return ReusedWidgets.blurryBg(
      widget: ElasticIn(
        child: MyContainer(
          givenMarg: EdgeInsets.symmetric(horizontal: KMediumPadd),
          kiddo: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
          MyText(
            clr: Palette.KBlackClr,
            isBold: true,
            txt: "Are you sure you want to remove this products from cart?"),
          MEDIUM_VSPACING,
          Row(children: [
             TextButton(
              style: ButtonStyle(backgroundColor: MaterialStateProperty.all(Palette.KBlackClr.withOpacity(0.3))),
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text("No", style: TextStyle(color: Palette.KBlackClr),),
            ),
            Spacer(),
            TextButton(
              style: ButtonStyle(backgroundColor: MaterialStateProperty.all(Palette.KBlackClr.withOpacity(0.3))),
              onPressed: () {
                shouldDelete = true;
                Navigator.pop(context);
              },
              child: Text("Yes", style: TextStyle(color: Colors.red),),
            )
          ],)
        ],)),
      )
    );
    });

    return Future.value(shouldDelete);
  }

  Future<void> _onDismissed(DismissDirection dismissDirection) async {
   await serviceLocator<DataBaseService>().deleteCartProductFromDB(widget.cartProductId??'');
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: KMediumPadd, vertical: KDefaultPadd),
      child: Dismissible(
        key: UniqueKey(), // Key(widget.product.productId ?? ''),
        direction: DismissDirection.startToEnd,
        confirmDismiss: (dismissDirection) => _onConfirmDismiss(dismissDirection),
        onDismissed: (dismissDirection) => _onDismissed(dismissDirection),
        background: MyContainer(
          givenMarg: EdgeInsets.zero,
          givenPadd: EdgeInsets.zero,
          kiddo: Align(alignment: Alignment.centerLeft,
            child: ListTile(
              leading: Icon(Icons.delete),
              title: MyText(
                txt: "Delete",
                clr: Palette.KBlackClr,
              ),
            ),
          ),
          givenClr: Colors.red,
        ),
        child: MyContainer(
          givenMarg: EdgeInsets.zero,
          kiddo: Column(
            children: [
              ListTile(
                contentPadding: EdgeInsets.zero,
                leading: MyContainer(
                  givenMarg: EdgeInsets.zero,
                  givenPadd: EdgeInsets.zero,
                  kiddo: Container(
                    width: 100,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(KDefaultPadd),
                      image: DecorationImage(
                          fit: BoxFit.fill,
                          image: NetworkImage(widget.product.productMainImageUrl!))),
                  ),
                ),
                title: ReadMoreText(
                  (widget.product.productTitle ?? ''),
                  trimLines: 2,
                  trimMode: TrimMode.Line,
                  trimCollapsedText: ' show more',
                  trimExpandedText: ' show less',
                  lessStyle: TextStyle(color: Colors.blueAccent),
                  moreStyle: TextStyle(color: Colors.blueAccent),
                  style: TextStyle(
                      color: Palette.KBlackClr,
                      fontSize: 14,
                      fontWeight: FontWeight.bold),
                ),
                subtitle: Padding(
                  padding: const EdgeInsets.only(top: KSmallPadd),
                  child: MyText(
                    clr: Palette.KKGreyShade02Clr,
                    txt: "\$ " + widget.product.salePrice!,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: KSmallPadd),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    MyRatingStars(percentage: 100),
                    MyProductsCountCounter(fromCart: true, cartProductId: widget.cartProductId)
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
