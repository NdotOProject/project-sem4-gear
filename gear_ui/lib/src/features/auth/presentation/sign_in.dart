import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:gear_ui/src/widgets/checkbox_form_field.dart';
import 'package:gear_ui/src/widgets/form_widget.dart';
import 'package:gear_ui/src/layouts/children_page_layout.dart';
import 'package:gear_ui/src/widgets/password_form_field.dart';

class SignIn extends StatefulWidget {
  const SignIn({
    super.key,
  });

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

  final List<_SocialMedia> _supportedSocialMediaWays = <_SocialMedia>[
    _SocialMedia(
      iconData: FontAwesomeIcons.facebookF,
      label: "Facebook",
      onPressed: () {},
      backgroundColor: Colors.blue.shade900,
    ),
    _SocialMedia(
      iconData: FontAwesomeIcons.twitter,
      label: "Twitter",
      onPressed: () {},
      backgroundColor: Colors.blue.shade600,
    ),
    _SocialMedia(
      iconData: FontAwesomeIcons.google,
      label: "Google",
      onPressed: () {},
      backgroundColor: Colors.black,
    ),
  ];

  // form data holders
  final _emailInputController = TextEditingController();
  final _passwordInputController = TextEditingController();
  bool _remember = false;

  // data handlers
  List<List<_SocialMedia>> _transformListSocialMedia() {
    int length = _supportedSocialMediaWays.length;
    List<_SocialMedia> rowItems = [];
    final List<List<_SocialMedia>> result = [];

    for (var socialMedia in _supportedSocialMediaWays) {
      rowItems.add(socialMedia);
      length--;
      if (rowItems.length == _countSocialMediaButtonPerRow) {
        result.add(rowItems);
        rowItems = [];
      } else if (length == 0) {
        result.add(rowItems);
      }
    }

    return result;
  }

  // event handlers
  void _handleTapToRemember(bool? value) {
    setState(() {
      _remember = value ?? false;
    });
  }

  void _handleRemember() {
    // TODO: implement remember logic.
    if (_remember) {}
  }

  void _handleRedirectToPrivacyPage() {
    // TODO: implement logic.
  }

  void _handleTapToForgotPassword() {}

  void _handleTapToCreateNewAccount() {}

  void _handleSignIn() {
    _handleRemember();
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
          validator: (String? value) {
            if (value?.isEmpty ?? false) {
              return "error";
            }
            return null;
          },
          decoration: const InputDecoration(
            labelText: "Email",
          ),
        ),
        PasswordFormField(
          controller: _passwordInputController,
          validator: (String? value) {
            if (value?.isEmpty ?? false) {
              return "error";
            }
            return null;
          },
        ),
        CheckboxFormField(
          onChanged: _handleTapToRemember,
          title: const Text(
            "Remember me",
          ),
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
        ..._transformListSocialMedia().map((socialMediaList) {
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
                      style: ElevatedButton.styleFrom(
                        shape: buttonShape,
                        fixedSize: _buttonSize,
                        backgroundColor: socialMedia.backgroundColor,
                      ),
                      icon: Icon(
                        socialMedia.iconData,
                        color: Colors.white,
                      ),
                      onPressed: socialMedia.onPressed,
                      label: Text(
                        socialMedia.label,
                        style: const TextStyle(
                          color: Colors.white,
                        ),
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
            recognizer: TapGestureRecognizer()
              ..onTap = _handleRedirectToPrivacyPage,
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
  });

  final IconData iconData;
  final String label;
  final VoidCallback onPressed;
  final Color backgroundColor;
}
