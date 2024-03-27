import 'package:flutter/material.dart';
import 'package:gooloads/src/utils/constants/constants.dart';
import 'package:gooloads/src/utils/constants/palette.dart';
import 'package:gooloads/src/utils/reuesed_widgets.dart';
import 'package:gooloads/src/view/global_widgets/custom_appbar_action_button.dart';
 
import 'package:gooloads/src/view/global_widgets/custom_text.dart';

class CartAppBar extends StatelessWidget {
  final void Function()? onNext;
  const CartAppBar({
    Key? key,
    this.onNext,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      leading: ReusedWidgets.popButton(context),
      elevation: 3,
      backgroundColor: Palette.KWhitishClr,
      centerTitle: true,
      actions: [
        MyAppbarActionBtn(
          icon: Icons.credit_card,
          onPressed: onNext,
          wrapForAppBarSizing: true,
        ),
        SMALL_HSPACING
      ],
      title: MyText(
        txt: "Cart",
        clr: Palette.KBlackClr,
        size: 24,
      ),
    );
  }
}
