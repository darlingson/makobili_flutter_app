import 'package:flutter/material.dart';

class TransActionCard extends StatelessWidget {
  final String accountNumber;
  final String accountType;
  final String institution;
  final String amount;
  final String transactionDirection;
  const TransActionCard(
      {super.key,
      required this.accountNumber,
      required this.institution,
      required this.accountType,
      required this.amount,
      required this.transactionDirection});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        width: 320,
        child: Card(
            color: Colors.blue[100], // Light blue card color for the theme
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text('Account Number: $accountNumber',
                        style: const TextStyle(fontSize: 16)),
                    Text('Institution: $institution',
                        style: const TextStyle(fontSize: 16)),
                    Text('Account Type: $accountType',
                        style: const TextStyle(fontSize: 16))
                  ]),
            )));
  }
}
