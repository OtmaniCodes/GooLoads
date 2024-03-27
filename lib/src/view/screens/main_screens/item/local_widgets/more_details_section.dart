import 'package:flutter/material.dart';
import 'package:gooloads/src/models/best_product_module.dart';
import 'package:gooloads/src/models/product_model.dart';
import 'package:gooloads/src/providers/screen_closing_provider.dart';
import 'package:gooloads/src/utils/constants/constants.dart';
import 'package:gooloads/src/utils/constants/palette.dart';
import 'package:gooloads/src/view/global_widgets/custom_container.dart';
import 'package:gooloads/src/view/global_widgets/custom_text.dart';
import 'package:gooloads/src/view/screens/main_screens/home/local_widgets/best_product_list_tile.dart';
import 'package:provider/provider.dart';
import 'package:animate_do/animate_do.dart' as animatedo;


class MoreDetailsSection extends StatelessWidget {
  final Product product;
  const MoreDetailsSection({Key? key, required this.product}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final screenClosingProvider = Provider.of<ScreenClosingProvider>(context);
    return WillPopScope(
      onWillPop: () {
        if (screenClosingProvider.getMoreDetailsSectionClosed == false) {
          screenClosingProvider.toggleMoreDetailsSectionClosed();
          return Future.value(false);
        }
        return Future.value(true);
      },
      child: AnimatedContainer(
          duration: Duration(milliseconds: 450),
          curve: Curves.easeOut,
          width: double.infinity,
          height: ScreenCredentials.screenHeight(context) * (!screenClosingProvider.getMoreDetailsSectionClosed ? 1.0 : 0.08),
          decoration: BoxDecoration(
            color: !screenClosingProvider.getMoreDetailsSectionClosed
                ? Palette.KWhitishClr
                : Palette.KWhiteClr,
            borderRadius: screenClosingProvider.getMoreDetailsSectionClosed
                ? BorderRadius.only(
                    topLeft: Radius.circular(KAveragePadd),
                    topRight: Radius.circular(KAveragePadd),
                  ) : null,
            boxShadow: screenClosingProvider.getMoreDetailsSectionClosed
                ? [
                    BoxShadow(
                      color: Palette.KShadowClr,
                      offset: Offset(0, -3),
                      blurRadius: 6,
                    ),
                  ] : null,
          ),
          child: !screenClosingProvider.getMoreDetailsSectionClosed
              ? Column(children: [
                    animatedo.FadeInUp(
                      delay: Duration(milliseconds: 300),
                      duration: Duration(milliseconds: 200),
                      child: Padding(
                        padding: const EdgeInsets.only(top: KMediumPadd),
                        child: BestProductListTile(
                          product: BestProduct(
                          evaluateRate: product.evaluateRate?.replaceAll("%", '')??'0.0' ,
                          productMainImageUrl: product.productMainImageUrl,
                          productTitle: product.productTitle,
                          salePrice: product.salePrice,
                        )),
                      ),
                    ),
                    Spacer(),
                    Container(
                      height: ScreenCredentials.screenHeight(context) * 0.6,
                      child: ListView(
                        children: [
                          SMALL_VSPACING,
                          Padding(padding: const EdgeInsets.symmetric(horizontal: KDefaultPadd),
                            child: _getDescriptionSection(),
                          ),
                          MEDIUM_VSPACING,
                          Padding(padding: const EdgeInsets.symmetric(horizontal: KDefaultPadd),
                            child: _getReviewsSection(),
                          ),
                          MEDIUM_VSPACING,
                        ],
                      ),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(20.0),
                          topRight: Radius.circular(20.0),
                        ),
                        color: Palette.KWhiteClr,
                        border: Border.all(
                          width: 1.0,
                          color: Palette.KKGreyShade02Clr,
                        ),
                      ),
                    ),
                  ],
                )
              : openMoreDetailsSectionButton(screenClosingProvider)),
    );
  }

  Widget openMoreDetailsSectionButton(
      ScreenClosingProvider screenClosingProvider) {
    return TweenAnimationBuilder(
      tween: Tween<double>(begin: 0.0, end: 1.0),
      duration: Duration(milliseconds: 500),
      builder: (_, double val, __) {
        return GestureDetector(
          onTap: () {
            screenClosingProvider.toggleMoreDetailsSectionClosed();
          },
          child: Center(
            child: Opacity(
              opacity: 1.0 * val,
              child: MyContainer(
                givenPadd: const EdgeInsets.symmetric(
                    vertical: KDefaultPadd, horizontal: KAveragePadd),
                givenClr: Palette.KBlackClr,
                kiddo: MyText(
                  txt: "tap to see more details".toUpperCase(),
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _getDescriptionSection() {
    return Column(crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        MyText(txt: "Description:",
          clr: Palette.KBlackClr,
          isBold: true,
          size: 28),
        SMALL_VSPACING,
        MyText(txt: product.productDescription?.replaceAll("√", '\n') ?? "There is no description available.",
        clr: Palette.KBlackClr),
      ],
    );
  }

  Widget _getReviewsSection() {
    return Column(crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text.rich(
          TextSpan(
            children: [
              TextSpan(
                text: "Reviews",
                style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    color: Palette.KBlackClr),
              ),
              TextSpan(text: " (30)"),
              TextSpan(
                text: ":",
                style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    color: Palette.KBlackClr),
              ),
            ],
            style: TextStyle(fontSize: 24, color: Palette.KKGreyShade02Clr),
          ),
        ),
        SMALL_VSPACING,
        MyText(
            clr: Palette.KBlackClr,
            txt:
                "Lorem ipsum dolor sit amet, consetetur sggwegregegregergergadipscingsggwegregegregergergadipscingsggwegregegregergergadipscingsggwegregegregergergadipscingsggwegregegregergergadipscingsggwegregegregergergadipscing elitr, sed diam nonumy eirmod tempor invidunt ut labore et dolore magna aliquyam erat, sed diam voluptua. At vero eos et accusam et justo duo dolores et ea rebum. Stet clita kasd gubergren, no sea "),
      ],
    );
  }
}
