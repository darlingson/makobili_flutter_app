import 'package:flutter/material.dart';
import 'package:makobili/components/add_account_form.dart';
import 'package:makobili/components/balance_card.dart';
import 'package:makobili/models/account.dart';

class AccountsScreen extends StatefulWidget {
  const AccountsScreen({Key? key});

  @override
  State<AccountsScreen> createState() => _AccountsScreenState();
}

class _AccountsScreenState extends State<AccountsScreen> {
  List<Account> accounts = [];
  void _showAddAccountDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
            title: const Text('Add Transaction'),
            content: AddAccountForm(),
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
    return Scaffold(
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            _showAddAccountDialog(context);
          },
          child: const Icon(Icons.add),
        ),
        body: Expanded(
          child: ListView.builder(
            itemBuilder: (context, index) {
              return BalanceCard(
                index: index,
                accountName: 'Account ${index + 1}',
                accountNumber: '1234 5678 9012 345${index + 1}',
                institution: 'Bank ${index + 1}',
                accountType: 'Savings',
              );
            },
            itemCount: 10,
          ),
        ));
  }
}
