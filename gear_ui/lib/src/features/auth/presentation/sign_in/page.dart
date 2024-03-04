import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

// external packages
import 'package:email_validator/email_validator.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

// internal packages
import 'package:gear_ui/src/features/auth/data/auth_repository.dart';
import 'package:gear_ui/src/features/auth/domain/sign_in_result.dart';
import 'package:gear_ui/src/features/auth/domain/sign_in_user.dart';
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
  static const double _logoSize = 140.0;
  static const double _formPadding = 40.0;
  static const double _formElementGap = 10.0;
  static const double _dividerHeight = 30.0;
  static const int _countSocialMediaButtonPerRow = 2;
  static const Size _buttonSize = Size.fromHeight(50.0);

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
  SignInResult _signInResult = SignInResult();
  List<List<_SocialMedia>> _transformedSocialMediaWays = [];

  // event handlers
  void _handleTapToRemember(bool? value) {
    setState(() {
      _remember = value ?? false;
    });
  }

  void _redirectToPrivacyPage() {
    // TODO: implement logic.
  }

  void _handleTapToForgotPassword() {}

  void _handleTapToCreateNewAccount() {}

  void _handleSignIn() async {
    final repository = await AuthRepository.instance;
    _signInResult = await repository.signIn(
      SignInUser(
        email: _emailInputController.text,
        password: _passwordInputController.text,
        remember: _remember,
      ),
    );
  }

  String? _emailValidator(String? value) {
    if (value == null || value.isEmpty) {
      return "Email is required.";
    } else if (!EmailValidator.validate(value)) {
      return "Incorrect email format.";
    }
    return null;
  }

  String? _passwordValidator(String? value) {
    if (value == null || value.isEmpty) {
      return "Password is required.";
    } else if (value.length < 6) {
      return "Password length must greater than or equals to 6.";
    } else if (!RegExp(r'[a-z].*').hasMatch(value)) {
      return "Password must contains lowercase characters.";
    } else if (!RegExp(r'[A-Z].*').hasMatch(value)) {
      return "Password must contains uppercase characters.";
    } else if (!RegExp(r'[0-9].*').hasMatch(value)) {
      return "Password must contains numeric characters.";
    }
    return null;
  }

  @override
  void initState() {
    super.initState();

    void loadData() async {
      final repository = await AuthRepository.instance;
      final rememberedUser = repository.rememberedUser;

      _emailInputController.text = rememberedUser.email;
      _passwordInputController.text = rememberedUser.password;
      _remember = rememberedUser.remember;
    }

    setState(() {
      _transformedSocialMediaWays = NestedListTransformer(
        original: _socialMediaWays,
        nestedListLength: _countSocialMediaButtonPerRow,
      ).transformedList;

      loadData();
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
      title: SizedBox(
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
      fields: [
        TextFormField(
          controller: _emailInputController,
          validator: _emailValidator,
          decoration: const InputDecoration(
            labelText: "Email",
          ),
        ),
        PasswordFormField(
          controller: _passwordInputController,
          validator: _passwordValidator,
        ),
        CheckboxFormField(
          onChanged: _handleTapToRemember,
          title: const Text("Remember me"),
        ),
      ],
      submitButtonSize: _buttonSize,
      submitButton: ElevatedButton(
        style: ElevatedButton.styleFrom(
          shape: buttonShape,
          backgroundColor: theme.primaryColor,
        ),
        onPressed: _handleSignIn,
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
              onTap: _handleTapToCreateNewAccount,
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
