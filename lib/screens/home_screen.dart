import 'package:flutter/material.dart';
import 'package:makobili/components/balance_card.dart';
import 'package:makobili/components/transaction_card.dart';
import 'package:makobili/models/account.dart';
import 'package:makobili/models/transaction.dart';
import 'package:makobili/utils/database_helper.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<Account> _accounts = [];
  List<BankTransaction> _transactions = [];

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

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 200,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: _accounts.length,
            itemBuilder: (context, index) {
              return BalanceCard(
                index: index,
                accountName: _accounts[index].name,
                accountNumber: _accounts[index].accountNumber,
                institution: _accounts[index].institution,
                accountType: _accounts[index].type,
              );
            },
          ),
        ),
        Expanded(
          child: ListView.builder(
            itemCount: _transactions.length,
            itemBuilder: (context, index) {
              return Card(
                elevation: 5,
                margin: const EdgeInsets.all(10),
                color: _transactions[index].direction == 'in'
                    ? Colors.green
                    : Colors.red,
                child: ListTile(
                  visualDensity: VisualDensity(
                    horizontal: 0,
                    vertical: -4,
                  ),
                  leading: Text(_transactions[index].direction),
                  title: Text(_transactions[index].description),
                  subtitle: Text(_transactions[index].amount.toString()),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
