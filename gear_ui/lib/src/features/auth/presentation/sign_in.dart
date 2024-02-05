import 'package:flutter/material.dart';
import 'package:gear_ui/src/common/widgets/checkbox_form_field.dart';
import 'package:gear_ui/src/common/widgets/form_widget.dart';
import 'package:gear_ui/src/layouts/children_page_layout.dart';

class SignIn extends StatefulWidget {
  const SignIn({
    super.key,
  });

  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  final _emailInputController = TextEditingController();
  final _passwordInputController = TextEditingController();
  bool _showPassword = false;
  bool _remember = false;

  static const double _formPadding = 40;

  void _handleRemember() {
    setState(() {
      _remember = !_remember;
    });
  }

  @override
  Widget build(BuildContext context) {
    return ChildrenPageLayout(
      title: const Text(
        "Sign In",
      ),
      body: Column(
        children: [
          FormWidget(
            elements: [
              TextFormField(
                controller: _emailInputController,
                decoration: const InputDecoration(
                  icon: Icon(
                    Icons.alternate_email,
                  ),
                  labelText: "Email",
                ),
              ),
              TextFormField(
                obscureText: !_showPassword,
                maxLines: 1,
                controller: _passwordInputController,
                decoration: InputDecoration(
                  icon: const Icon(
                    Icons.lock_outline,
                  ),
                  labelText: "Password",
                  suffixIcon: IconButton(
                    onPressed: () {
                      setState(() {
                        _showPassword = !_showPassword;
                      });
                    },
                    icon: Icon(
                      _showPassword ? Icons.visibility : Icons.visibility_off,
                    ),
                  ),
                ),
              ),
              CheckboxFormField(
                title: const Text("Remember me."),
                onChanged: (v) {},
                validator: (value) {
                  print(value);
                  if (value!) {
                    return "error";
                  }
                  return null;
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}

/*
Form(
        child: Padding(
          padding: const EdgeInsets.only(
            left: _formPadding,
            right: _formPadding,
          ),
          child: Column(
            children: <Widget>[
              const Padding(
                padding: EdgeInsets.only(
                  bottom: 10,
                ),
                child: Align(
                  alignment: FractionalOffset.centerLeft,
                  child: Text(
                    "Hi there! Nice to see you again.",
                  ),
                ),
              ),

              ListTile(
                leading: Checkbox(
                  value: _remember,
                  onChanged: (bool? value) {
                    _handleRemember();
                  },
                ),
                title: GestureDetector(
                  onTap: _handleRemember,
                  child: const Text(
                    "Remember me",
                  ),
                ),
              ),
              SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    backgroundColor: Theme.of(context).primaryColor,
                    foregroundColor:
                        Theme.of(context).primaryTextTheme.displayMedium?.color,
                    textStyle: const TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 15,
                    ),
                  ),
                  onPressed: () {},
                  child: const Text(
                    "Sign In",
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
*/
