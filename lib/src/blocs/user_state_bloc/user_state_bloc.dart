import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:gooloads/src/utils/constants/enums.dart';
 
import 'package:meta/meta.dart';
import 'package:firebase_auth/firebase_auth.dart';

part 'user_state_event.dart';
part 'user_state_state.dart';

class UserStateBloc extends Bloc<UserStateEvent, UserStateState> {
  UserStateBloc()
      : super(StateCheckResult(authState: AuthState.UNAUTHENTICATED));

  @override
  Stream<UserStateState> mapEventToState(
    UserStateEvent event,
  ) async* {
    try {
      if (event is CheckUserStateEvent) {
        if (event.user == null) {
          yield StateCheckResult(authState: AuthState.UNAUTHENTICATED);
        } else {
          yield StateCheckResult(authState: AuthState.AUTHENTICATED);
        }
      }
    } catch (error) {
      yield UserStateError();
    }
  }
}
