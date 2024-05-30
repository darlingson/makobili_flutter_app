import 'package:flutter/material.dart';
import 'package:makobili/models/category.dart';
import 'package:makobili/utils/database_helper.dart';

class CategoriesTab extends StatefulWidget {
  const CategoriesTab({Key? key}) : super(key: key);

  @override
  State<CategoriesTab> createState() => _CategoriesTabState();
}

class _CategoriesTabState extends State<CategoriesTab> {
  List<Category> _categories = [];
  Future<void> _fetchCategories() async {
    final categories = await DatabaseHelper.instance.fetchCategories();
    setState(() {
      _categories = categories;
    });
  }

  @override
  void initState() {
    super.initState();
    _fetchCategories();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ListView.builder(
          itemCount: _categories.length,
          itemBuilder: (context, index) {
            return Text(_categories[index].name);
          }),
    );
  }
}
