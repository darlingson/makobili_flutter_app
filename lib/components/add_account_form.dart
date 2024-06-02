import 'package:flutter/material.dart';
import '../models/account.dart';
import '../models/institution.dart';
import '../utils/database_helper.dart';

class AddAccountForm extends StatefulWidget {
  const AddAccountForm({super.key});

  @override
  _AddAccountFormState createState() => _AddAccountFormState();
}

class _AddAccountFormState extends State<AddAccountForm> {
  final _formKey = GlobalKey<FormState>();

  String _name = '';
  String _accountNumber = '';
  String? _selectedInstitution;
  String _type = '';
  double _balance = 0.0;
  List<Institution> _institutions = [];

  @override
  void initState() {
    super.initState();
    _fetchInstitutions();
  }

  Future<void> _fetchInstitutions() async {
    final institutions = await DatabaseHelper.instance.fetchInstitutions();
    setState(() {
      _institutions = institutions;
    });
  }

  Future<void> _saveAccount() async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();

      final account = Account(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        name: _name,
        accountNumber: _accountNumber,
        institution: _selectedInstitution!,
        type: _type,
        balance: _balance,
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
                decoration: const InputDecoration(labelText: 'Name'),
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
                decoration: const InputDecoration(labelText: 'Account Number'),
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
              DropdownButtonFormField<String>(
                decoration: const InputDecoration(labelText: 'Institution'),
                value: _selectedInstitution,
                items: _institutions.map((Institution institution) {
                  return DropdownMenuItem<String>(
                    value: institution.id,
                    child: Text(institution.name),
                  );
                }).toList(),
                onChanged: (value) {
                  setState(() {
                    _selectedInstitution = value;
                  });
                },
                validator: (value) {
                  if (value == null) {
                    return 'Please select an institution';
                  }
                  return null;
                },
                onSaved: (value) {
                  _selectedInstitution = value!;
                },
              ),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Type'),
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
                decoration: const InputDecoration(labelText: 'Balance'),
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
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: _saveAccount,
                child: const Text('Add Account'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
