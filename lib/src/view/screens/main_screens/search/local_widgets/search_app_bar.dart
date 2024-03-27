import 'package:flutter/material.dart';
import 'package:gooloads/src/utils/constants/constants.dart';
import 'package:gooloads/src/utils/constants/palette.dart';
import 'package:gooloads/src/view/global_widgets/custom_text.dart';
import 'package:gooloads/src/view/screens/main_screens/search/local_widgets/search_bar.dart';
import 'package:gooloads/src/view/screens/main_screens/search/local_widgets/search_filter_button.dart';


class SearchAppBar extends StatelessWidget {
  const SearchAppBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(      
      flexibleSpace: LayoutBuilder(builder: (context, constrains) {
        final double top = constrains.biggest.height;
        return FlexibleSpaceBar(
          centerTitle: true,
          titlePadding: EdgeInsets.zero,
          title: AnimatedOpacity(
            opacity: top >= 100 ? 0.0 : 1.0,
            duration: Duration(milliseconds: 200),
            curve: Curves.easeIn,
            child: SafeArea(
              child: Stack(
                children: [
                  Align(
                    alignment: Alignment.centerLeft,
                    child: top <= 100 ? IconButton(
                      icon: Icon(Icons.arrow_back_ios),
                      onPressed: () => Navigator.pop(context),
                    ) : VoidSpacing,
                  ),
                  Align(
                    child: MyText(
                      txt: "Search",
                      clr: Palette.KBlackClr,
                      size: 24,
                    ),
                  ),
                ],
              ),
            ),
          ),
          background: SafeArea(
            child: Container(
              color: Palette.KWhitishClr,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [Expanded(child: SearchBar()), SearchFilterButton()],
              ),
            ),
          ),
        );
      }),
      pinned: true,
      expandedHeight: 100,
      centerTitle: true,
      backgroundColor: Colors.white.withOpacity(0.9),
      // elevation: 3.0,
      leading: VoidSpacing,
    );
  }
}
