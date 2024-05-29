import 'package:flutter/material.dart';

class TransactionsScreen extends StatelessWidget {
  const TransactionsScreen({Key? key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text('Transactions Page',
          style: TextStyle(fontSize: 35, fontWeight: FontWeight.bold)),
    );
  }
}
