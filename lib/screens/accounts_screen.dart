import 'package:flutter/material.dart';
import 'package:makobili/components/balance_card.dart';

class AccountsScreen extends StatelessWidget {
  const AccountsScreen({Key? key});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.builder(
        itemBuilder: (context, index) {
          return BalanceCard(
            index: index,
            accountName: 'Account ${index + 1}',
            accountNumber: '1234 5678 9012 345${index + 1}',
            institution: 'Bank ${index + 1}',
            accountType: 'Savings',
          );
        },
        itemCount: 10,
      ),
    );
  }
}
