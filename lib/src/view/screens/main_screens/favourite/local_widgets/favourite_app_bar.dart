import 'package:flutter/material.dart';
import 'package:gooloads/src/utils/constants/palette.dart';
import 'package:gooloads/src/utils/reuesed_widgets.dart';
 
import 'package:gooloads/src/view/global_widgets/custom_text.dart';

class FavouriteAppBar extends StatelessWidget {
  const FavouriteAppBar({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      leading: ReusedWidgets.popButton(context),
      elevation: 3,
      backgroundColor: Palette.KWhitishClr,
      centerTitle: true,
      title: MyText(
        txt: "Favourites",
        clr: Palette.KBlackClr,
        size: 24,
      ),
    );
  }
}
