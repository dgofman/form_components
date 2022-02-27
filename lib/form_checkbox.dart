import 'package:flutter/material.dart';

class FormCheckbox extends FormField<bool> {
  FormCheckbox({
    Key? key,
    bool? initialValue,
    ValueChanged<bool?>? onChanged,
    List<String>? labels,
  }) : super(
            key: key,
            initialValue: initialValue ?? false,
            builder: (FormFieldState<bool> field) {
              final _FormCheckboxState state = field as _FormCheckboxState;
              void onChangedHandler(bool? value) {
                state.didChange(value);
                if (onChanged != null) {
                  onChanged(value);
                }
              }

              return Checkbox(
                  value: state.value,
                  onChanged: (v) {
                    onChangedHandler(v);
                  });
            });

  @override
  FormFieldState<bool> createState() => _FormCheckboxState();
}

class _FormCheckboxState extends FormFieldState<bool> {
}
