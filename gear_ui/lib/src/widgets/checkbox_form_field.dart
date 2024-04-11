import 'package:flutter/material.dart';

class CheckboxFormField extends FormField<bool> {
  static const double _checkboxSize = 30;

  CheckboxFormField({
    super.key,
    super.onSaved,
    super.validator,
    super.autovalidateMode,
    super.restorationId,
    super.initialValue,
    required ValueChanged<bool?>? onChanged,
    Text? title,
    Widget? otherElement,
    bool reversePosition = false,
    bool tristate = false,
    bool? enabled,
  }) : super(
          enabled: enabled ?? true,
          builder: (FormFieldState<bool> state) {
            final Widget checkboxElement = SizedBox(
              width: _checkboxSize,
              height: _checkboxSize,
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
