import 'package:flutter/material.dart';
import 'package:makobili/components/balance_card.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      SizedBox(
        height: 200,
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: 10,
          itemBuilder: (context, index) {
            return BalanceCard(index: index);
          },
        ),
      )
    ]);
  }
}
