import 'package:flutter/material.dart';
import 'package:makobili/components/balance_card.dart';
import 'package:makobili/components/edit_transaction_form.dart';
import 'package:makobili/components/transactions_card.dart';
import 'package:makobili/models/account.dart';
import 'package:makobili/models/transaction.dart';
import 'package:makobili/utils/database_helper.dart';

class AccountInfoScreen extends StatefulWidget {
  final Account account;
  const AccountInfoScreen({super.key, required this.account});
  @override
  State<AccountInfoScreen> createState() => _AccountInfoScreenState();
}

class _AccountInfoScreenState extends State<AccountInfoScreen> {
  List<BankTransaction> _transactions = [];
  List<BankTransaction> _filterTransactions = [];
  final filterArray = [0, 1, 2, 3];
  var currentFilterIndex = 0;
  DateTime now = DateTime.now();

  @override
  void initState() {
    super.initState();
    _fetchTransactions();
  }

  Future<void> _fetchTransactions() async {
    final transactions = await DatabaseHelper.instance
        .fetchTransactionsByAccountId(widget.account.id);
    setState(() {
      _transactions = transactions;
      _filterTransactions = getFilteredTransactions('all');
    });
  }

  List<BankTransaction> getFilteredTransactions(String filter) {
    switch (filter) {
      case 'all':
        return _transactions;
      case 'thisMonth':
        return _transactions
            .where((transaction) => transaction.date.month == now.month)
            .toList();
      case 'in':
        return _transactions
            .where((transaction) => transaction.direction == 'in')
            .toList();
      case 'out':
        return _transactions
            .where((transaction) => transaction.direction == 'out')
            .toList();
      default:
        return _transactions;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(""),
        backgroundColor: Theme.of(context).primaryColor,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 10),
            child: BalanceCard(
              index: 0,
              accountName: widget.account.name,
              accountNumber: widget.account.accountNumber,
              institution: widget.account.institution,
              accountType: widget.account.type,
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  onPressed: () {
                    setState(() {
                      _filterTransactions = getFilteredTransactions('all');
                      currentFilterIndex = 0;
                    });
                  },
                  child: const Text('All'),
                  style: currentFilterIndex == 0
                      ? ButtonStyle(
                          backgroundColor:
                              MaterialStateProperty.all(Colors.blue))
                      : ButtonStyle(
                          backgroundColor:
                              MaterialStateProperty.all(Colors.white)),
                ),
                ElevatedButton(
                  onPressed: () {
                    setState(() {
                      _filterTransactions =
                          getFilteredTransactions('thisMonth');
                      currentFilterIndex = 1;
                    });
                  },
                  child: const Text('This Month'),
                  style: currentFilterIndex == 1
                      ? ButtonStyle(
                          backgroundColor:
                              MaterialStateProperty.all(Colors.blue))
                      : ButtonStyle(
                          backgroundColor:
                              MaterialStateProperty.all(Colors.white)),
                ),
                ElevatedButton(
                  onPressed: () {
                    setState(() {
                      _filterTransactions = getFilteredTransactions('in');
                      currentFilterIndex = 2;
                    });
                  },
                  child: const Text('In'),
                  style: currentFilterIndex == 2
                      ? ButtonStyle(
                          backgroundColor:
                              MaterialStateProperty.all(Colors.blue))
                      : ButtonStyle(
                          backgroundColor:
                              MaterialStateProperty.all(Colors.white)),
                ),
                ElevatedButton(
                  onPressed: () {
                    setState(() {
                      _filterTransactions = getFilteredTransactions('out');
                      currentFilterIndex = 3;
                    });
                  },
                  child: const Text('Out'),
                  style: currentFilterIndex == 3
                      ? ButtonStyle(
                          backgroundColor:
                              MaterialStateProperty.all(Colors.blue))
                      : ButtonStyle(
                          backgroundColor:
                              MaterialStateProperty.all(Colors.white)),
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.0),
            child: Divider(
              color: Colors.grey,
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: _filterTransactions.length,
              itemBuilder: (context, index) {
                return GestureDetector(
                    onTap: () {
                      showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              content: EditTransactionForm(
                                transaction: _filterTransactions[index],
                              ),
                            );
                          });
                    },
                    child: TransactionsCard(
                      direction: _filterTransactions[index].direction,
                      description: _filterTransactions[index].description,
                      amount: _filterTransactions[index].amount,
                      date: _filterTransactions[index].date,
                    ));
              },
            ),
          ),
        ],
      ),
    );
  }
}
