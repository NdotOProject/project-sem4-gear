import 'package:flutter/material.dart';

class FormWidget extends StatefulWidget {
  const FormWidget({
    GlobalKey<FormState>? key,
    required this.elements,
    this.submitButton,
    this.formElementGap = 0.0,
  }) : super(key: key);

  final ElevatedButton? submitButton;
  final List<Widget> elements;
  final double formElementGap;

  @override
  State<FormWidget> createState() => _FormWidgetState();
}

class _FormWidgetState extends State<FormWidget> {
  late final GlobalKey<FormState> _formKey;

  late final ElevatedButton _submitButton;

  @override
  void initState() {
    if (widget.key != null) {
      _formKey = widget.key! as GlobalKey<FormState>;
    } else {
      _formKey = GlobalKey<FormState>();
    }

    if (widget.submitButton != null) {
      _submitButton = ElevatedButton(
        key: widget.submitButton?.key,
        // override onPressed
        onPressed: () {
          if (_formKey.currentState!.validate()) {
            widget.submitButton?.onPressed?.call();
          }
        },
        onLongPress: widget.submitButton?.onLongPress,
        onHover: widget.submitButton?.onHover,
        onFocusChange: widget.submitButton?.onFocusChange,
        style: widget.submitButton?.style,
        focusNode: widget.submitButton?.focusNode,
        autofocus: widget.submitButton?.autofocus ?? false,
        clipBehavior: widget.submitButton?.clipBehavior ?? Clip.none,
        statesController: widget.submitButton?.statesController,
        child: widget.submitButton?.child,
      );
    }

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: <Widget>[
          ...widget.elements.map((element) {
            return Padding(
              padding: EdgeInsets.symmetric(
                vertical: widget.formElementGap,
              ),
              child: element,
            );
          }),
          if (widget.submitButton != null)
            Padding(
              padding: EdgeInsets.symmetric(
                vertical: widget.formElementGap,
              ),
              child: _submitButton,
            ),
        ],
      ),
    );
  }
}
