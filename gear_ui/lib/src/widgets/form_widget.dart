import 'package:flutter/material.dart';

class FormWidget extends StatefulWidget {
  const FormWidget({
    GlobalKey<FormState>? key,
    this.title,
    this.titleAlignment = Alignment.center,
    this.fields = const [],
    this.submitButton,
    this.submitButtonAlignment = Alignment.center,
    this.submitButtonSize,
    this.elementGap = 0.0,
  }) : super(key: key);

  final Widget? title;
  final AlignmentGeometry titleAlignment;
  final ElevatedButton? submitButton;
  final AlignmentGeometry submitButtonAlignment;
  final Size? submitButtonSize;
  final List<FormField> fields;
  final double elementGap;

  @override
  State<FormWidget> createState() => _FormWidgetState();
}

class _FormWidgetState extends State<FormWidget> {
  late final GlobalKey<FormState> _formKey;

  late final ElevatedButton? _submitButton;

  Widget _formElementBuilder(Widget element) {
    return Padding(
      padding: EdgeInsets.symmetric(
        vertical: widget.elementGap / 2,
      ),
      child: element,
    );
  }

  void _handleFormSubmit() {
    if (_formKey.currentState!.validate()) {
      widget.submitButton?.onPressed?.call();
    }
  }

  @override
  void initState() {
    super.initState();

    if (widget.key != null) {
      _formKey = widget.key! as GlobalKey<FormState>;
    } else {
      _formKey = GlobalKey<FormState>();
    }

    if (widget.submitButton != null) {
      _submitButton = ElevatedButton(
        key: widget.submitButton?.key,
        // override onPressed
        onPressed:
            widget.submitButton?.onPressed != null ? _handleFormSubmit : null,
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
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            if (widget.title != null)
              _formElementBuilder(
                Align(
                  alignment: widget.titleAlignment,
                  child: widget.title,
                ),
              ),
            ...widget.fields.map(_formElementBuilder),
            if (_submitButton != null)
              _formElementBuilder(
                Container(
                  padding: EdgeInsets.zero,
                  margin: EdgeInsets.zero,
                  alignment: _submitButton.style?.alignment ??
                      widget.submitButtonAlignment,
                  child: SizedBox(
                    width: widget.submitButtonSize?.width,
                    height: widget.submitButtonSize?.height,
                    child: _submitButton,
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
