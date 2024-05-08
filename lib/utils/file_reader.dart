import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:makobili/models/account.dart';

Future<List<Account>> fetchAccounts() async {
  String jsonString = await rootBundle.loadString('assets/mock_data.json');
  List<dynamic> jsonList = json.decode(jsonString);
  List<Account> accounts =
      jsonList.map((json) => Account.fromJson(json)).toList();

  return accounts;
}
