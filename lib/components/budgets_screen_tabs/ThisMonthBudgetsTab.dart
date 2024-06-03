import 'package:flutter/material.dart';
import 'package:makobili/components/budget_card.dart';
import 'package:makobili/models/budget.dart';
import 'package:makobili/utils/database_helper.dart';
import 'package:intl/intl.dart';

class ThisMonthBudgetsTab extends StatefulWidget {
  const ThisMonthBudgetsTab({super.key});

  @override
  State<ThisMonthBudgetsTab> createState() => _ThisMonthBudgetsTabState();
}

class _ThisMonthBudgetsTabState extends State<ThisMonthBudgetsTab> {
  List<Budget> _budgets = [];
  @override
  void initState() {
    super.initState();
    _fetchBudgets();
  }

  Future<void> _fetchBudgets() async {
    final budgets = await DatabaseHelper.instance.fetchBudgets();
    var currentMonth = int.parse(DateFormat('MM').format(DateTime.now()));
    var currentYear = int.parse(DateFormat('yyyy').format(DateTime.now()));
    var currentMonthBudgets = budgets
        .where((budget) =>
            budget.month == currentMonth && budget.year == currentYear)
        .toList();
    print(budgets);
    setState(() {
      // _budgets = budgets;
      _budgets = currentMonthBudgets;
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
