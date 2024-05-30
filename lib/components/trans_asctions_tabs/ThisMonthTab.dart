import 'dart:ffi';

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
    return const Center(
      child: Text(
        'This Month Page',
        style: TextStyle(fontSize: 20),
      ),
    );
  }
}
