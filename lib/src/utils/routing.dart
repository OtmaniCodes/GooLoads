import 'package:gooloads/src/view/screens/screens.dart';
import 'package:flutter/material.dart';

import 'constants/constants.dart';

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    final routeName = settings.name;
    final routeArgs = settings.arguments;
    late Widget screen;

    switch (routeName) {
      case "/":
        screen = OnBoarding();
        break;
      case KRootRoute:
        screen = RootScreen();
        break;
      case KCreateAccountRoute:
        screen = CreateAccountScreen();
        break;
      case KHomeRoute:
        screen = HomeScreen();
        break;
      case KItemRoute:
        String args = routeArgs as String;
        screen = ItemScreen(productId: int.parse(args));
        break;
      case KSearchRoute:
        screen = SearchScreen();
        break;
      case KFavouriteRoute:
        screen = FavouriteScreen();
        break;
      case KCartRoute:
        screen = CartScreen();
        break;
      case KSettingsRoute:
        screen = SettingsScreen();
        break;
      default:
        screen = ErrorScreen();
    }
    return PageRouteBuilder<void>(
      transitionDuration: Duration(milliseconds: 400),
      pageBuilder: (context, animation, secondaryAnimation) {
        return screen;
      },
      settings: RouteSettings(name: routeName, arguments: routeArgs),
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        return screen; // FadeTransition(opacity: animation, child: child);
      },
    );
  }
}

class ErrorScreen extends StatelessWidget {
  const ErrorScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          child: Text("no such screen is available".toUpperCase()),
        ),
      ),
    );
  }
}
