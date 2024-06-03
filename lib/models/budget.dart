class Budget {
  final String id;
  final String categoryId;
  final double amount;
  final int month;
  final int year;

  Budget({
    required this.id,
    required this.categoryId,
    required this.amount,
    required this.month,
    required this.year,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'categoryId': categoryId,
      'amount': amount,
      'month': month,
      'year': year,
    };
  }

  static Budget fromJson(Map<String, dynamic> json) {
    return Budget(
      id: json['id'],
      categoryId: json['categoryId'],
      amount: json['amount'],
      month: json['month'],
      year: json['year'],
    );
  }
}
