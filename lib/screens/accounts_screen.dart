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
    return SizedBox(
      width: 350,
      child: Card(
        color: Provider.of<ThemeProvider>(context).themeData.primaryColor,
        margin: const EdgeInsets.all(8),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(4.0),
          side: const BorderSide(color: Colors.black87, width: 1.0),
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
