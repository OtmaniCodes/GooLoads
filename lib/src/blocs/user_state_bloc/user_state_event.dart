part of 'user_state_bloc.dart';


@immutable
abstract class UserStateEvent {}


class CheckUserStateEvent extends UserStateEvent {
  final User? user;

  CheckUserStateEvent({required this.user}); 
}

