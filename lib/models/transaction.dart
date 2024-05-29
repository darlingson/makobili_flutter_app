class Transaction {
  final String id;
  final String accountId;
  final String description;
  final double amount;
  final String category;
  final String direction;
  final DateTime date;

  Transaction({
    required this.id,
    required this.accountId,
    required this.description,
    required this.amount,
    required this.category,
    required this.direction,
    required this.date,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'accountId': accountId,
      'description': description,
      'amount': amount,
      'category': category,
      'direction': direction,
      'date': date.toIso8601String(),
    };
  }

  factory Transaction.fromJson(Map<String, dynamic> json) {
    return Transaction(
      id: json['id'],
      accountId: json['accountId'],
      description: json['description'],
      amount: json['amount'],
      category: json['category'],
      direction: json['direction'],
      date: DateTime.parse(json['date']),
    );
  }
}
