part of 'authentication_bloc.dart';

@immutable
abstract class AuthenticationEvent {}

class SignInEvent extends AuthenticationEvent {
  final String email;
  final String password;

  SignInEvent({
    required this.email,
    required this.password,
  });
}

class SignUpEvent extends AuthenticationEvent {
  final String email;
  final String password;
  final String name;

  SignUpEvent({
    required this.name,
    required this.email,
    required this.password,
  });
}

class SignOutEvent extends AuthenticationEvent {}
class RequestUserCredentialsEvent extends AuthenticationEvent {}

