import 'package:flutter/material.dart';
import 'package:makobili/models/transaction.dart';
import '../utils/database_helper.dart';


class TransActionsProvider extends ChangeNotifier {
  List<BankTransaction> transactions = [];

  Future<void> fetchTransactions(String accountId) async {
    transactions = await DatabaseHelper.instance.fetchTransactionsByAccountId(accountId);
    notifyListeners();
  }

  List<BankTransaction> getTransactions() {
    return transactions;
  }
}