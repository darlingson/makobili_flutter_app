import 'package:flutter/material.dart';
import '../models/budget.dart';
import '../utils/database_helper.dart';
import '../models/category.dart';

class BudgetCard extends StatefulWidget {
  final Budget budget;

  BudgetCard({required this.budget});

  @override
  State<BudgetCard> createState() => _BudgetCardState();
}

class _BudgetCardState extends State<BudgetCard> {
  List<Category> _categories = [];

  Future<String> _getCategoryName(String categoryId) async {
    final categories = await DatabaseHelper.instance.fetchCategories();
    final category =
        categories.firstWhere((category) => category.id == categoryId);
    return category.name;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<String>(
      future: _getCategoryName(widget.budget.categoryId),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        } else if (!snapshot.hasData) {
          return Center(child: Text('Category not found'));
        }

        String categoryName = snapshot.data!;

        return Card(
          margin: EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15.0),
          ),
          elevation: 5.0,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  categoryName,
                  style: TextStyle(
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.blueAccent,
                  ),
                ),
                SizedBox(height: 10.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Amount:',
                      style: TextStyle(
                        fontSize: 16.0,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    Text(
                      '\$${widget.budget.amount.toStringAsFixed(2)}',
                      style: TextStyle(
                        fontSize: 16.0,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 10.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Month:',
                      style: TextStyle(
                        fontSize: 16.0,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    Text(
                      '${widget.budget.month}',
                      style: TextStyle(
                        fontSize: 16.0,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 10.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Year:',
                      style: TextStyle(
                        fontSize: 16.0,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    Text(
                      '${widget.budget.year}',
                      style: TextStyle(
                        fontSize: 16.0,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
