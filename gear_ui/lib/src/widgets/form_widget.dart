import 'package:flutter/material.dart';

class FormWidget extends StatefulWidget {
  const FormWidget({
    GlobalKey<FormState>? key,
    this.onSubmit,
    this.title,
    this.fields = const [],
    this.submitButton,
    this.elementGap = 0.0,
  }) : super(key: key);

  final void Function(bool isValid)? onSubmit;
  final Widget? title;
  final List<FormField> fields;
  final Widget? submitButton;
  final double elementGap;

  @override
  State<FormWidget> createState() => FormWidgetState();
}

class FormWidgetState extends State<FormWidget> {
  late final GlobalKey<FormState> _formKey;
  late final double _elementGap;

  Widget _formElementBuilder(Widget element) {
    return Padding(
      padding: EdgeInsets.symmetric(
        vertical: _elementGap,
      ),
      child: element,
    );
  }

  @override
  void initState() {
    super.initState();

    _formKey = (widget.key as GlobalKey<FormState>?) ?? GlobalKey<FormState>();
    _elementGap = widget.elementGap / 2;
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            if (widget.title != null) _formElementBuilder(widget.title!),
            ...widget.fields.map(_formElementBuilder),
            if (widget.submitButton != null)
              _formElementBuilder(
                Listener(
                  behavior: HitTestBehavior.opaque,
                  onPointerDown: (_) {
                    widget.onSubmit?.call(_formKey.currentState!.validate());
                  },
                  child: widget.submitButton,
                ),
              ),
          ],
        ),
      ),
    );
  }
}
