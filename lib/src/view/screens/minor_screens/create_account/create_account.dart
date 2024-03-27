import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gooloads/src/utils/constants/constants.dart';
import 'package:gooloads/src/utils/constants/palette.dart';
import 'package:gooloads/src/view/global_widgets/custom_text.dart';

import 'local_widgets/signin_form_fields.dart';
import 'local_widgets/signup_form_fields.dart';

class CreateAccountScreen extends StatefulWidget {
  const CreateAccountScreen({Key? key}) : super(key: key);

  @override
  _CreateAccountScreenState createState() => _CreateAccountScreenState();
}

class _CreateAccountScreenState extends State<CreateAccountScreen> {
  bool isSignUp = true;

  @override
  Widget build(BuildContext context) {
    bool isKeyBoardOn = ScreenCredentials.isKeyBoardOn(context);
    return Scaffold(
      body: Stack(
        alignment: Alignment.center,
        fit: StackFit.expand,
        children: [
          Image.asset(
            KSignInBg,
            fit: BoxFit.cover,
          ),
          Container(
            color: Palette.KWhiteClr.withOpacity(0.48),
          ),
          SingleChildScrollView(
            physics: NeverScrollableScrollPhysics(),
            child: Container(
              width: ScreenCredentials.screenWidth(context),
              height: ScreenCredentials.screenHeight(context),
              child: Column(
                mainAxisAlignment: !isKeyBoardOn
                    ? MainAxisAlignment.spaceBetween
                    : MainAxisAlignment.start,
                children: [
                  !isKeyBoardOn
                      ? Padding(
                          padding: const EdgeInsets.only(top: KMediumPadd),
                          child: SafeArea(child: Image.asset(KAppLogo)),
                        )
                      : VoidSpacing,
                  SafeArea(child: isSignUp ? SignUpFormFields() : SignInFormFields()),
                  Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      MEDIUM_VSPACING,
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          MyText(
                            txt: !isSignUp
                                ? "Don't have an account?  "
                                : "Already own an accout?  ",
                          ),
                          GestureDetector(
                            child: MyText(
                              txt: !isSignUp ? "Sign Up" : "Sign In",
                              clr: Colors.blueAccent,
                            ),
                            onTap: () {
                              HapticFeedback.mediumImpact();
                              setState(() => isSignUp = !isSignUp);
                            },
                          )
                        ],
                      ),
                      SMALL_VSPACING
                    ],
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
