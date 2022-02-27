import 'package:flutter/material.dart';

class FormDropdown<T extends Object> extends FormField<T> {
  FormDropdown({
    Key? key,
    T? initialValue,
    required List<dynamic> items,
    ValueChanged<dynamic>? onSelected,
    Decoration? decoration,
    Color? borderColor,
    TextStyle? textStyle,
    bool keyIsValue = true})
      : super(
      key: key,
      initialValue: initialValue,
      builder: (FormFieldState<T> field) {
        final _FormDropdownState state = field as _FormDropdownState;
        void onChangedHandler(T value) {
          state.didChange(value);
          if (onSelected != null) {
            onSelected(value);
          }
        }
        return Container(
            decoration: decoration ?? BoxDecoration(
                border: Border.all(color: borderColor ?? const Color(0xff999999), width: 1),
                borderRadius: const BorderRadius.all(Radius.circular(4))
            ),
            child: DropdownButton<dynamic>(
              key: state.key,
              value: state.value,
              underline: Container(),
              isExpanded: true,
              onChanged: (dynamic newValue) {
                onChangedHandler(newValue);
              },
              items: items.map((val) {
                final value = keyIsValue ? val.keys.first : val.values.first;
                return DropdownMenuItem(
                  value: value,
                  child: Text('${keyIsValue ? val.values.first : val.keys.first}',
                      style: textStyle ?? const TextStyle(fontSize: 14)),
                  enabled: value != null,
                );
              }).toList(),
            ));
      });

  @override
  FormFieldState<T> createState() => _FormDropdownState();
}

class _FormDropdownState<T extends Object> extends FormFieldState<T> {
  Key? key;

  @override
  void initState() {
    super.initState();
    key = UniqueKey();
  }

  @override
  void reset() {
    super.reset();
    key = UniqueKey();
  }
}
