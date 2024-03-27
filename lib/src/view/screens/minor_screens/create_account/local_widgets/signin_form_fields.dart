import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gooloads/src/blocs/authentication_bloc/authentication_bloc.dart';
import 'package:gooloads/src/utils/actions_feedbacks/sign_in_feedback.dart';
import 'package:gooloads/src/utils/constants/constants.dart';
import 'create_account_button.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SignInFormFields extends StatefulWidget {
  const SignInFormFields({Key? key}) : super(key: key);

  @override
  _SignUpFormFieldsState createState() => _SignUpFormFieldsState();
}

class _SignUpFormFieldsState extends State<SignInFormFields> {
  final _formKey = GlobalKey<FormState>();
  final FocusNode _emailNode = FocusNode();
  final TextEditingController _emailController = TextEditingController();
  final FocusNode _passwordNode = FocusNode();
  final TextEditingController _passwordController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _emailNode.dispose();
    _passwordController.dispose();
    _passwordNode.dispose();
    super.dispose();
  }

  signUserIn() {
    final authBloc = BlocProvider.of<AuthenticationBloc>(context);
    authBloc.add(
      SignInEvent(
        email: this._emailController.text.trim(),
        password: this._passwordController.text.trim(),
      ),
    );
    SignInFeedback.showSignInFeedback(context);
  }

   

  @override
  Widget build(BuildContext context) {
    return ElasticIn(
      child: Form(
        key: _formKey,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: KMediumPadd),
          child: Column(
            children: [
              getTextFormField("Email", _emailController, _emailNode),
              MEDIUM_VSPACING,
              getTextFormField("Password", _passwordController, _passwordNode,
                  isPassword: true),
              LARGE_VSPACING,
              LARGE_VSPACING,
              CreateAccountButton(
                isSignUp: false,
                onPress: () {
                  HapticFeedback.mediumImpact();
                  _passwordNode.unfocus();
                  if (_formKey.currentState!.validate()) {
                    this.signUserIn();
                  } else {
                    print("fields are empty");
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  bool isPasswordVisible = false;
  TextFormField getTextFormField(
      String labelText, TextEditingController controller, FocusNode node,
      {isPassword = false}) {
    return TextFormField(
      validator: (value) {
        print(value);
        if (value == null || value.isEmpty) {
          return 'Please enter your ${labelText.toLowerCase()}';
        }
        return null;
      },
      controller: controller,
      focusNode: node,
      obscureText: isPassword ? isPasswordVisible : false,
      decoration: InputDecoration(
        labelText: labelText,
        suffix: isPassword
            ? GestureDetector(
                onTap: () {
                  setState(() => isPasswordVisible = !isPasswordVisible);
                },
                child: Icon(
                  isPasswordVisible ? Icons.visibility : Icons.visibility_off,
                ),
              )
            : null,
      ),
      onFieldSubmitted: (text) {
        print(text);
        switch (labelText.toLowerCase()) {
          case "email":
            _passwordNode.requestFocus();
            break;
          case "password":
            _passwordNode.unfocus();
            print("submit");
            break;
        }
      },
    );
  }
}
