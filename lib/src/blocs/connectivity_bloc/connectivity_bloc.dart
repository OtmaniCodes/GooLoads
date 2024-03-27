import 'dart:async';
import 'package:gooloads/src/utils/connectivity_checker.dart';
import 'package:connectivity_plus/connectivity_plus.dart';

import 'package:bloc/bloc.dart';
import 'package:gooloads/src/utils/service_locator.dart';
import 'package:meta/meta.dart';

part 'connectivity_event.dart';
part 'connectivity_state.dart';

class ConnectivityBloc extends Bloc<ConnectivityEvent, ConnectivityState> {
  ConnectivityBloc() : super(ConnectivityLoading());

  @override
  Stream<ConnectivityState> mapEventToState(ConnectivityEvent event) async* {
    yield ConnectivityLoading();
    if (event is CheckConnectivityEvent) {
      yield ConnectivityLoading();
      try {
        ConnectivityResult connectivityResult = await serviceLocator<InternetConnectivity>().checkInternetConnectivity();
        yield ConnectivityMethodState(connectivityResult: connectivityResult);

        // serviceLocator<InternetConnectivity>()
        //     .getConnectivityStream()
        //     .listen((event) async* {
        //   yield ConnectivityMethodState(connectivityResult: event);
        // });
      } catch (error) {
        yield ConnectivityError();
      }
    }
  }
}
