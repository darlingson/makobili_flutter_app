import 'package:flutter/material.dart';
import 'package:makobili/components/balance_card.dart';
import 'package:makobili/models/account.dart';
import 'package:makobili/utils/file_reader.dart';

class AccountsScreen extends StatefulWidget {
  const AccountsScreen({Key? key});

  @override
  State<AccountsScreen> createState() => _AccountsScreenState();
}

class _AccountsScreenState extends State<AccountsScreen> {
  List<Account> accounts = [];

  @override
  initState() {
    super.initState();
    loadAccounts();
  }

  loadAccounts() async {
    accounts = await fetchAccounts();
    print(accounts);
  }

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
