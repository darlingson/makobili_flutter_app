import 'package:flutter/material.dart';
import 'package:makobili/models/transaction.dart';
import 'package:makobili/utils/database_helper.dart';

class ThisMonthTab extends StatefulWidget {
  const ThisMonthTab({Key? key}) : super(key: key);

  @override
  State<ThisMonthTab> createState() => _ThisMonthTabState();
}

class _ThisMonthTabState extends State<ThisMonthTab> {
  List<BankTransaction> _transactions = [];

  Future<void> _fetchTransactions() async {
    final transactions = await DatabaseHelper.instance.fetchTransactions();
    //iterate through the list of transactions and only keep those that are from this month
    List<BankTransaction> filteredTransactions = [];
    for (var transaction in transactions) {
      if (transaction.date.month == DateTime.now().month) {
        filteredTransactions.add(transaction);
      }
    }

    if (filteredTransactions.isNotEmpty) {
      _transactions = filteredTransactions;
    } else {
      _transactions = [];
    }
    setState(() {
      _transactions = transactions;
    });
  }

  @override
  void initState() {
    super.initState();
    _fetchTransactions();
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
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
            }));
  }
}
