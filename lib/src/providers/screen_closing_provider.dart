import 'package:flutter/Material.dart';

class ScreenClosingProvider with ChangeNotifier {
  // the following code is responsible for closing and opening [MoreDetailsSection] in the [ItemScreen]
  bool _moreDetailsSectionClosed = true;

  bool get getMoreDetailsSectionClosed => _moreDetailsSectionClosed;

  toggleMoreDetailsSectionClosed() {
    _moreDetailsSectionClosed = !_moreDetailsSectionClosed;
    notifyListeners();
  }

 // the following code does the same as the one above but for [BestProductsList] in the [HomeScreen]
  bool _bestProductsListClosed = true;

  bool get getBestProductsListClosed => _bestProductsListClosed;

  toggleBestProductsListClosed() {
    _bestProductsListClosed = !_bestProductsListClosed;
    notifyListeners();
  }
}
