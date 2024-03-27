import 'package:animate_do/animate_do.dart' as animatedo;
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:gooloads/src/blocs/api_bloc/best_products_bloc/best_products_bloc.dart';
// import 'package:gooloads/src/blocs/api_bloc/api_bloc.dart';
import 'package:gooloads/src/providers/screen_closing_provider.dart';
import 'package:gooloads/src/utils/constants/constants.dart';
import 'package:gooloads/src/utils/constants/palette.dart';
import 'package:gooloads/src/view/global_widgets/custom_container.dart';
import 'package:gooloads/src/view/global_widgets/custom_text.dart';
import 'package:gooloads/src/view/screens/main_screens/home/local_widgets/collapsed_best_products_list.dart';
import 'package:provider/provider.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'dart:math' as math;
import 'package:glitters/glitters.dart';

class BestProductsList extends StatelessWidget {
  const BestProductsList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final screenClosingProvider = Provider.of<ScreenClosingProvider>(context);
    return WillPopScope(
      onWillPop: () {
        if (!screenClosingProvider.getBestProductsListClosed) {
          screenClosingProvider.toggleBestProductsListClosed();
          return Future.value(false);
        }
        return Future.value(true);
      },
      child: AnimatedContainer(
        duration: Duration(milliseconds: 450),
        curve: Curves.easeOut,
        width: double.infinity,
        height: ScreenCredentials.screenHeight(context) * (!screenClosingProvider.getBestProductsListClosed ? 1.0 : 0.30),
        decoration: BoxDecoration(
          color: Palette.KWhiteClr,
          image: DecorationImage(fit: BoxFit.cover, image: AssetImage(KShopeBg)),
          borderRadius: screenClosingProvider.getBestProductsListClosed
              ? BorderRadius.only(
                  topLeft: Radius.circular(20.0),
                  topRight: Radius.circular(20.0),
                )
              : null,
          boxShadow: screenClosingProvider.getBestProductsListClosed
              ? [BoxShadow(color: Palette.KShadowClr,
                    offset: Offset(0, -3),
                    blurRadius: 6)] : null,
        ),
        child: Stack(
          children: [
            Positioned.fill(
              child: DecoratedBox(
                decoration: BoxDecoration(
                  color: !screenClosingProvider.getBestProductsListClosed? Palette.KWhiteClr.withOpacity(0.9):Palette.KTransparentClr,
                  borderRadius: screenClosingProvider.getBestProductsListClosed ? BorderRadius.only(
                      topLeft: Radius.circular(20.0),
                      topRight: Radius.circular(20.0))
                  : null,
                ),
              ),
            ),
            !screenClosingProvider.getBestProductsListClosed
            ? CollapsedBestProductsList()
            : Align(alignment: Alignment(-0.8, 0.5),
              child: onBestProductsListClosed(context, screenClosingProvider))
          ],
        ),
      ),
    );
  }

  Widget onBestProductsListClosed(BuildContext context, ScreenClosingProvider screenClosingProvider) {
    return animatedo.FadeInDown(
      duration: Duration(milliseconds: 400),
      child: GestureDetector(
        onTap: () {
          screenClosingProvider.toggleBestProductsListClosed();
          context.read<BestProductsBloc>().add(GetBestProductsEvent());
        },
        child: animatedo.Swing(
          duration: Duration(milliseconds: 3000),
          infinite: true,
          child: Transform.rotate(angle: -math.pi / 6 ,
            child: MyContainer(
              givenMarg: EdgeInsets.zero,
              givenPadd: EdgeInsets.zero,
              kiddo: SizedBox(
                height: 40,
                width: 180,                      
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    // ...[
                    //   for(int i = 1; i < 3; i++) Glitters(                      
                    //     duration: Duration(milliseconds: 100 * i),
                    //     interval: Duration.zero,
                    //     delay: Duration(milliseconds: (100/i).round()),
                    //     color: Colors.black, //(0xFFFFD700),
                    //     maxOpacity: 0.6,
                    //     )
                    // ],                     
                    MyText(
                      txt: "see best products".toUpperCase(),
                      isBold: true,
                      size: 15.0,
                      clr: Palette.KBlackClr,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
