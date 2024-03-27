import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gooloads/src/blocs/authentication_bloc/authentication_bloc.dart';
import 'package:gooloads/src/blocs/user_state_bloc/user_state_bloc.dart';
import 'package:gooloads/src/services/authentication/auth_service.dart';
import 'package:gooloads/src/utils/constants/constants.dart';
import 'package:gooloads/src/utils/constants/palette.dart';
import 'package:gooloads/src/utils/reuesed_widgets.dart';
import 'package:gooloads/src/utils/service_locator.dart';
import 'package:gooloads/src/view/global_widgets/custom_container.dart';

import 'package:gooloads/src/view/global_widgets/custom_text.dart';

import 'local_widgets/setting_section.dart';

class SettingsScreen extends StatelessWidget {
  SettingsScreen({Key? key}) : super(key: key);
  final List<String> options = ["Theming"];

  signOutUser(BuildContext context) {
    BlocProvider.of<AuthenticationBloc>(context).add(SignOutEvent());
    if(FirebaseAuth.instance.currentUser != null){
      serviceLocator<AuthService>().signOut();
    }  
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: ReusedWidgets.popButton(context),
        centerTitle: true,
        title: MyText(
          txt: "settings",
          clr: Palette.KBlackClr,
          size: 24,
        ),
      ),
      body: Column(
        children: [
        MEDIUM_VSPACING,
        ...options.map((option) => SettingSection(settingOption: option)).toList(),
        Spacer(),
        getSignoutButton(context)
      ]),
    );
  }

  Widget getSignoutButton(BuildContext context) {
    return Builder(builder: (context) {
      return Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Divider(thickness: 1.5, height: 0),
          ListTile(
            onTap: () {
              showDialog(
                context: context,
                builder: (context) => GestureDetector(
                onTap: () => Navigator.pop(context),
                child: ReusedWidgets.blurryBg(
                  widget: MyContainer(
                    givenMarg: const EdgeInsets.symmetric(vertical: KDefaultPadd, horizontal: 30.0),
                    withShadow: false,
                    kiddo: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        TINY_VSPACING,
                        MyText(
                          size: 20.0,
                          alignment: TextAlign.center,
                          txt: "Are you sure you want to log out?",
                          clr: Palette.KBlackClr,
                        ),
                        MEDIUM_VSPACING,
                        Row(
                          children: [
                            ElevatedButton(
                                style: ButtonStyle(
                                    backgroundColor:
                                        MaterialStateProperty.all(
                                            Palette.KBlackClr)),
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                                child: Text("Cancel")),
                            Spacer(),
                            ElevatedButton(
                                style: ButtonStyle(
                                    backgroundColor:
                                        MaterialStateProperty.all(
                                            Palette.KBlackClr)),
                                onPressed: () {
                                  Navigator.pop(context);
                                  this.signOutUser(context);
                                  BlocProvider.of<UserStateBloc>(context)
                                    ..add(CheckUserStateEvent(user: serviceLocator<AuthService>().getUserCredentials()));
                                },
                                child: Text("Yes"))
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              ));
            },
            leading: Icon(
              Icons.logout,
              color: Colors.red,
            ),
            title: MyText(
              txt: "Log out",
              clr: Colors.red,
            ),
          ),
        ],
      );
    });
  }
}
