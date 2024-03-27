import 'dart:ui';

import 'package:animate_do/animate_do.dart' as animatedo;
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gooloads/src/blocs/authentication_bloc/authentication_bloc.dart';
import 'package:gooloads/src/utils/constants/constants.dart';
import 'package:gooloads/src/utils/constants/palette.dart';
import 'package:gooloads/src/view/global_widgets/custom_container.dart';
import 'package:gooloads/src/view/global_widgets/custom_text.dart';

class SignUpFeedback {
  static showSignUpFeedback(BuildContext context) {
    showDialog(
      context: context,
      builder: (_) {
        return BlocBuilder<AuthenticationBloc, AuthenticationState>(
          builder: (context, authState) {
            if (authState is AuthenticationLoading) {
              return _getFeedbackContent(context, 'Loading...', 0);
            } else if (authState is AuthenticationResult) {
              if (authState.isSuccess) {
                return _getFeedbackContent(
                    context, "You successfuly signed up!", 1);
              } else {
                return _getFeedbackContent(context, authState.message!, 2);
              }
            } else {
              return _getFeedbackContent(context, 'an error has occured!', 3);
            }
          },
        );
      },
    );
  }

  static Widget _getFeedbackContent(
      BuildContext context, String message, int index) {
    List<IconData> MyIcons = [
      Icons.loop_rounded,
      Icons.login_rounded,
      Icons.error
    ];
    // if (index == 1)
      // Future.delayed(Duration(seconds: 2), () => Navigator.pop(context));
    return GestureDetector(
      onTap: () => Navigator.pop(context),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        color: Palette.KWhiteClr.withOpacity(0.4),
        alignment: Alignment.center,
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
          child: GestureDetector(
            onTap: () {},
            child: MyContainer(
              givenPadd: const EdgeInsets.symmetric(
                  horizontal: KDefaultPadd, vertical: 15.0),
              kiddo: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  (index == 0)
                      ? animatedo.Spin(
                          child: Icon(
                            MyIcons[index],
                            size: 50.0,
                          ),
                        )
                      : (index == 2)
                          ? animatedo.FadeIn(
                              child: Icon(
                                MyIcons[index],
                                size: 50.0,
                              ),
                            )
                          : animatedo.Pulse(
                              child: Icon(
                                MyIcons[index],
                                size: 50.0,
                              ),
                            ),
                  SMALL_VSPACING,
                  MyText(
                    txt: message,
                    size: 24,
                    alignment: TextAlign.center,
                    clr: Palette.KBlackClr,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
