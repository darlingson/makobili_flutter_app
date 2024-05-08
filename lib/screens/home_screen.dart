import 'package:flutter/material.dart';
import 'package:makobili/components/balance_card.dart';
import 'package:makobili/components/transaction_card.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 250,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: 10,
            itemBuilder: (context, index) {
              return BalanceCard(
                index: index,
                accountName: 'Account ${index + 1}',
                accountNumber: '1234 5678 9012 345${index + 1}',
                institution: 'Bank ${index + 1}',
                accountType: 'Savings',
              );
            },
          ),
        ),
        Expanded(
          child: ListView.builder(
            itemBuilder: (context, index) {
              return TransActionCard(
                accountNumber: '1234 5678 9012 345${index + 1}',
                institution: 'Bank ${index + 1}',
                accountType: 'Savings',
                amount: 'Account ${index + 1}',
                transactionDirection: "out",
              );
            },
            itemCount: 10,
          ),
        ),
      ],
    );
  }
}
