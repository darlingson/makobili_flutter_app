import 'package:flutter/material.dart';
import 'package:makobili/components/add_account_form.dart';
import 'package:makobili/components/add_categories_form.dart';
import 'package:makobili/components/add_transaction_form.dart';

class HomeScreenAddActionsDialog extends StatelessWidget {
  const HomeScreenAddActionsDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Column(
        children: [
          const TabBar(
            tabs: [
              Tab(text: 'Transaction'),
              Tab(text: 'Account'),
              Tab(text: 'Categories'),
            ],
          ),
          const Expanded(
            child: TabBarView(
              children: [
                AddTransactionForm(),
                AddAccountForm(),
                AddCategoriesForm(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
