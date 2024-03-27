part of 'authentication_bloc.dart';

@immutable
abstract class AuthenticationState {}

class AuthenticationInitial extends AuthenticationState {}

class AuthenticationLoading extends AuthenticationState {}

class AuthenticationResult extends AuthenticationState {
  final bool isSuccess;
  final String? message;
  AuthenticationResult({required this.isSuccess, this.message});
}

class UserCredentialsRequestResult extends AuthenticationState {
  final bool userExists;
  final String? userName;
  final String? email;
  UserCredentialsRequestResult({
    required this.userExists,
    this.userName,
    this.email,
  });
}

class AuthenticationError extends AuthenticationState {
  final Error? error;

  AuthenticationError({this.error});
}
