import 'package:flutter/material.dart';

class FormEmailField extends FormField<String> {
  FormEmailField(
      {Key? key,
      EdgeInsets? padding,
      String? errorText,
      String? labelText,
      String? hintText,
      FocusNode? focusNode,
      Widget? prefixIcon,
      String? initialValue,
      ValueChanged<String>? onChanged,
      FormFieldValidator<String>? validator,
      ValueChanged<String>? onSubmitted,
      InputBorder? border})
      : super(
            key: UniqueKey(),
            builder: (FormFieldState<String> field) {
              return TextFormField(
                key: key,
                autofocus: true,
                initialValue: initialValue,
                keyboardType: TextInputType.emailAddress,
                autofillHints: const [AutofillHints.email],
                onFieldSubmitted: onSubmitted,
                onChanged: onChanged,
                focusNode: focusNode,
                validator: validator ?? defaultEmailValidattor(errorText),
                decoration: InputDecoration(
                  border: border ?? const OutlineInputBorder(),
                  prefixIcon: prefixIcon ?? const Icon(Icons.markunread_outlined),
                  labelText: labelText ?? 'Email',
                  hintText: hintText ?? 'Enter valid email',
                ),
              );
            });

  static String? Function(String?)? defaultEmailValidattor(String? errorText) => (value) {
        String pattern = r'.+@.+\..+'; //Has at least one character before the @, before the period and after it
        RegExp regex = RegExp(pattern);
        if (!regex.hasMatch(value!)) {
          return errorText ?? 'Invalid email';
        } else {
          return null;
        }
      };
}
