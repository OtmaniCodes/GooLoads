import 'package:flutter/material.dart';
import 'package:gooloads/src/utils/constants/constants.dart';
import 'package:gooloads/src/view/global_widgets/drawer/custom_drawer.dart';
import 'package:gooloads/src/view/screens/main_screens/home/local_widgets/home_app_bar.dart';
import 'package:gooloads/src/view/screens/main_screens/home/local_widgets/products_carousel.dart';
import 'local_widgets/best_products_list.dart';


class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      drawer: MyDrawer(),
      drawerEnableOpenDragGesture: false,
      appBar: PreferredSize( preferredSize: Size.fromHeight(56), child: HomeAppBar()),
      body: Stack(
        children: [
          SafeArea(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                MEDIUM_VSPACING,
                ProductsCarousel(),
              ],
            ),
          ),
          Align(alignment: Alignment.bottomCenter,
          child: BestProductsList()
          )
        ],
      ),
    );
  }
}
