part of 'user_state_bloc.dart';

@immutable
abstract class UserStateState {}

class StateCheckResult extends UserStateState {
  final AuthState authState;
  StateCheckResult({required this.authState});

}

class UserStateError extends UserStateState{}