import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:makobili/components/balance_card.dart';
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
    });
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
          SizedBox(
            width: 350,
            child: Text(
              "Balance: ${widget.account.balance}",
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
          const SizedBox(
            height: 20,
            child: Text(
              "Transactions",
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
                    trailing: Text(DateFormat('yyyy-MM-dd – kk:mm')
                        .format(_transactions[index].date)),
                  ),
                );
              },
            ),
          )
        ],
      ),
    );
  }
}
