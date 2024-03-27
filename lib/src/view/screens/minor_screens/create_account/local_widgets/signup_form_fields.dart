

import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gooloads/src/blocs/authentication_bloc/authentication_bloc.dart';
import 'package:gooloads/src/utils/actions_feedbacks/sign_up_feedback.dart';
import 'package:gooloads/src/utils/constants/constants.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gooloads/src/view/global_widgets/custom_container.dart';

import 'create_account_button.dart';

class SignUpFormFields extends StatefulWidget {
  const SignUpFormFields({Key? key}) : super(key: key);

  @override
  _SignUpFormFieldsState createState() => _SignUpFormFieldsState();
}

class _SignUpFormFieldsState extends State<SignUpFormFields> {
  final _formKey = GlobalKey<FormState>();
  final FocusNode _nameNode = FocusNode();
  final TextEditingController _nameController = TextEditingController();
  final FocusNode _emailNode = FocusNode();
  final TextEditingController _emailController = TextEditingController();
  final FocusNode _passwordNode = FocusNode();
  final TextEditingController _passwordController = TextEditingController();

  @override
  void dispose() {
    _nameController.dispose();
    _nameNode.dispose();
    _emailController.dispose();
    _emailNode.dispose();
    _passwordController.dispose();
    _passwordNode.dispose();
    super.dispose();
  }

  signUserUp() {
    final authBloc = BlocProvider.of<AuthenticationBloc>(context, listen: false);
    authBloc.add(
      SignUpEvent(
        email: this._emailController.text.trim(),
        password: this._passwordController.text.trim(),
        name: this._nameController.text.trim(),
      ),
    );
   SignUpFeedback.showSignUpFeedback(context);
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
              getTextFormField("Name", _nameController, _nameNode),
              MEDIUM_VSPACING,
              getTextFormField("Email", _emailController, _emailNode),
              MEDIUM_VSPACING,
              getTextFormField("Password", _passwordController, _passwordNode,
                  isPassword: true),
              LARGE_VSPACING,
              LARGE_VSPACING,
              CreateAccountButton(
                isSignUp: true,
                onPress: () {
                  HapticFeedback.mediumImpact();
                    _passwordNode.unfocus();
                  if (_formKey.currentState!.validate()) {
                    this.signUserUp();
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
          case "name":
            _emailNode.requestFocus();
            break;
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
