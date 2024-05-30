import 'package:flutter/material.dart';
import 'package:makobili/models/account.dart';
import '../models/transaction.dart';
import '../models/category.dart';
import '../utils/database_helper.dart';
import 'package:intl/intl.dart';

class AddTransactionForm extends StatefulWidget {
  @override
  _AddTransactionFormState createState() => _AddTransactionFormState();
}

class _AddTransactionFormState extends State<AddTransactionForm> {
  final _formKey = GlobalKey<FormState>();

  String? _accountId;
  String _description = '';
  double _amount = 0.0;
  String? _selectedCategory;
  String _direction = '';
  DateTime _date = DateTime.now();

  final DateFormat _dateFormat = DateFormat('yyyy-MM-dd');
  List<Category> _categories = [];
  List<Account> _accountIDs = [];
  @override
  void initState() {
    super.initState();
    _fetchCategories();
    _fetchAccounts();
  }

  Future<void> _fetchCategories() async {
    final categories = await DatabaseHelper.instance.fetchCategories();
    setState(() {
      _categories = categories;
    });
  }

  Future<void> _fetchAccounts() async {
    final accounts = await DatabaseHelper.instance.fetchAccounts();
    print(accounts[0].toJson());
    setState(() {
      _accountIDs = accounts;
    });
  }

  Future<void> _saveTransaction() async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();

      final transaction = BankTransaction(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        accountId: _accountId!,
        description: _description,
        amount: _amount,
        category: _selectedCategory!,
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
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: <Widget>[
              DropdownButtonFormField<String>(
                decoration: InputDecoration(labelText: 'Accounts'),
                value: _accountId,
                items: _accountIDs.map((Account account) {
                  print('category: $account');
                  return DropdownMenuItem<String>(
                    value: account.id,
                    child: Text(account.name),
                  );
                }).toList(),
                onChanged: (value) {
                  setState(() {
                    _accountId = value;
                  });
                },
                validator: (value) {
                  if (value == null) {
                    return 'Please select a Account';
                  }
                  return null;
                },
                onSaved: (value) {
                  _accountId = value!;
                },
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Description'),
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
                decoration: InputDecoration(labelText: 'Amount'),
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
              DropdownButtonFormField<String>(
                decoration: InputDecoration(labelText: 'Category'),
                value: _selectedCategory,
                items: _categories.map((Category category) {
                  return DropdownMenuItem<String>(
                    value: category.id,
                    child: Text(category.name),
                  );
                }).toList(),
                onChanged: (value) {
                  setState(() {
                    _selectedCategory = value;
                  });
                },
                validator: (value) {
                  if (value == null) {
                    return 'Please select a category';
                  }
                  return null;
                },
                onSaved: (value) {
                  _selectedCategory = value!;
                },
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Direction'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter the transaction direction';
                  }
                  return null;
                },
                onSaved: (value) {
                  _direction = value!;
                },
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Date'),
                controller:
                    TextEditingController(text: _dateFormat.format(_date)),
                readOnly: true,
                onTap: () async {
                  DateTime? pickedDate = await showDatePicker(
                    context: context,
                    initialDate: _date,
                    firstDate: DateTime(2000),
                    lastDate: DateTime(2101),
                  );
                  if (pickedDate != null && pickedDate != _date)
                    setState(() {
                      _date = pickedDate;
                    });
                },
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: _saveTransaction,
                child: Text('Add Transaction'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
