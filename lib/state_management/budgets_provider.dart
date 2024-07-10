import 'package:flutter/cupertino.dart';

import '../models/budget.dart';
import '../utils/database_helper.dart';

class BudgetsProvider extends ChangeNotifier {
  List<Budget> budgets = [];
  List<Budget> getBudgets() {
    return budgets;
  }

  Future<void> fetchBudgets() async {
    budgets = await DatabaseHelper.instance.fetchBudgets();
    notifyListeners();
  }
  Future<void> addBudget(Budget budget) async {
    budgets.add(budget);
    await DatabaseHelper.instance.insertBudget(budget);
    notifyListeners();
  }
}