import 'package:flutter/material.dart';
import 'package:makobili/components/add_budgets_form.dart';
import 'package:makobili/components/budgets_screen_tabs/AllBudgetsTab.dart';
import 'package:makobili/components/budgets_screen_tabs/ThisMonthBudgetsTab.dart';

class BudgetsScreen extends StatefulWidget {
  const BudgetsScreen({super.key});

  @override
  State<BudgetsScreen> createState() => _BudgetsScreenState();
}

class _BudgetsScreenState extends State<BudgetsScreen> {
  void _showAddBudgetDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
            title: const Text('Add Budget'),
            content: const AddBudgetForm(),
            actions: <Widget>[
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text('Cancel'),
              ),
            ]);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: 2,
        child: Scaffold(
            appBar: AppBar(
              title: const Text(
                '',
                style: TextStyle(fontSize: 16),
              ),
              bottom: const TabBar(
                tabs: [
                  Tab(text: 'This Month'),
                  Tab(text: 'All'),
                ],
              ),
            ),
            floatingActionButton: FloatingActionButton(
              onPressed: () {
                _showAddBudgetDialog(context);
              },
              child: const Icon(Icons.add),
            ),
            body: const TabBarView(
              children: [
                ThisMonthBudgetsTab(),
                AllBudgetsTab(),
              ],
            )));
  }
}

// class ThisMonthBudgetsTab extends StatelessWidget {
//   const ThisMonthBudgetsTab({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Container();
//   }
// }

// class AllBudgetsTab extends StatelessWidget {
//   const AllBudgetsTab({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Container();
//   }
// }
