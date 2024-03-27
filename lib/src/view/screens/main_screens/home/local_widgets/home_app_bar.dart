import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gooloads/src/blocs/api_bloc/search_products_bloc/search_products_bloc.dart';
// import 'package:gooloads/src/blocs/api_bloc/api_bloc.dart';
import 'package:gooloads/src/blocs/authentication_bloc/authentication_bloc.dart';
import 'package:gooloads/src/providers/screen_closing_provider.dart';
import 'package:gooloads/src/utils/constants/constants.dart';
import 'package:gooloads/src/view/global_widgets/custom_appbar_action_button.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:animate_do/animate_do.dart' as animatedo;

const List<String> routeNames = [KCartRoute, KFavouriteRoute, KSearchRoute];
const List<IconData> icons = [Icons.shopping_cart, Icons.favorite, Icons.search];

class HomeAppBar extends StatelessWidget {
  HomeAppBar({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final screenClosingProvider = Provider.of<ScreenClosingProvider>(context);
    return AppBar(
      leadingWidth: screenClosingProvider.getBestProductsListClosed ? 200 : 56.0,
      leading: screenClosingProvider.getBestProductsListClosed
        ? Padding(padding: const EdgeInsets.only(left: KDefaultPadd), child: Image.asset(KAppLogo))
        : animatedo.ElasticIn(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: KSmallPadd, vertical: KSmallPadd),
            child: MyAppbarActionBtn(icon: Icons.close, onPressed: () => screenClosingProvider.toggleBestProductsListClosed()),
          ),
        ),  
      actions: screenClosingProvider.getBestProductsListClosed
          ? [...List.generate(icons.length,
                (index) => Padding(
                  padding: const EdgeInsets.symmetric(horizontal: KSmallPadd),
                  child: MyAppbarActionBtn(
                    iconIndex: index,
                    icon: icons[index],
                    routeName: routeNames[index],
                    wrapForAppBarSizing: true,
                    onPressed: index == 2
                        ? () => context.read<SearchProductsBloc>().add(GetSearchProductsEvent())
                        : null,
                  ),
                ),
              ),
              GestureDetector(
                onTap: () {
                  HapticFeedback.heavyImpact();
                  context.read<AuthenticationBloc>().add(RequestUserCredentialsEvent());
                  Scaffold.of(context).openDrawer();
                },
                child: Padding(padding: const EdgeInsets.symmetric(horizontal: KSmallPadd),
                  child: SvgPicture.asset(KMenuIco),
                ),
              )
            ]
          : null,
    );
  }
}
