# form_components

- One part of fragmentation in Flutter is getting data from Flutter components.
  The Flutter team suggests a workaround by creating a type-controller and subscribe to receive data.
  https://docs.flutter.dev/cookbook/forms/retrieve-input
  A couple of problems with this solution: the number of lines increases significantly,
  plus you have to remember to destroy the controller(s) in your Statefull widget,
  otherwise there will be consequences such as memory leaks.
  You may also need to manually handle reset default values in your components. 
  And finally, this solution may not work in the List or DataTable components.
  An implementation of a form component that solves such problems with the FormField,
  which is only implemented in DropdownButtonFormField and TextFormField flutter library.

## Simple example

Also see [example project](https://github.com/dgofman/form_components/blob/master/test/main.dart) which contains working demo.

```dart
Widget createComponent(FormModel model) {
  switch (model.type) {
    case 'email':
      return FormEmailField(key: model.key, initialValue: model.value, validator: model.validator);
    case 'password':
      return FormPasswordField(key: model.key, initialValue: model.value, validator: model.validator);
    case 'switch':
      return FormSwitch(key: model.key, initialValue: model.value);
    case 'checkbox':
      return FormCheckbox(key: model.key, initialValue: model.value);
    case 'dropdown':
      return FormDropdown(
        key: model.key,
        initialValue: model.value,
        items: const [
          {'opt1': 'Option1'},
          {'opt2': 'Option2'},
          {'opt3': 'Option3'}
        ],
        onSelected: (selection) {
          debugPrint('You just selected $selection');
        },
      );
    case 'autocomplete':
      return FormAutocomplete<String>(
        key: model.key,
        initialValue: model.value,
        optionsBuilder: (TextEditingValue textEditingValue) {
          return ['Option1', 'Option2', 'Option3'].where((String option) {
            return option.toLowerCase().contains(textEditingValue.text.toLowerCase());
          });
        },
        onSelected: (String selection) {
          debugPrint('You just selected $selection');
        },
      );
  }
  return Container();
}
```
```dart
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Form(
        key: formKey,
        ...
            ElevatedButton(
              child: const Text('Submit'),
              onPressed: () {
              if (formKey.currentState!.validate()) {
                ...
                formKey.currentState!.reset();
              }
```