import 'dart:ui' as ui show BoxHeightStyle, BoxWidthStyle;

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class PasswordFormField extends FormField<String> {
  PasswordFormField({
    super.key,
    super.onSaved,
    super.validator,
    super.initialValue,
    super.autovalidateMode,
    super.restorationId,
    this.showPassword = false, // obscureText
    String replacementCharacter = '•', // obscuringCharacter
    TextEditingController? controller,
    FocusNode? focusNode,
    InputDecoration? decoration,
    TextInputType? keyboardType,
    TextCapitalization textCapitalization = TextCapitalization.none,
    TextInputAction? textInputAction,
    TextStyle? style,
    StrutStyle? strutStyle,
    TextDirection? textDirection,
    TextAlign textAlign = TextAlign.start,
    TextAlignVertical? textAlignVertical,
    bool autofocus = false,
    bool readOnly = false,
    ToolbarOptions? toolbarOptions,
    bool? showCursor,
    bool autocorrect = true,
    SmartDashesType? smartDashesType,
    SmartQuotesType? smartQuotesType,
    bool enableSuggestions = true,
    MaxLengthEnforcement? maxLengthEnforcement,
    int? maxLines = 1,
    int? minLines,
    bool expands = false,
    int? maxLength,
    ValueChanged<String>? onChanged,
    GestureTapCallback? onTap,
    TapRegionCallback? onTapOutside,
    VoidCallback? onEditingComplete,
    ValueChanged<String>? onFieldSubmitted,
    List<TextInputFormatter>? inputFormatters,
    bool? enabled,
    double cursorWidth = 2.0,
    double? cursorHeight,
    Radius? cursorRadius,
    Color? cursorColor,
    Brightness? keyboardAppearance,
    EdgeInsets scrollPadding = const EdgeInsets.all(20.0),
    bool? enableInteractiveSelection,
    TextSelectionControls? selectionControls,
    InputCounterWidgetBuilder? buildCounter,
    ScrollPhysics? scrollPhysics,
    Iterable<String>? autofillHints,
    ScrollController? scrollController,
    bool enableIMEPersonalizedLearning = true,
    MouseCursor? mouseCursor,
    EditableTextContextMenuBuilder? contextMenuBuilder,
    SpellCheckConfiguration? spellCheckConfiguration,
    TextMagnifierConfiguration? magnifierConfiguration,
    UndoHistoryController? undoController,
    AppPrivateCommandCallback? onAppPrivateCommand,
    bool? cursorOpacityAnimates,
    ui.BoxHeightStyle selectionHeightStyle = ui.BoxHeightStyle.tight,
    ui.BoxWidthStyle selectionWidthStyle = ui.BoxWidthStyle.tight,
    DragStartBehavior dragStartBehavior = DragStartBehavior.start,
    ContentInsertionConfiguration? contentInsertionConfiguration,
    Clip clipBehavior = Clip.hardEdge,
    bool scribbleEnabled = true,
    bool canRequestFocus = true,
    // decoration
    Widget? icon,
    Color? iconColor,
    Widget? label,
    String? labelText = "Password",
    TextStyle? labelStyle,
    TextStyle? floatingLabelStyle,
    Icon showIcon = const Icon(
      Icons.visibility,
    ),
    Icon hideIcon = const Icon(
      Icons.visibility_off,
    ),
  }) : super(
          builder: (FormFieldState<String> field) {
            final _PasswordFormFieldState state =
                field as _PasswordFormFieldState;

            return TextFormField(
              controller: controller,
              initialValue: initialValue,
              focusNode: focusNode,
              decoration: InputDecoration(
                icon: decoration?.icon ?? icon,
                iconColor: decoration?.iconColor ?? iconColor,
                label: decoration?.label ?? label,
                labelText: decoration?.labelText ?? labelText,
                labelStyle: decoration?.labelStyle ?? labelStyle,
                floatingLabelStyle:
                    decoration?.floatingLabelStyle ?? floatingLabelStyle,
                helperText: decoration?.helperText,
                helperStyle: decoration?.helperStyle,
                helperMaxLines: decoration?.helperMaxLines,
                hintText: decoration?.hintText,
                hintStyle: decoration?.hintStyle,
                hintTextDirection: decoration?.hintTextDirection,
                hintMaxLines: decoration?.hintMaxLines,
                hintFadeDuration: decoration?.hintFadeDuration,
                error: decoration?.error,
                errorText: decoration?.errorText,
                errorStyle: decoration?.errorStyle,
                errorMaxLines: decoration?.errorMaxLines,
                floatingLabelBehavior: decoration?.floatingLabelBehavior,
                floatingLabelAlignment: decoration?.floatingLabelAlignment,
                isCollapsed: decoration?.isCollapsed,
                isDense: decoration?.isDense,
                contentPadding: decoration?.contentPadding,
                prefixIcon: decoration?.prefixIcon,
                prefixIconConstraints: decoration?.prefixIconConstraints,
                prefix: decoration?.prefix,
                prefixText: decoration?.prefixText,
                prefixStyle: decoration?.prefixStyle,
                prefixIconColor: decoration?.prefixIconColor,
                suffixIcon: IconButton(
                  onPressed: state._toggleDisplayPassword,
                  icon: state._showPassword ? showIcon : hideIcon,
                ),
                suffix: decoration?.suffix,
                suffixText: decoration?.suffixText,
                suffixStyle: decoration?.suffixStyle,
                suffixIconColor: decoration?.suffixIconColor,
                suffixIconConstraints: decoration?.suffixIconConstraints,
                counter: decoration?.counter,
                counterText: decoration?.counterText,
                counterStyle: decoration?.counterStyle,
                filled: decoration?.filled,
                fillColor: decoration?.fillColor,
                focusColor: decoration?.focusColor,
                hoverColor: decoration?.hoverColor,
                errorBorder: decoration?.errorBorder,
                focusedBorder: decoration?.focusedBorder,
                focusedErrorBorder: decoration?.focusedErrorBorder,
                disabledBorder: decoration?.disabledBorder,
                enabledBorder: decoration?.enabledBorder,
                border: decoration?.border,
                enabled: decoration?.enabled ?? enabled ?? true,
                semanticCounterText: decoration?.semanticCounterText,
                alignLabelWithHint: decoration?.alignLabelWithHint,
                constraints: decoration?.constraints,
              ),
              keyboardType: keyboardType,
              textCapitalization: textCapitalization,
              textInputAction: textInputAction,
              style: style,
              strutStyle: strutStyle,
              textDirection: textDirection,
              textAlign: textAlign,
              textAlignVertical: textAlignVertical,
              autofocus: autofocus,
              readOnly: readOnly,
              toolbarOptions: toolbarOptions,
              showCursor: showCursor,
              obscuringCharacter: replacementCharacter,
              obscureText: !state._showPassword,
              autocorrect: autocorrect,
              smartDashesType: smartDashesType,
              smartQuotesType: smartQuotesType,
              enableSuggestions: enableSuggestions,
              maxLengthEnforcement: maxLengthEnforcement,
              maxLines: maxLines,
              minLines: minLines,
              expands: expands,
              maxLength: maxLength,
              onChanged: onChanged,
              onTap: onTap,
              onTapOutside: onTapOutside,
              onEditingComplete: onEditingComplete,
              onFieldSubmitted: onFieldSubmitted,
              onSaved: onSaved,
              validator: validator,
              inputFormatters: inputFormatters,
              enabled: enabled,
              cursorWidth: cursorWidth,
              cursorHeight: cursorHeight,
              cursorRadius: cursorRadius,
              cursorColor: cursorColor,
              keyboardAppearance: keyboardAppearance,
              scrollPadding: scrollPadding,
              enableInteractiveSelection: enableInteractiveSelection,
              selectionControls: selectionControls,
              buildCounter: buildCounter,
              scrollPhysics: scrollPhysics,
              autofillHints: autofillHints,
              autovalidateMode: autovalidateMode,
              scrollController: scrollController,
              restorationId: restorationId,
              enableIMEPersonalizedLearning: enableIMEPersonalizedLearning,
              mouseCursor: mouseCursor,
              contextMenuBuilder: contextMenuBuilder,
              spellCheckConfiguration: spellCheckConfiguration,
              magnifierConfiguration: magnifierConfiguration,
              undoController: undoController,
              onAppPrivateCommand: onAppPrivateCommand,
              cursorOpacityAnimates: cursorOpacityAnimates,
              selectionHeightStyle: selectionHeightStyle,
              selectionWidthStyle: selectionWidthStyle,
              dragStartBehavior: dragStartBehavior,
              contentInsertionConfiguration: contentInsertionConfiguration,
              clipBehavior: clipBehavior,
              scribbleEnabled: scribbleEnabled,
              canRequestFocus: canRequestFocus,
            );
          },
        );

  final bool showPassword;

  @override
  FormFieldState<String> createState() => _PasswordFormFieldState();
}

class _PasswordFormFieldState extends FormFieldState<String> {
  PasswordFormField get _passwordFormField => super.widget as PasswordFormField;

  bool _showPassword = false;

  void _toggleDisplayPassword() {
    setState(() {
      _showPassword = !_showPassword;
    });
  }

  @override
  void initState() {
    super.initState();

    _showPassword = _passwordFormField.showPassword;
  }
}
