import 'package:flutter/material.dart';
import 'package:gooloads/src/view/global_widgets/custom_black_button.dart';

class CreateAccountButton extends StatelessWidget {
  final bool isSignUp;
  final VoidCallback onPress;
  const CreateAccountButton({
    Key? key,
    required this.isSignUp,
    required this.onPress,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MyBlackButton(
      txt: isSignUp ? "Sign Up" : "Sign In",
      onPressed: this.onPress,
    );
  }
}
