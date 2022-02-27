import 'package:flutter/material.dart';

class FormSwitch extends FormField<bool> {
  FormSwitch({
    Key? key,
    bool? initialValue,
    ValueChanged<bool>? onChanged,
    List<String>? labels,
  }) : super(
      key: key,
      initialValue: initialValue ?? false,
      builder: (FormFieldState<bool> field) {
        final _FormSwitchState state = field as _FormSwitchState;
        void onChangedHandler(bool value) {
          state.didChange(value);
          if (onChanged != null) {
            onChanged(value);
          }
        }
        return Row(children:[
          Switch(
              value: state.value ?? false,
              onChanged: (v) {
                onChangedHandler(v);
              }
          ),
          if (state.value == true && labels != null && labels.isNotEmpty)
            Text(labels[0])
          else if (state.value != true && labels != null && labels.length > 1)
            Text(labels[1])
        ]);
      }
  );

  @override
  FormFieldState<bool> createState() => _FormSwitchState();
}

class _FormSwitchState extends FormFieldState<bool> {
}