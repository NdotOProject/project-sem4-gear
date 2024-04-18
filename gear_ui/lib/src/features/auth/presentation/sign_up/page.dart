import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

// internal packages
import 'package:gear_ui/src/features/auth/data/auth_repository.dart';
import 'package:gear_ui/src/features/auth/domain/sign_up_request.dart';
import 'package:gear_ui/src/features/auth/domain/sign_up_result.dart';
import 'package:gear_ui/src/features/auth/presentation/input_validators.dart';
import 'package:gear_ui/src/layouts/children_page_layout.dart';
import 'package:gear_ui/src/routes/app_routes.dart';
import 'package:gear_ui/src/widgets/checkbox_form_field.dart';
import 'package:gear_ui/src/widgets/form_widget.dart';
import 'package:gear_ui/src/widgets/password_form_field.dart';

class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  static const double _logoSize = 140.0;
  static const double _formPadding = 40.0;
  static const double _formElementGap = 10.0;
  static const Size _buttonSize = Size.fromHeight(50.0);

  // form data holders
  final _emailInputController = TextEditingController();
  final _passwordInputController = TextEditingController();

  // other data
  SignUpResult _signUpResult = SignUpResult.unknown();
  bool _acceptPrivacy = false;

  // event handlers
  Future<SignUpResult> _signUpHandler(BuildContext context) async {
    final repository = await AuthRepository.instance;
    return repository.register(
      SignUpRequest(
        email: _emailInputController.text,
        password: _passwordInputController.text,
      ),
    );
  }

  void _acceptPrivacyChangeHandler(bool? value) {
    setState(() {
      _acceptPrivacy = value ?? false;
    });
  }

  // navigators
  void _navigateToSignInPage(BuildContext context) {
    AppRoutes.signIn.asDestination(context: context);
  }

  void _redirectToPrivacyPage() {}

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);

    final double formTitleFontSize =
        theme.textTheme.titleMedium?.fontSize ?? 20;

    final Text privacySection = Text.rich(
      TextSpan(
        children: [
          const TextSpan(
            text: "See ",
          ),
          TextSpan(
            text: "privacy ",
            style: const TextStyle(
              color: Colors.red,
            ),
            recognizer: TapGestureRecognizer()..onTap = _redirectToPrivacyPage,
          )
        ],
      ),
    );

    final Widget form = FormWidget(
      onSubmit: (isValid) {
        if (isValid) {
          _signUpHandler(context).then((result) {
            if (result.success) {
              AppRoutes.home.asDestination(context: context);
            } else {
              setState(() {
                _signUpResult = result;
              });
            }
          });
        }
      },
      title: Align(
        alignment: Alignment.center,
        child: SizedBox(
          height: _logoSize,
          child: Column(
            children: [
              FlutterLogo(
                size: _logoSize - (formTitleFontSize * 2),
              ),
              Text(
                "Gear",
                style: TextStyle(
                  fontSize: formTitleFontSize,
                ),
              ),
            ],
          ),
        ),
      ),
      fields: [
        TextFormField(
          controller: _emailInputController,
          validator: InputValidators.emailValidator,
          decoration: InputDecoration(
            labelText: "Email",
            errorText: _signUpResult.emailError,
          ),
        ),
        PasswordFormField(
          controller: _passwordInputController,
          validator: InputValidators.passwordValidator,
          decoration: InputDecoration(
            errorText: _signUpResult.passwordError,
          ),
        ),
        CheckboxFormField(
          initialValue: _acceptPrivacy,
          onChanged: _acceptPrivacyChangeHandler,
          title: privacySection,
        ),
      ],
      submitButton: Container(
        height: _buttonSize.height,
        decoration: BoxDecoration(
          color: theme.primaryColor,
          borderRadius: BorderRadius.circular(10),
        ),
        alignment: Alignment.center,
        child: Text(
          "Sign Up",
          style: TextStyle(
            fontSize: theme.textTheme.titleMedium?.fontSize,
            color: theme.primaryTextTheme.titleMedium?.color,
          ),
        ),
      ),
    );

    final Widget helpOptions = Padding(
      padding: const EdgeInsets.only(
        top: _formElementGap,
      ),
      child: SizedBox(
        width: double.infinity,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            InkWell(
              onTap: () {
                _navigateToSignInPage(context);
              },
              child: Text(
                "Already has an account",
                style: TextStyle(
                  color: Colors.blue.shade800,
                ),
              ),
            ),
          ],
        ),
      ),
    );

    return ChildrenPageLayout(
      title: const Text("Sign In"),
      body: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: _formPadding,
        ),
        child: Column(
          children: [
            form,
            helpOptions,
          ],
        ),
      ),
    );
  }
}
