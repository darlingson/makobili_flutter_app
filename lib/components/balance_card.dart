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
    return Container(
      width: 350,
      margin: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [Colors.blue.shade900, Colors.blue.shade300],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.3),
            spreadRadius: 1,
            blurRadius: 5,
            offset: const Offset(0, 3), // changes position of shadow
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            const Icon(Icons.credit_card, color: Colors.white70, size: 24),
            const SizedBox(height: 10),
            Text('Account Name: $accountName',
                style: const TextStyle(
                    fontSize: 18,
                    color: Colors.white,
                    fontWeight: FontWeight.bold)),
            const SizedBox(height: 5),
            Text('Account Number: ${_formatAccountNumber(accountNumber)}',
                style: const TextStyle(fontSize: 16, color: Colors.white)),
            const SizedBox(height: 5),
            Text('Institution: $institution',
                style: const TextStyle(fontSize: 16, color: Colors.white)),
            const SizedBox(height: 5),
            Text('Account Type: $accountType',
                style: const TextStyle(fontSize: 16, color: Colors.white)),
          ],
        ),
      ),
    );
  }

  // Helper function to format account number like an ATM card number
  String _formatAccountNumber(String number) {
    return number.replaceAllMapped(
        RegExp(r".{4}"), (match) => "${match.group(0)} ");
  }
}
