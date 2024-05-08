import 'package:flutter/material.dart';

class AccountsScreen extends StatefulWidget {
  const AccountsScreen({super.key});

  @override
  State<AccountsScreen> createState() => _AccountsScreenState();
}

class _AccountsScreenState extends State<AccountsScreen> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text('Accounts Page',
          style: TextStyle(fontSize: 35, fontWeight: FontWeight.bold)),
    );
  }
}
