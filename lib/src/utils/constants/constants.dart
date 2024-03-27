import 'package:flutter/cupertino.dart';
import 'package:gooloads/src/utils/constants/palette.dart';

// general
const String KAppTitle = "GooLoads";
const String KFontFam = "Rubik";

// API
const String KApiKey =  "4bed07a6dfmsh3e2a208c77b66dcp1fcdb3jsnecd6e1a00f1f";
const String KApiHost = "magic-aliexpress1.p.rapidapi.com";
const String KApiScheme = "https";
const int KSuccessGetCode = 200;
const int KInitialProductId = 100000039;

// DB
const String KCartCollection = "cart";
const String KUserCollection = "user";
const String KFavouritesCollection = "favourites";

// Images
const String KSignInBg = "assets/images/login_bg.jpg";
const String KBestProductsBg = "assets/images/best_products.png";
const String KShopeBg = "assets/images/shope.jpg";

//PNG Icons:
const String KAppLogo = "assets/icons/png/logo.png";
//SVG Icons:
const String KNoInternetIco = "assets/icons/svg/no_internet.svg";
const String KMenuIco = "assets/icons/svg/menu.svg";
const String KStar20Ico = "assets/icons/svg/star_20.svg";
const String KStar15Ico = "assets/icons/svg/star_15.svg";
const String KStar10Ico = "assets/icons/svg/star_10.svg";
const String KStar05Ico = "assets/icons/svg/star_5.svg";
const String KStarEmpty = "assets/icons/svg/star_empty.svg";
const String KSearchIco = "assets/icons/svg/search.svg";
const String KFilterIco = "assets/icons/svg/filter.svg";
const String KCartAddIco = "assets/icons/svg/cart_add.svg";

// Text Styles
const TextStyle defaultTS = TextStyle(
  fontSize: 18.0,
  color: Palette.KWhiteClr,
);

// Spacings
//vertical
const LARGE_VSPACING = const SizedBox(height: 60);
const MEDIUM_VSPACING = const SizedBox(height: 30);
const AVERAGE_VSPACING = const SizedBox(height: 20);
const SMALL_VSPACING = const SizedBox(height: 10);
const TINY_VSPACING = const SizedBox(height: 5);
//horizontal
const LARGE_HSPACING = const SizedBox(width: 60);
const MEDIUM_HSPACING = const SizedBox(width: 30);
const AVERAGE_HSPACING = const SizedBox(width: 20);
const SMALL_HSPACING = const SizedBox(width: 10);
const TINY_HSPACING = const SizedBox(width: 5);
const VoidSpacing = const SizedBox.shrink();

// Paddings
const double KMediumPadd = 30.0;
const double KAveragePadd = 20.0;
const double KDefaultPadd = 10.0;
const double KSmallPadd = 8.0;

class ScreenCredentials {
  static double screenWidth(BuildContext context) =>
      MediaQuery.of(context).size.width;
  static double screenHeight(BuildContext context) =>
      MediaQuery.of(context).size.height;
  static bool isKeyBoardOn(BuildContext context) =>
      MediaQuery.of(context).viewInsets.bottom > 0;
}

// prefrences keys
const String KFirstLaunchKey = "firstLaunchKey";
const String KThemeIDKey = "themeIDKey";


// routes
const String KRootRoute = '/root';
const String KHomeRoute = '/home';
const String KCreateAccountRoute = '/createaccount';
const String KItemRoute = '/item';
const String KSearchRoute = '/search';
const String KFavouriteRoute = '/favourite';
const String KCartRoute = '/cart';
const String KSettingsRoute = '/settings';