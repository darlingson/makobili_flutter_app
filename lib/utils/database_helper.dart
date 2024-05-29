import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import '../models/transaction.dart';
import '../models/account.dart';

class DatabaseHelper {
  static final DatabaseHelper instance = DatabaseHelper._init();

  static Database? _database;

  DatabaseHelper._init();

  Future<Database> get database async {
    if (_database != null) return _database!;

    _database = await _initDB('transactions.db');
    return _database!;
  }

  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);

    return await openDatabase(path, version: 1, onCreate: _createDB);
  }

  Future _createDB(Database db, int version) async {
    await db.execute('''
      CREATE TABLE accounts(
        id TEXT PRIMARY KEY,
        name TEXT,
        accountNumber TEXT,
        institution TEXT,
        type TEXT,
        balance REAL
      )
    ''');

    await db.execute('''
      CREATE TABLE transactions(
        id TEXT PRIMARY KEY,
        accountId TEXT,
        description TEXT,
        amount REAL,
        category TEXT,
        direction TEXT,
        date TEXT,
        FOREIGN KEY (accountId) REFERENCES accounts(id) ON DELETE CASCADE
      )
    ''');
  }

  // Insert Account
  Future<void> insertAccount(Account account) async {
    final db = await instance.database;
    await db.insert('accounts', account.toJson(),
        conflictAlgorithm: ConflictAlgorithm.replace);
  }

  // Insert Transaction
  Future<void> insertTransaction(BankTransaction transaction) async {
    final db = await instance.database;
    await db.insert('transactions', transaction.toJson(),
        conflictAlgorithm: ConflictAlgorithm.replace);
  }

  // Fetch all accounts
  Future<List<Account>> fetchAccounts() async {
    final db = await instance.database;
    final result = await db.query('accounts');

    return result.map((json) => Account.fromJson(json)).toList();
  }

  // Fetch all transactions
  Future<List<BankTransaction>> fetchTransactions() async {
    final db = await instance.database;
    final result = await db.query('transactions');

    return result.map((json) => BankTransaction.fromJson(json)).toList();
  }

  // Fetch transactions by account ID
  Future<List<BankTransaction>> fetchTransactionsByAccountId(
      String accountId) async {
    final db = await instance.database;
    final result = await db
        .query('transactions', where: 'accountId = ?', whereArgs: [accountId]);

    return result.map((json) => BankTransaction.fromJson(json)).toList();
  }

  // Update Account
  Future<void> updateAccount(Account account) async {
    final db = await instance.database;
    await db.update('accounts', account.toJson(),
        where: 'id = ?', whereArgs: [account.id]);
  }

  // Update Transaction
  Future<void> updateTransaction(BankTransaction transaction) async {
    final db = await instance.database;
    await db.update('transactions', transaction.toJson(),
        where: 'id = ?', whereArgs: [transaction.id]);
  }

  // Delete Account
  Future<void> deleteAccount(String id) async {
    final db = await instance.database;
    await db.delete('accounts', where: 'id = ?', whereArgs: [id]);
  }

  // Delete Transaction
  Future<void> deleteTransaction(String id) async {
    final db = await instance.database;
    await db.delete('transactions', where: 'id = ?', whereArgs: [id]);
  }

  Future close() async {
    final db = await instance.database;
    db.close();
  }
}
