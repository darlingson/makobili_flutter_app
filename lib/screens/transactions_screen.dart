import 'package:flutter/material.dart';
import 'package:makobili/components/add_transaction_form.dart';
import 'package:makobili/components/trans_asctions_tabs/AllTab.dart';
import 'package:makobili/components/trans_asctions_tabs/CategoriesTab.dart';
import 'package:makobili/components/trans_asctions_tabs/ThisMonthTab.dart';

class TransactionsScreen extends StatelessWidget {
  const TransactionsScreen({Key? key}) : super(key: key);

  void _showAddTransactionDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
            title: const Text('Add Transaction'),
            content: AddTransactionForm(),
            actions: <Widget>[
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text('Cancel'),
              ),
            ]);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          title: const Text(
            'Transactions',
            style: TextStyle(fontSize: 16),
          ),
          bottom: const TabBar(
            tabs: [
              Tab(text: 'Categories'),
              Tab(text: 'This Month'),
              Tab(text: 'All'),
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            _showAddTransactionDialog(context);
          },
          child: const Icon(Icons.add),
        ),
        body: const TabBarView(
          children: [
            CategoriesTab(),
            ThisMonthTab(),
            AllTab(),
          ],
        ),
      ),
    );
  }
}
