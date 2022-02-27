import 'package:flutter/material.dart';

class FormPasswordField extends FormField<String> {
  FormPasswordField(
      {Key? key,
      ScrollController? scrollController,
      String? errorText,
      String? labelText,
      String? hintText,
      FocusNode? focusNode,
      int minLength = 8,
      Widget? prefixIcon,
      String? initialValue,
      ValueChanged<String>? onChanged,
      final ValueChanged<String>? onSubmitted,
      FormFieldValidator<String>? validator,
      InputBorder? border})
      : super(
            key: UniqueKey(),
            builder: (FormFieldState<String> field) {
              final _FormPasswordFieldState state = field as _FormPasswordFieldState;
              return TextFormField(
                key: key,
                autofocus: true,
                initialValue: initialValue,
                autofillHints: const [AutofillHints.password],
                obscureText: state._obscurePassword,
                onFieldSubmitted: onSubmitted,
                onChanged: onChanged,
                focusNode: focusNode,
                validator: validator,
                onTap: () {
                  scrollController?.animateTo(scrollController.position.viewportDimension,
                      duration: const Duration(milliseconds: 200), curve: Curves.linear);
                },
                decoration: InputDecoration(
                    border: border ?? const OutlineInputBorder(),
                    prefixIcon: prefixIcon ?? const Icon(Icons.lock_open),
                    suffixIcon: MouseRegion(
                        cursor: SystemMouseCursors.click,
                        child: GestureDetector(
                          child:
                              state._obscurePassword ? const Icon(Icons.visibility_off) : const Icon(Icons.visibility),
                          onTap: () {
                            state.toggleObscure();
                          },
                        )),
                    labelText: labelText ?? 'Password',
                    hintText: hintText ?? 'Enter secure password'),
              );
            });

  @override
  FormFieldState<String> createState() => _FormPasswordFieldState();
}

class _FormPasswordFieldState extends FormFieldState<String> {
  bool _obscurePassword = true;

  void toggleObscure() {
    setState(() {
      _obscurePassword = !_obscurePassword;
    });
  }
}
