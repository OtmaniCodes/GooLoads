import 'package:flutter/material.dart';
import 'package:share/share.dart';
import 'package:gooloads/src/utils/constants/constants.dart';
import 'package:gooloads/src/utils/constants/palette.dart';
import 'package:gooloads/src/utils/reuesed_widgets.dart';
import 'package:gooloads/src/view/global_widgets/custom_text.dart';
import 'profile_picture_container.dart';

const List<String> optionsLabels = [
  "My Favourites",
  "My Cart",
  "Tell a friend",
  "Settings"
];
const List<IconData> optionsIcons = [
  Icons.favorite,
  Icons.shopping_cart,
  Icons.share,
  Icons.settings
];

class MyDrawer extends StatelessWidget {
  MyDrawer({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Container(
        color: Palette.KWhitishClr,
        child: Stack(
          children: [
            Align(alignment: Alignment.topCenter,
                child: getDrawerBackground(context)),
            Positioned(
              top: (ScreenCredentials.screenHeight(context) * 0.3) - 100,
              child: SafeArea(
                child: Column(
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: KDefaultPadd),
                          child: ProfilePictureContainer(),
                        ),
                        LARGE_VSPACING,
                        ...List.generate(
                          optionsIcons.length,
                          (index) => Container(
                            child: ReusedWidgets.materialEffect(
                              Container(
                                padding: const EdgeInsets.only(
                                    top: 15.0, bottom: 15.0, right: 500),
                                child: Row(children: [
                                  SMALL_HSPACING,
                                  Icon(optionsIcons[index]),
                                  SMALL_HSPACING,
                                  MyText(
                                    txt: optionsLabels[index],
                                    boldness: FontWeight.bold,
                                    clr: Palette.KBlackClr,
                                  ),
                                ]),
                              ),
                              onPress: index == 2
                                  ? () async {
                                      await Share.share(
                                          "this is a good app to download, it's called GooLoads",
                                          subject: "Download GooLoads");}
                                  : () {
                                      Navigator.pop(context);
                                      String navigatedRoute = '';
                                      switch (index) {
                                        case 0:
                                          navigatedRoute = '/favourite';
                                          break;
                                        case 1:
                                          navigatedRoute = '/cart';
                                          break;
                                        case 3:
                                          navigatedRoute = '/settings';
                                          break;
                                      }
                                      Navigator.pushNamed(
                                          context, navigatedRoute);
                                    },
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          
          ],
        ),
      ),
    );
  }

  Widget getDrawerBackground(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: ScreenCredentials.screenHeight(context) * 0.3,
      child: Stack(
        children: [
          Image.asset(KBestProductsBg),
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.bottomCenter,
                end: Alignment.topCenter,
                colors: [Palette.KWhitishClr, Palette.KTransparentClr],
                stops: [0.0, 1.0],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
