import 'package:flutter/material.dart';

class CheckboxFormField extends FormField<bool> {
  static const double checkboxSize = 30;

  CheckboxFormField({
    super.key,
    bool checked = false,
    required ValueChanged<bool?>? onChanged,
    // MouseCursor? mouseCursor,
    // Color? activeColor,
    // MaterialStateProperty<Color?>? fillColor,
    Text? title,
    Widget? otherElement,
    bool reversePosition = false,
    bool tristate = false,
    bool? enabled,
    FormFieldSetter<bool>? onSaved,
    FormFieldValidator<bool>? validator,
    AutovalidateMode? autovalidateMode,
  }) : super(
          initialValue: checked,
          enabled: enabled ?? true,
          onSaved: onSaved,
          validator: validator,
          autovalidateMode: autovalidateMode,
          builder: (FormFieldState<bool> state) {
            final Widget checkboxElement = SizedBox(
              width: checkboxSize,
              height: checkboxSize,
              child: Checkbox.adaptive(
                value: state.value,
                isError: state.hasError,
                tristate: tristate,
                onChanged: enabled ?? onChanged != null
                    ? (value) {
                        state.didChange(value);
                        if (onChanged != null) {
                          onChanged(value);
                        }
                      }
                    : null,
              ),
            );

            final Widget titleElement = Builder(
              builder: (context) {
                TextStyle titleStyle = title?.style ?? const TextStyle();

                if (state.hasError) {
                  titleStyle = titleStyle.apply(
                    color: Theme.of(context).colorScheme.error,
                  );
                }

                return Text.rich(
                  title?.textSpan ?? TextSpan(text: title?.data),
                  key: title?.key,
                  style: titleStyle,
                  strutStyle: title?.strutStyle,
                  textAlign: title?.textAlign,
                  textDirection: title?.textDirection,
                  locale: title?.locale,
                  softWrap: title?.softWrap,
                  overflow: title?.overflow,
                  textScaleFactor: title?.textScaleFactor,
                  textScaler: title?.textScaler,
                  maxLines: title?.maxLines,
                  semanticsLabel: title?.semanticsLabel,
                  textWidthBasis: title?.textWidthBasis,
                  textHeightBehavior: title?.textHeightBehavior,
                  selectionColor: title?.selectionColor,
                );
              },
            );

            final Widget errorElement = Builder(
              builder: (context) {
                return Text(
                  state.errorText ?? "",
                  style: TextStyle(
                    fontSize: 12,
                    color: Theme.of(context).colorScheme.error,
                  ),
                );
              },
            );

            void handleOnTap() {
              bool? newValue;
              switch (state.value) {
                case true:
                  newValue = tristate ? null : false;
                  break;
                case false:
                  newValue = true;
                  break;
                case null:
                  newValue = false;
                  break;
              }
              state.didChange(newValue);
              onChanged?.call(newValue);
            }

            return MergeSemantics(
              child: ListTile(
                titleAlignment: state.hasError
                    ? ListTileTitleAlignment.top
                    : ListTileTitleAlignment.center,
                title: title != null ? titleElement : null,
                subtitle: state.hasError ? errorElement : null,
                leading: reversePosition ? otherElement : checkboxElement,
                trailing: reversePosition ? checkboxElement : otherElement,
                enabled: enabled ?? onChanged != null,
                onTap: onChanged != null ? handleOnTap : null,
              ),
            );
          },
        );
}
