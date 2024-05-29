import 'package:flutter/material.dart';
import 'package:makobili/components/add_account_form.dart';
import 'package:makobili/models/account.dart';
import 'package:makobili/utils/database_helper.dart';

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
    print('accounts: $accounts');
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
      body: ListView.builder(
        itemBuilder: (context, index) {
          return AccountCard(
            index: index,
            accountName: _accounts[index].name,
            accountNumber: _accounts[index].accountNumber,
            institution: _accounts[index].institution,
            accountType: _accounts[index].type,
          );
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
    return SizedBox(
      width: 350,
      child: Card(
        color: Colors.blue[100],
        elevation: 5,
        margin: const EdgeInsets.all(8),
        shape: RoundedRectangleBorder(
          borderRadius:
              BorderRadius.circular(4.0), // Small radius for minimal rounding
          side: const BorderSide(color: Colors.black87, width: 1.0), // Border
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text('Account Name: $accountName',
                  style: const TextStyle(fontSize: 16)),
              Text('Account Number: $accountNumber',
                  style: const TextStyle(fontSize: 16)),
              Text('Institution: $institution',
                  style: const TextStyle(fontSize: 16)),
              Text('Account Type: $accountType',
                  style: const TextStyle(fontSize: 16)),
            ],
          ),
        ),
      ),
    );
  }
}
