import 'package:flutter/material.dart';
import 'package:gooloads/src/providers/products_count_provider.dart';
import 'package:gooloads/src/providers/screen_closing_provider.dart';
import 'package:provider/provider.dart';

class GlobalProvider extends StatelessWidget {
  final Widget app;
  const GlobalProvider({Key? key, required this.app}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => ProductsCountProvider(),
        ),
        ChangeNotifierProvider(
          create: (_) => ScreenClosingProvider(),
        )
      ],
      child: this.app,
    );
  }
}
