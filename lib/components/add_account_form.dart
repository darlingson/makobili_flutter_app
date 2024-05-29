import 'package:flutter/material.dart';
import '../models/account.dart';
import '../utils/database_helper.dart'; // Make sure to import your DatabaseHelper

class AddAccountForm extends StatefulWidget {
  @override
  _AddAccountFormState createState() => _AddAccountFormState();
}

class _AddAccountFormState extends State<AddAccountForm> {
  final _formKey = GlobalKey<FormState>();

  String _name = '';
  String _accountNumber = '';
  String _institution = '';
  String _type = '';
  double _balance = 0.0;

  Future<void> _saveAccount() async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();

      final account = Account(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        name: _name,
        accountNumber: _accountNumber,
        institution: _institution,
        type: _type,
        balance: _balance,
        transactions: [],
      );

      await DatabaseHelper.instance.insertAccount(account);

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
                decoration: InputDecoration(labelText: 'Name'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter the account name';
                  }
                  return null;
                },
                onSaved: (value) {
                  _name = value!;
                },
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Account Number'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter the account number';
                  }
                  return null;
                },
                onSaved: (value) {
                  _accountNumber = value!;
                },
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Institution'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter the institution';
                  }
                  return null;
                },
                onSaved: (value) {
                  _institution = value!;
                },
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Type'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter the account type';
                  }
                  return null;
                },
                onSaved: (value) {
                  _type = value!;
                },
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Balance'),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter the balance';
                  }
                  return null;
                },
                onSaved: (value) {
                  _balance = double.parse(value!);
                },
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: _saveAccount,
                child: Text('Add Account'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
