import 'package:flutter/material.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:gooloads/src/blocs/api_bloc/product_by_category_id_bloc/product_by_category_id_bloc.dart';
import 'package:gooloads/src/blocs/authentication_bloc/authentication_bloc.dart';
import 'package:gooloads/src/blocs/connectivity_bloc/connectivity_bloc.dart';
import 'package:gooloads/src/blocs/user_state_bloc/user_state_bloc.dart';
import 'package:gooloads/src/utils/constants/enums.dart';
import 'package:gooloads/src/utils/constants/palette.dart';
import 'package:gooloads/src/utils/logger.dart';
import 'package:gooloads/src/view/screens/minor_screens/create_account/create_account.dart';
import 'package:gooloads/src/view/screens/main_screens/home/home.dart';
import 'local_widgets/not_connected_to_internet.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


class RootScreen extends StatelessWidget {
  const RootScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ConnectivityBloc, ConnectivityState>(
      builder: (context, connectivityState) {
        if (connectivityState is ConnectivityMethodState) {
          bool _isOffline = connectivityState.connectivityResult == ConnectivityResult.none;
          if (!_isOffline) {
            return BlocBuilder<UserStateBloc, UserStateState>(
              builder: (context, userStateState) {
                if (userStateState is AuthenticationLoading) {
                  return LoadingScreen();
                } else if (userStateState is StateCheckResult) {
                  Widget retVal;
                  switch (userStateState.authState) {
                    case AuthState.AUTHENTICATED:                     
                      retVal = HomeScreen();
                      break;
                    case AuthState.UNAUTHENTICATED:
                      retVal = CreateAccountScreen();
                      break;
                  }
                  return retVal;
                } else {
                  return Text("userStateState Error");
                }
              },
            );
          } else if (_isOffline) {
            return NotConnectedToInternetScreen();
          }
        } else if (connectivityState is ConnectivityError) {
          DevLogger.log(connectivityState.error.toString(), name: 'ConnectivityError');
          return Text('Error');
        }
        return LoadingScreen();
      },
    );
  }
}

class LoadingScreen extends StatelessWidget {
  const LoadingScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: CircularProgressIndicator(color: Palette.KBlackClr),
      ),
    );
  }
}
