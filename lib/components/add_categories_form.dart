import 'package:flutter/material.dart';
import 'package:makobili/models/category.dart';
import 'package:makobili/utils/database_helper.dart';

class AddCategoriesForm extends StatefulWidget {
  const AddCategoriesForm({super.key});

  @override
  State<AddCategoriesForm> createState() => _AddCategoriesFormState();
}

class _AddCategoriesFormState extends State<AddCategoriesForm> {
  final _formKey = GlobalKey<FormState>();
  String _name = '';
  Future<void> _saveCategory() async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      final category = Category(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        name: _name,
      );
      await DatabaseHelper.instance.insertCategory(category);
      Navigator.of(context).pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Form(
        key: _formKey,
        child: SingleChildScrollView(
            child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(children: [
                  TextFormField(
                    decoration: const InputDecoration(
                      labelText: 'Category Name',
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter category name';
                      }
                      return null;
                    },
                    onSaved: (value) {
                      _name = value!;
                    },
                  ),
                  const SizedBox(height: 16.0),
                  ElevatedButton(
                    onPressed: _saveCategory,
                    child: const Text('Save'),
                  )
                ]))));
  }
}
