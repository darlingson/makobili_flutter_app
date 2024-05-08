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
      width: 320,
      child: Card(
        color: Colors.blue[100], // Light blue card color for the theme
        child: Padding(
          padding: EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text('Account Name: $accountName',
                  style: TextStyle(fontSize: 16)),
              Text('Account Number: $accountNumber',
                  style: TextStyle(fontSize: 16)),
              Text('Institution: $institution', style: TextStyle(fontSize: 16)),
              Text('Account Type: $accountType',
                  style: TextStyle(fontSize: 16)),
            ],
          ),
        ),
        elevation: 5, // Shadow depth
        margin: EdgeInsets.all(8), // Margin around each card
      ),
    );
  }
}
