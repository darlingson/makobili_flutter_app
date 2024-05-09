import 'dart:convert';
import 'dart:js';
import 'package:flutter/material.dart';
import 'package:makobili/models/account.dart';

Future<List<Account>> fetchAccounts() async {
  // Load JSON file from assets
  String jsonString = await loadAsset('assets/transaction.json');

  // Parse JSON string
  List<dynamic> jsonList = json.decode(jsonString);

  // Convert JSON to list of Account objects
  List<Account> accounts =
      jsonList.map((json) => Account.fromJson(json)).toList();

  return accounts;
}

Future<String> loadAsset(String path) async {
  // Retrieve asset bundle from the widget tree and load the asset
  return await DefaultAssetBundle.of(context as BuildContext).loadString(path);
}
