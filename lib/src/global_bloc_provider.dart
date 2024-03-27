import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gooloads/src/blocs/authentication_bloc/authentication_bloc.dart';
import 'package:gooloads/src/blocs/database_bloc/database_bloc.dart';
import 'package:gooloads/src/blocs/image_picker_bloc/image_picker_bloc.dart';
import 'package:gooloads/src/blocs/theme_bloc/theme_bloc.dart';
import 'package:gooloads/src/blocs/user_state_bloc/user_state_bloc.dart';
import 'package:gooloads/src/services/authentication/auth_service.dart';
import 'package:gooloads/src/utils/prefrences.dart';
import 'package:gooloads/src/utils/service_locator.dart';

import 'blocs/api_bloc/best_products_bloc/best_products_bloc.dart';
import 'blocs/api_bloc/categories_bloc/categories_bloc.dart';
import 'blocs/api_bloc/product_by_category_id_bloc/product_by_category_id_bloc.dart';
import 'blocs/api_bloc/product_by_id_bloc/product_by_id_bloc.dart';
import 'blocs/api_bloc/search_products_bloc/search_products_bloc.dart';
import 'blocs/connectivity_bloc/connectivity_bloc.dart';

class GlobalBlocProvider extends StatelessWidget {
  final Widget app;
  const GlobalBlocProvider({Key? key, required this.app}) : super(key: key);
  
  void _appInitialization(BuildContext context) {
    serviceLocator<AppPrefrences>().checkIfFirstLaunch();
    serviceLocator<AuthService>().checkUserAuthState(context);
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        // theme
        BlocProvider<ThemeBloc>(create: (context) => ThemeBloc()..add(GetSavedThemeEvent())),
        // internet connectivity
        BlocProvider<ConnectivityBloc>(create: (context) => ConnectivityBloc()..add(CheckConnectivityEvent())),
        // database
        BlocProvider<DatabaseBloc>(create: (context) => DatabaseBloc()),
        // authentication
        BlocProvider<AuthenticationBloc>(create: (context) => AuthenticationBloc()),
        BlocProvider<UserStateBloc>(create: (context) => UserStateBloc()),
        // api
        BlocProvider<BestProductsBloc>(create: (context) => BestProductsBloc()),
        BlocProvider<CategoriesBloc>(create: (context) => CategoriesBloc()),
        BlocProvider<ProductByCategoryIdBloc>(create: (context) => ProductByCategoryIdBloc()),
        BlocProvider<ProductByIdBloc>(create: (context) => ProductByIdBloc()), 
        BlocProvider<SearchProductsBloc>(create: (context) => SearchProductsBloc()), 
        // other
        BlocProvider<ImagePickerBloc>(create: (context) => ImagePickerBloc()),
      ],
      child: Builder(
        builder: (BuildContext context) {
          _appInitialization(context);
          return app;
        },
      ),
    );
  }
}
