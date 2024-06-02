import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:makobili/models/transaction.dart';
import 'package:makobili/utils/database_helper.dart';

class EditTransactionForm extends StatefulWidget {
  final BankTransaction transaction;

  const EditTransactionForm({Key? key, required this.transaction})
      : super(key: key);

  @override
  _EditTransactionFormState createState() => _EditTransactionFormState();
}

class _EditTransactionFormState extends State<EditTransactionForm> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _descriptionController;
  late TextEditingController _amountController;
  late TextEditingController _dateController;
  late TextEditingController _accountIdController;
  String _direction = 'in';
  List<String> _categories = [];
  String? _selectedCategory;

  @override
  void initState() {
    super.initState();
    _descriptionController =
        TextEditingController(text: widget.transaction.description);
    _amountController =
        TextEditingController(text: widget.transaction.amount.toString());
    _dateController = TextEditingController(
        text: DateFormat('yyyy-MM-dd').format(widget.transaction.date));
    _accountIdController =
        TextEditingController(text: widget.transaction.accountId.toString());
    _direction = widget.transaction.direction;
    _selectedCategory = widget.transaction.category;

    _fetchCategories();
  }

  Future<void> _fetchCategories() async {
    final categories = await DatabaseHelper.instance.fetchCategories();
    setState(() {
      _categories = categories.map((category) => category.name).toList();

      // Ensure the selected category is part of the list
      if (!_categories.contains(_selectedCategory)) {
        _selectedCategory = _categories.isNotEmpty ? _categories.first : null;
      }
    });
  }

  @override
  void dispose() {
    _descriptionController.dispose();
    _amountController.dispose();
    _dateController.dispose();
    _accountIdController.dispose();
    super.dispose();
  }

  Future<void> _updateTransaction() async {
    if (_formKey.currentState!.validate()) {
      final updatedTransaction = BankTransaction(
        id: widget.transaction.id,
        description: _descriptionController.text,
        amount: double.parse(_amountController.text),
        date: DateTime.parse(_dateController.text),
        accountId: widget.transaction.accountId,
        category: _selectedCategory!,
        direction: _direction,
      );

      await DatabaseHelper.instance.updateTransaction(updatedTransaction);
      Navigator.of(context).pop(true); // Return true to indicate success
    }
  }

  Future<void> _deleteTransaction() async {
    await DatabaseHelper.instance.deleteTransaction(widget.transaction.id);
    Navigator.of(context).pop(true); // Return true to indicate success
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: widget.transaction.date,
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );
    if (picked != null && picked != widget.transaction.date) {
      setState(() {
        _dateController.text = DateFormat('yyyy-MM-dd').format(picked);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit Transaction'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: <Widget>[
              TextFormField(
                controller: _descriptionController,
                decoration: const InputDecoration(labelText: 'Description'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a description';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _amountController,
                decoration: const InputDecoration(labelText: 'Amount'),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter an amount';
                  }
                  if (double.tryParse(value) == null) {
                    return 'Please enter a valid number';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _dateController,
                decoration: const InputDecoration(
                  labelText: 'Date',
                  suffixIcon: Icon(Icons.calendar_today),
                ),
                readOnly: true,
                onTap: () => _selectDate(context),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please select a date';
                  }
                  return null;
                },
              ),
              DropdownButtonFormField<String>(
                value: _selectedCategory,
                decoration: const InputDecoration(labelText: 'Category'),
                items: _categories.map((category) {
                  return DropdownMenuItem<String>(
                    value: category,
                    child: Text(category),
                  );
                }).toList(),
                onChanged: (newValue) {
                  setState(() {
                    _selectedCategory = newValue;
                  });
                },
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please select a category';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _accountIdController,
                decoration: const InputDecoration(labelText: 'Account ID'),
                keyboardType: TextInputType.number,
                readOnly: true,
              ),
              DropdownButtonFormField<String>(
                value: _direction,
                decoration: const InputDecoration(labelText: 'Direction'),
                items: <String>['in', 'out'].map((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
                onChanged: (newValue) {
                  setState(() {
                    _direction = newValue!;
                  });
                },
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please select a direction';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: _updateTransaction,
                child: const Text('Update Transaction'),
              ),
              const SizedBox(height: 10),
              ElevatedButton(
                onPressed: _deleteTransaction,
                style: ElevatedButton.styleFrom(
                  primary: Colors.red,
                ),
                child: const Text('Delete Transaction'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
