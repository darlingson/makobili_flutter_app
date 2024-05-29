import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../models/transaction.dart';
import '../utils/database_helper.dart'; // Make sure to import your DatabaseHelper

class AddTransactionForm extends StatefulWidget {
  @override
  _AddTransactionFormState createState() => _AddTransactionFormState();
}

class _AddTransactionFormState extends State<AddTransactionForm> {
  final _formKey = GlobalKey<FormState>();

  String _accountId = '';
  String _description = '';
  double _amount = 0.0;
  String _category = '';
  String _direction = '';
  DateTime _date = DateTime.now();

  final DateFormat _dateFormat = DateFormat('yyyy-MM-dd');

  Future<void> _saveTransaction() async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();

      final transaction = BankTransaction(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        accountId: _accountId,
        description: _description,
        amount: _amount,
        category: _category,
        direction: _direction,
        date: _date,
      );

      await DatabaseHelper.instance.insertTransaction(transaction);

      Navigator.of(context).pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: <Widget>[
              TextFormField(
                decoration: const InputDecoration(labelText: 'Account ID'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter the account ID';
                  }
                  return null;
                },
                onSaved: (value) {
                  _accountId = value!;
                },
              ),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Description'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a description';
                  }
                  return null;
                },
                onSaved: (value) {
                  _description = value!;
                },
              ),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Amount'),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter an amount';
                  }
                  return null;
                },
                onSaved: (value) {
                  _amount = double.parse(value!);
                },
              ),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Category'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a category';
                  }
                  return null;
                },
                onSaved: (value) {
                  _category = value!;
                },
              ),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Direction'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a direction';
                  }
                  return null;
                },
                onSaved: (value) {
                  _direction = value!;
                },
              ),
              TextFormField(
                decoration: const InputDecoration(
                  labelText: 'Date',
                  hintText: 'YYYY-MM-DD',
                ),
                keyboardType: TextInputType.datetime,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a date';
                  }
                  try {
                    _date = _dateFormat.parse(value);
                  } catch (e) {
                    return 'Please enter a valid date';
                  }
                  return null;
                },
                onSaved: (value) {
                  _date = _dateFormat.parse(value!);
                },
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: _saveTransaction,
                child: const Text('Add Transaction'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
