import 'package:flutter/material.dart';
import 'package:gooloads/src/blocs/theme_bloc/theme_bloc.dart';
import 'package:gooloads/src/global_bloc_provider.dart';
import 'package:gooloads/src/global_provider.dart';
import 'package:gooloads/src/utils/constants/constants.dart';
import 'package:gooloads/src/utils/routing.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GlobalBlocProvider(
      app: Builder(
        builder: (BuildContext context) {
          final themeState = context.watch<ThemeBloc>().state;
          return GlobalProvider(
            app: MaterialApp(
              debugShowCheckedModeBanner: false,
              title: KAppTitle,
              theme: (themeState is ThemeSettingState) ? themeState.theme : null,
              onGenerateRoute: RouteGenerator.generateRoute,
              initialRoute: "/",
              // home: HomeScreen(),
            ),
          );
        },
      ),
    );
  }
}
