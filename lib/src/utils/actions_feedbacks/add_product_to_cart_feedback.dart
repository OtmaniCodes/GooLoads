import 'dart:ui';

import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:gooloads/src/blocs/database_bloc/database_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gooloads/src/utils/constants/constants.dart';
import 'package:gooloads/src/utils/constants/palette.dart';
import 'package:gooloads/src/view/global_widgets/custom_container.dart';
import 'package:gooloads/src/view/global_widgets/custom_text.dart';

class AddProductToCartFeedBack {
  static addProductToCartFeedBack(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => BlocBuilder<DatabaseBloc, DatabaseState>(
        builder: (context, state) {
           print(
        '========================== FEEDBACK $state ===============================');
          if (state is SaveProductToCartResult) {
            if (state.productIsAddedSuccessfuly) {
              return _getFeedbackContent(
                  "Product is successfuly added!", 0, context);
            } else {
              return _getFeedbackContent(
                  "Product is not added successfuly!", 1, context);
            }
          } else if (state is DatabaseError) {
            return _getFeedbackContent("Something went wrong!", 2, context);
          } else {
            return _getFeedbackContent(
                "Adding your product to cart...", 3, context);
          }
        },
      ),
    );
  }

  static Widget _getFeedbackContent(String txt, int iconIndex, BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.pop(context),
      child: Container(
        color: Palette.KWhiteClr.withOpacity(0.4),
        alignment: Alignment.center,
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
          child: IgnorePointer(
            child: ElasticIn(
              child: MyContainer(
                withShadow: false,
                kiddo: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      [
                        Icons.celebration,
                        Icons.error,
                        Icons.error,
                        Icons.loop
                      ][iconIndex],
                      color: Palette.KBlackClr,
                      size: 60,
                    ),
                    MEDIUM_VSPACING,
                    MyText(
                      txt: txt,
                      size: 22,
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
