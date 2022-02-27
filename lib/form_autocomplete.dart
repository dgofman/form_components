import 'package:flutter/material.dart';

class FormAutocomplete<T extends Object> extends FormField<T> {

  FormAutocomplete({
    Key? key,
    required AutocompleteOptionsBuilder<T> optionsBuilder,
    AutocompleteOptionToString<T>? displayStringForOption,
    AutocompleteFieldViewBuilder? fieldViewBuilder,
    AutocompleteOnSelected<T>? onSelected,
    double optionsMaxHeight = 200.0,
    AutocompleteOptionsViewBuilder<T>? optionsViewBuilder,
    T? initialValue,
  }) : super(
      key: key,
      initialValue: initialValue,
      builder: (FormFieldState<T> field) {
        final _FormAutocompleteState state = field as _FormAutocompleteState;
        void onChangedHandler(T value) {
          state.didChange(value);
          if (onSelected != null) {
            onSelected(state.value);
          }
        }
        return Autocomplete<T>(
            key: state.key,
            optionsBuilder: optionsBuilder,
            displayStringForOption: displayStringForOption ?? RawAutocomplete.defaultStringForOption,
            fieldViewBuilder: fieldViewBuilder ?? Autocomplete(optionsBuilder: optionsBuilder).fieldViewBuilder,
            optionsMaxHeight: optionsMaxHeight,
            optionsViewBuilder: optionsViewBuilder,
            initialValue: TextEditingValue(text: state.value ?? ''),
            onSelected: (v) {
              onChangedHandler(v);
            }
          );
      }
  );

  @override
  FormFieldState<T> createState() => _FormAutocompleteState();
}

class _FormAutocompleteState<T> extends FormFieldState<T> {
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