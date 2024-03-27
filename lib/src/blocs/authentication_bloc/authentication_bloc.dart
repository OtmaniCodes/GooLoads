import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:gooloads/src/models/user_model.dart';
import 'package:gooloads/src/services/authentication/auth_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:gooloads/src/services/database/db_service.dart';
import 'package:gooloads/src/utils/service_locator.dart';
import 'package:meta/meta.dart';

part 'authentication_event.dart';
part 'authentication_state.dart';

class AuthenticationBloc
    extends Bloc<AuthenticationEvent, AuthenticationState> {
  AuthenticationBloc() : super(AuthenticationInitial());

  @override
  Stream<AuthenticationState> mapEventToState(
      AuthenticationEvent event) async* {
    yield AuthenticationLoading();
    try {
      bool yieldedVal = false;
      if (event is SignUpEvent) {
        List result = await serviceLocator<AuthService>()
            .signUpWithEmailAndPassword(event.email, event.password);
        if (result[0] == "success") {
          await serviceLocator<AuthService>().saveUserName(event.name);
          UserModel _user = UserModel(
            imageUrl: '',
            email: event.email,
            name: event.name,
            uid: serviceLocator<AuthService>().getUserCredentials()?.uid ?? '',
          );
          await serviceLocator<DataBaseService>().addUserToDB(_user);
          yieldedVal = true;
        }

        yield AuthenticationResult(isSuccess: yieldedVal, message: result[1]);
      } else if (event is SignInEvent) {
        List<String> result = await serviceLocator<AuthService>()
            .signInWithEmailAndPassword(event.email, event.password);
        if (result[0] == "success") yieldedVal = true;
        yield AuthenticationResult(isSuccess: yieldedVal, message: result[1]);
      } else if (event is SignOutEvent) {
        String result = await serviceLocator<AuthService>().signOut();
        if (result == "success") yieldedVal = true;
        yield AuthenticationResult(isSuccess: yieldedVal);
      } else if (event is RequestUserCredentialsEvent) {
        User? result = serviceLocator<AuthService>().getUserCredentials();
        if (result == null)
          yield UserCredentialsRequestResult(userExists: false);
        else
          yield UserCredentialsRequestResult(
            userExists: true,
            email: result.email ?? "No Email",
            userName: result.displayName ?? "Guest",
          );
      }
    } catch (error) {
      print(error);
      yield AuthenticationError();
    }
  }
}
