import 'package:flutter/material.dart';

class CheckboxFormField extends FormField<bool> {
  CheckboxFormField({
    super.key,
    required ValueChanged<bool?>? onChanged,
    bool checked = false,
    Widget? title,
    bool titleLeft = false,
    bool? enabled,
    bool tristate = false,
    FormFieldSetter<bool>? onSaved,
    FormFieldValidator<bool>? validator,
  }) : super(
          onSaved: onSaved,
          validator: validator,
          initialValue: checked,
          builder: (FormFieldState<bool> state) {
            final checkBox = Checkbox.adaptive(
              value: state.value,
              onChanged: enabled ?? onChanged != null
                  ? (value) {
                      onChanged?.call(value);
                      state.didChange(value);
                    }
                  : null,
              tristate: tristate,
            );

            return MergeSemantics(
              child: ListTile(
                title: title,
                subtitle: state.hasError
                    ? Builder(
                        builder: (context) {
                          return Text(
                            state.errorText ?? "",
                          );
                        },
                      )
                    : null,
                leading: titleLeft ? null : checkBox,
                trailing: titleLeft ? checkBox : null,
                dense: state.hasError,
                enabled: enabled ?? onChanged != null,
                onTap: onChanged != null
                    ? () {
                        print(state.hasError);
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
                        onChanged(newValue);
                      }
                    : null,
              ),
            );
          },
        );
}
