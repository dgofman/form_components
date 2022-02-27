import 'package:flutter/material.dart';

class FormModel {
  final GlobalKey<FormFieldState> key;
  final String type;
  final String? dataField;
  final dynamic value;
  final bool required;
  final FormFieldValidator<String>? validator;
  FormModel(this.type, {
    GlobalKey<FormFieldState>? key,
    bool? required,
    String? requiredError,
    FormFieldValidator<String>? validator,
    this.dataField,
    this.value
  }) :
    key = key ?? GlobalKey<FormFieldState>(),
    required = required ?? false,
    validator = (validator == null && required == true) ? requiredValidator(requiredError) : validator;

  static String? Function(String?)? requiredValidator(String? requiredError) => (value) {
    if (value != null && value.trim() != '') {
        return null;
      }
      return requiredError ?? 'Required field.';
  };
}