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
    List<BankTransaction> filteredTransactions =
        transactions.where((transaction) {
      return transaction.date.month == DateTime.now().month &&
          transaction.date.year == DateTime.now().year;
    }).toList();

    setState(() {
      _transactions = filteredTransactions;
    });
  }

  @override
  void initState() {
    super.initState();
    _fetchTransactions();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
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
                  visualDensity: const VisualDensity(
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
