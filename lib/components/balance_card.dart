import 'package:flutter/material.dart';

class BalanceCard extends StatelessWidget {
  final int index; // Pass the index or any other data needed for the card

  const BalanceCard({Key? key, required this.index}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 160, // Width of each card
      child: Card(
        color: Colors.blue[100],
        elevation: 5,
        margin: const EdgeInsets.all(8),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Icon(Icons.account_balance_wallet,
                size: 50, color: Colors.blue),
            Text('Card $index',
                style:
                    const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            const Text('More info', style: TextStyle(fontSize: 16)),
          ],
        ),
      ),
    );
  }
}
