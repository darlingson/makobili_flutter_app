import 'package:flutter/material.dart';
import 'package:intl/intl.dart'; // Make sure to import this package

class TransactionsCard extends StatelessWidget {
  final String direction;
  final String description;
  final double amount;
  final DateTime date;

  const TransactionsCard({
    Key? key,
    required this.direction,
    required this.description,
    required this.amount,
    required this.date,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Color backgroundColor = direction == 'in' ? Colors.green : Colors.red;

    return Card(
      elevation: 5,
      margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      color: backgroundColor,
      child: ListTile(
        isThreeLine: true,
        visualDensity: const VisualDensity(horizontal: 0, vertical: -2),
        leading: SizedBox(
          width: 60,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              CircleAvatar(
                backgroundColor: Colors.white70,
                child: Icon(
                  direction == 'in' ? Icons.download : Icons.upload_sharp,
                  color: direction == 'in' ? Colors.green : Colors.red,
                ),
              ),
              const VerticalDivider(color: Colors.white54, thickness: 1),
            ],
          ),
        ),
        title: Text(
          description,
          style:
              const TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Amount: \$${amount.toStringAsFixed(2)}',
              style: const TextStyle(color: Colors.white70),
            ),
            Text(
              DateFormat('yyyy-MM-dd – kk:mm').format(date),
              style: const TextStyle(color: Colors.white54, fontSize: 12),
            ),
          ],
        ),
      ),
    );
  }
}
