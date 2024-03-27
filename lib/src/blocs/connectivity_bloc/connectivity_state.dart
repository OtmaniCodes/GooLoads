part of 'connectivity_bloc.dart';

@immutable
abstract class ConnectivityState {}


class ConnectivityLoading extends ConnectivityState {}

class ConnectivityMethodState extends ConnectivityState {
  final ConnectivityResult connectivityResult;

  ConnectivityMethodState({required this.connectivityResult});
}

class ConnectivityError extends ConnectivityState {
  final Error? error;

  ConnectivityError({this.error});
}
