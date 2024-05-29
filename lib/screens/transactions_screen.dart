import 'package:flutter/material.dart';
import 'package:makobili/components/add_transaction_form.dart';

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
          title: const Text('Transactions'),
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

class CategoriesTab extends StatelessWidget {
  const CategoriesTab({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text(
        'Categories Page',
        style: TextStyle(fontSize: 20),
      ),
    );
  }
}

class ThisMonthTab extends StatelessWidget {
  const ThisMonthTab({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text(
        'This Month Page',
        style: TextStyle(fontSize: 20),
      ),
    );
  }
}

class AllTab extends StatelessWidget {
  const AllTab({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text(
        'All Transactions Page',
        style: TextStyle(fontSize: 20),
      ),
    );
  }
}
