import 'package:flutter/material.dart';
import 'package:form_components/form_autocomplete.dart';
import 'package:form_components/form_checkbox.dart';
import 'package:form_components/form_dropdown.dart';
import 'package:form_components/form_model.dart';
import 'package:form_components/form_switch.dart';
import 'package:form_components/form_email_field.dart';
import 'package:form_components/form_password_field.dart';

void main() {
  runApp(MaterialApp(home: MyApp()));
}

class MyApp extends StatelessWidget {
  final formKey = GlobalKey<FormState>();

  MyApp({Key? key}) : super(key: key);

  static final List<FormModel> components = [
    FormModel('autocomplete', value: 'Option2', dataField: 'value1'),
    FormModel('dropdown', value: 'opt2', dataField: 'value2'),
    FormModel('email', value: 'email@domain.com', dataField: 'value3'),
    FormModel('password', value: '12345', required: true, dataField: 'value4'),
    FormModel('switch', value: true, dataField: 'value5'),
    FormModel('checkbox', value: true, dataField: 'value6'),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Form(
        key: formKey,
        child: Padding(
          padding: const EdgeInsets.all(40),
          child: Column(
            children: [
              Wrap(
                runSpacing: 10,
                children: MyApp.components.map((e) => createComponent(e)).toList(),
              ),
              ElevatedButton(
                  child: const Text('Submit'),
                  onPressed: () {
                    if (formKey.currentState!.validate()) {
                      final json = {};
                      final info = {};
                      for (var f in MyApp.components) {
                        json[f.dataField] = info[f.type] = f.key.currentState?.value;
                      }
                      debugPrint(json.toString());
                      debugPrint(info.toString());
                      showDialog(
                        context: context,
                        builder: (context) {
                          return AlertDialog(
                            content: SizedBox(
                              height: 140,
                              child: Column(
                                children: [
                                  const Text('JSON Data:', style: TextStyle(fontWeight: FontWeight.bold)),
                                  Text(json.toString()),
                                  const SizedBox(height: 20),
                                  const Text('Component Data:', style: TextStyle(fontWeight: FontWeight.bold)),
                                  Text(info.toString()),
                                ],
                              ),
                            ),
                          );
                        },
                      );
                      formKey.currentState!.reset();
                    }
                  }),
            ],
          ),
        ),
      ),
    );
  }

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
}
