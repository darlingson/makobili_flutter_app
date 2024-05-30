import 'package:flutter/material.dart';
import 'package:makobili/models/transaction.dart';
import 'package:makobili/utils/database_helper.dart';

class AllTab extends StatefulWidget {
  const AllTab({Key? key}) : super(key: key);

  @override
  State<AllTab> createState() => _AllTabState();
}

class _AllTabState extends State<AllTab> {
  List<BankTransaction> _transactions = [];

  Future<void> _fetchTransactions() async {
    final transactions = await DatabaseHelper.instance.fetchTransactions();
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