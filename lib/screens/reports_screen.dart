import 'package:flutter/material.dart';

class ReportsScreen extends StatefulWidget {
  const ReportsScreen({super.key});

  @override
  State<ReportsScreen> createState() => _ReportsScreenState();
}

class _ReportsScreenState extends State<ReportsScreen> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text('Reports Page',
          style: TextStyle(fontSize: 35, fontWeight: FontWeight.bold)),
    );
  }
}
