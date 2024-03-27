import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gooloads/src/blocs/authentication_bloc/authentication_bloc.dart';
import 'package:gooloads/src/blocs/user_state_bloc/user_state_bloc.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  void checkUserAuthState(BuildContext context) {
    final authBloc = BlocProvider.of<UserStateBloc>(context);
    _auth.authStateChanges().listen(
          (User? user) => authBloc.add(CheckUserStateEvent(user: user)),
        );
  }

  User? getUserCredentials() {
    return _auth.currentUser;
  }

  saveUserName(String userName) async {
    if (_auth.currentUser != null) {
      try {
        await _auth.currentUser!.updateDisplayName(userName);
      } catch (error) {
        print(error);
      }
    }
  }

  Future<void> saveUserPhotoUrl(String photoUrl) async {
    if (_auth.currentUser != null) {
      try {
        await _auth.currentUser!.updatePhotoURL(photoUrl);
      } catch (error) {
        print(error);
      }
    }
  }

  Future<List<String>> signInWithEmailAndPassword(
      String email, String password) async {
    List<String> retVal = ["error"];
    try {
      await _auth.signInWithEmailAndPassword(email: email, password: password);
      retVal[0] = "success";
      retVal.add("no message");
    } on FirebaseAuthException catch (error) {
      retVal.add(error.message!);
      print("AUTH ERROR: $error");
    }
    print(retVal);
    return retVal;
  }

  Future<List<String>> signUpWithEmailAndPassword(
      String email, String password) async {
    List<String> retVal = ["error"];
    try {
      await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      retVal[0] = "success";
      retVal.add("no message");
    } on FirebaseAuthException catch (error) {
      retVal.add(error.message!);
      print("AUTH ERROR: $error");
    }
    print(retVal);
    return retVal;
  }

  Future<String> signOut() async {
    String retVal = "error";
    try {
      await _auth.signOut();
      retVal = "success";
    } on FirebaseAuthException catch (error) {
      print("AUTH ERROR: $error");
    }
    return retVal;
  }
}
