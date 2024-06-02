import 'package:flutter/material.dart';
import 'package:makobili/components/add_account_form.dart';
import 'package:makobili/models/account.dart';
import 'package:makobili/screens/account_info_scrren.dart';
import 'package:makobili/themes/theme_provider.dart';
import 'package:makobili/utils/database_helper.dart';
import 'package:provider/provider.dart';

class AccountsScreen extends StatefulWidget {
  const AccountsScreen({Key? key});

  @override
  State<AccountsScreen> createState() => _AccountsScreenState();
}

class _AccountsScreenState extends State<AccountsScreen> {
  List<Account> _accounts = [];

  @override
  void initState() {
    super.initState();
    _fetchAccounts();
  }

  Future<void> _fetchAccounts() async {
    final accounts = await DatabaseHelper.instance.fetchAccounts();
    setState(() {
      _accounts = accounts;
    });
  }

  void _showAddAccountDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
            title: const Text('Add Transaction'),
            content: const AddAccountForm(),
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
      body: ListView.builder(
        itemBuilder: (context, index) {
          return GestureDetector(
              onTap: () {
                // ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                //     content:
                //         Text('Account' + _accounts[index].name + ' clicled')));
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) =>
                        AccountInfoScreen(account: _accounts[index])));
              },
              child: AccountCard(
                index: index,
                accountName: _accounts[index].name,
                accountNumber: _accounts[index].accountNumber,
                institution: _accounts[index].institution,
                accountType: _accounts[index].type,
              ));
        },
        itemCount: _accounts.length,
      ),
    );
  }
}

class AccountCard extends StatelessWidget {
  final int index;
  final String accountName;
  final String accountNumber;
  final String institution;
  final String accountType;

  const AccountCard({
    Key? key,
    required this.index,
    required this.accountName,
    required this.accountNumber,
    required this.institution,
    required this.accountType,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8.0),
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [Colors.blue.shade300, Colors.blue.shade500],
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 2,
              blurRadius: 5,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                'Account Name: $accountName',
                style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.white),
              ),
              const SizedBox(height: 8),
              Text(
                'Account Number: $accountNumber',
                style: const TextStyle(fontSize: 14, color: Colors.white),
              ),
              const SizedBox(height: 8),
              Text(
                'Institution: $institution',
                style: const TextStyle(fontSize: 14, color: Colors.white),
              ),
              const SizedBox(height: 8),
              Text(
                'Account Type: $accountType',
                style: const TextStyle(fontSize: 14, color: Colors.white),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
