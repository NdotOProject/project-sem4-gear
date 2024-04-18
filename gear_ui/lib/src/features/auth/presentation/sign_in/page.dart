import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

// external packages
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

// internal packages
import 'package:gear_ui/src/features/auth/data/auth_repository.dart';
import 'package:gear_ui/src/features/auth/domain/sign_in_result.dart';
import 'package:gear_ui/src/features/auth/domain/sign_in_request.dart';
import 'package:gear_ui/src/features/auth/presentation/input_validators.dart';
import 'package:gear_ui/src/routes/app_routes.dart';
import 'package:gear_ui/src/utils/nested_list_transformer.dart';
import 'package:gear_ui/src/widgets/checkbox_form_field.dart';
import 'package:gear_ui/src/widgets/form_widget.dart';
import 'package:gear_ui/src/layouts/children_page_layout.dart';
import 'package:gear_ui/src/widgets/password_form_field.dart';

class SignIn extends StatefulWidget {
  const SignIn({super.key});

  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  // view constants
  static const double _logoSize = 140.0;
  static const double _formPadding = 40.0;
  static const double _formElementGap = 10.0;
  static const double _dividerHeight = 30.0;
  static const int _countSocialMediaButtonPerRow = 2;
  static const Size _buttonSize = Size.fromHeight(50.0);

  // supported login with other ways.
  final List<_SocialMedia> _socialMediaWays = <_SocialMedia>[
    _SocialMedia(
      iconData: FontAwesomeIcons.facebookF,
      label: "Facebook",
      onPressed: () {},
      backgroundColor: Colors.blue.shade900,
      foregroundColor: Colors.white,
    ),
    _SocialMedia(
      iconData: FontAwesomeIcons.twitter,
      label: "Twitter",
      onPressed: () {},
      backgroundColor: Colors.blue.shade600,
      foregroundColor: Colors.white,
    ),
    _SocialMedia(
      iconData: FontAwesomeIcons.google,
      label: "Google",
      onPressed: () {},
      backgroundColor: Colors.black,
      foregroundColor: Colors.white,
    ),
  ];

  // form data holders
  final _emailInputController = TextEditingController();
  final _passwordInputController = TextEditingController();
  bool _remember = false;

  // other data holders
  List<List<_SocialMedia>> _transformedSocialMediaWays = [];
  SignInResult _signInResult = SignInResult.unknown();

  // event handlers
  void _rememberChangeHandler(bool? value) {
    setState(() {
      _remember = value ?? false;
    });
  }

  Future<SignInResult> _signInHandler(BuildContext context) async {
    final repository = await AuthRepository.instance;
    return repository.signIn(
      SignInRequest(
        email: _emailInputController.text,
        password: _passwordInputController.text,
        remember: _remember,
      ),
    );
  }

  // navigators
  void _handleTapToForgotPassword() {}

  void _handleTapToCreateNewAccount(BuildContext context) {
    AppRoutes.signUp.asDestination(context: context);
  }

  void _redirectToPrivacyPage() {}

  @override
  void initState() {
    super.initState();

    setState(() {
      _transformedSocialMediaWays = NestedListTransformer(
        original: _socialMediaWays,
        nestedListLength: _countSocialMediaButtonPerRow,
      ).transformedList;
    });
  }

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);

    final OutlinedBorder buttonShape = RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(10),
    );

    final double formTitleFontSize =
        theme.textTheme.titleMedium?.fontSize ?? 20;

    final Widget form = FormWidget(
      onSubmit: (isValid) {
        if (isValid) {
          _signInHandler(context).then((result) {
            if (result.success) {
              AppRoutes.home.asDestination(context: context);
            } else {
              setState(() {
                _signInResult = result;
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
            errorText: _signInResult.emailError,
          ),
        ),
        PasswordFormField(
          controller: _passwordInputController,
          validator: InputValidators.passwordValidator,
          decoration: InputDecoration(
            errorText: _signInResult.passwordError,
          ),
        ),
        CheckboxFormField(
          initialValue: _remember,
          onChanged: _rememberChangeHandler,
          title: const Text("Remember me"),
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
          "Sign In",
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
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            InkWell(
              onTap: _handleTapToForgotPassword,
              child: const Text(
                "Forgot password?",
                style: TextStyle(
                  color: Colors.blue,
                ),
              ),
            ),
            InkWell(
              onTap: () {
                _handleTapToCreateNewAccount(context);
              },
              child: Text(
                "Create new account",
                style: TextStyle(
                  color: Colors.blue.shade800,
                ),
              ),
            ),
          ],
        ),
      ),
    );

    final Widget socialMediaOptions = Column(
      children: <Widget>[
        ..._transformedSocialMediaWays.map((socialMediaList) {
          return Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              ...socialMediaList.map((socialMedia) {
                return Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: _formElementGap / 2,
                      vertical: _formElementGap / 2,
                    ),
                    child: ElevatedButton.icon(
                      icon: Icon(
                        socialMedia.iconData,
                        color: socialMedia.foregroundColor,
                      ),
                      onPressed: socialMedia.onPressed,
                      label: Text(
                        socialMedia.label,
                        style: TextStyle(
                          color: socialMedia.foregroundColor,
                        ),
                      ),
                      style: ElevatedButton.styleFrom(
                        shape: buttonShape,
                        fixedSize: _buttonSize,
                        backgroundColor: socialMedia.backgroundColor,
                      ),
                    ),
                  ),
                );
              }),
            ],
          );
        }),
      ],
    );

    final Widget privacySection = Text.rich(
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
            const Divider(
              height: _dividerHeight,
            ),
            socialMediaOptions,
            const Spacer(),
            privacySection,
          ],
        ),
      ),
    );
  }
}

class _SocialMedia {
  _SocialMedia({
    required this.iconData,
    required this.label,
    required this.onPressed,
    required this.backgroundColor,
    required this.foregroundColor,
  });

  final IconData iconData;
  final String label;
  final VoidCallback onPressed;
  final Color backgroundColor;
  final Color foregroundColor;
}
