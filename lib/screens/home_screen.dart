import 'package:flutter/material.dart';
import 'package:makobili/components/balance_card.dart';
import 'package:makobili/components/homescreen_add_actions_dialog.dart';
import 'package:makobili/components/transactions_card.dart';
import 'package:makobili/models/account.dart';
import 'package:makobili/models/transaction.dart';
import 'package:makobili/screens/account_info_screen.dart';
import 'package:makobili/utils/database_helper.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<Account> _accounts = [];
  List<BankTransaction> _transactions = [];
  DateTime now = DateTime.now();
  Future<void> _getAccounts() async {
    var accounts = await DatabaseHelper.instance.fetchAccounts();
    setState(() {
      _accounts = accounts;
    });
  }

  Future<void> _getTransactions() async {
    var transactions = await DatabaseHelper.instance.fetchTransactions();
    setState(() {
      _transactions = transactions;
    });
  }

  @override
  void initState() {
    super.initState();
    _getAccounts();
    _getTransactions();
  }

  void _showAddAccountDialog(BuildContext context) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return const AlertDialog(
            title: Text('Add'),
            content: HomeScreenAddActionsDialog(),
            contentPadding: EdgeInsets.zero,
          );
        });
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
        body: Column(
          children: [
            const SizedBox(
              height: 20,
              child: Text(
                "Accounts",
                textAlign: TextAlign.start,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Divider(
                color: Theme.of(context).primaryColor,
              ),
            ),
            SizedBox(
              height: 240,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: _accounts.length,
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
                      child: BalanceCard(
                        index: index,
                        accountName: _accounts[index].name,
                        accountNumber: _accounts[index].accountNumber,
                        institution: _accounts[index].institution,
                        accountType: _accounts[index].type,
                      ));
                },
              ),
            ),
            const SizedBox(
              height: 20,
              child: Text(
                "Recent Transactions",
                textAlign: TextAlign.start,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Divider(
                color: Theme.of(context).primaryColor,
              ),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: _transactions.length,
                itemBuilder: (context, index) {
                  return TransactionsCard(
                      direction: _transactions[index].direction,
                      description: _transactions[index].description,
                      amount: _transactions[index].amount,
                      date: _transactions[index].date);
                },
              ),
            ),
          ],
        ));
  }
}
