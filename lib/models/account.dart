import 'package:makobili/models/transaction.dart';

class Account {
  final String id;
  final String name;
  final String accountNumber;
  final String institution;
  final String type;
  final double balance;
  final List<BankTransaction> transactions;

  Account({
    required this.id,
    required this.name,
    required this.accountNumber,
    required this.institution,
    required this.type,
    required this.balance,
    required this.transactions,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'accountNumber': accountNumber,
      'institution': institution,
      'type': type,
      'balance': balance,
      'transactions':
          transactions.map((transaction) => transaction.toJson()).toList(),
    };
  }

  factory Account.fromJson(Map<String, dynamic> json) {
    return Account(
      id: json['id'],
      name: json['name'],
      accountNumber: json['accountNumber'],
      institution: json['institution'],
      type: json['type'],
      balance: json['balance'],
      transactions: (json['transactions'] as List<dynamic>)
          .map((transactionJson) => BankTransaction.fromJson(transactionJson))
          .toList(),
    );
  }
}
