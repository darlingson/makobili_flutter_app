import 'package:flutter/material.dart';
import 'package:makobili/models/transaction.dart';

class TransActionsProvider extends ChangeNotifier {
  late List<BankTransaction> transactions = [];

  void updateTransactions(List<BankTransaction> transactions) {
    this.transactions = transactions;
    notifyListeners();
  }

  List<BankTransaction> getTransactions() {
    return transactions;
  }
}
