import 'package:flutter/material.dart';

class BalanceCard extends StatelessWidget {
  final int index;
  final String accountName;
  final String accountNumber;
  final String institution;
  final String accountType;

  const BalanceCard({
    Key? key,
    required this.index,
    required this.accountName,
    required this.accountNumber,
    required this.institution,
    required this.accountType,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 350,
      child: Card(
        color: Colors.blue[100],
        elevation: 5,
        margin: const EdgeInsets.all(8),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text('Account Name: $accountName',
                  style: const TextStyle(fontSize: 16)),
              Text('Account Number: $accountNumber',
                  style: const TextStyle(fontSize: 16)),
              Text('Institution: $institution',
                  style: const TextStyle(fontSize: 16)),
              Text('Account Type: $accountType',
                  style: const TextStyle(fontSize: 16)),
            ],
          ),
        ),
      ),
    );
  }
}
