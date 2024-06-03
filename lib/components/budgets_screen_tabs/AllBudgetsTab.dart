import 'package:flutter/material.dart';
import 'package:makobili/components/budget_card.dart';
import 'package:makobili/models/budget.dart';
import 'package:makobili/utils/database_helper.dart';

class AllBudgetsTab extends StatefulWidget {
  const AllBudgetsTab({super.key});

  @override
  State<AllBudgetsTab> createState() => _AllBudgetsTabState();
}

class _AllBudgetsTabState extends State<AllBudgetsTab> {
  List<Budget> _budgets = [];
  @override
  void initState() {
    super.initState();
    _fetchBudgets();
  }

  Future<void> _fetchBudgets() async {
    final budgets = await DatabaseHelper.instance.fetchBudgets();
    print(budgets);
    setState(() {
      _budgets = budgets;
    });
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: _budgets.length,
      itemBuilder: (context, index) {
        return BudgetCard(budget: _budgets[index]);
      },
    );
  }
}
