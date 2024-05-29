import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import '../models/account.dart';
import '../models/transaction.dart';
import '../models/category.dart';
import '../models/institution.dart';

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
        balance REAL,
        FOREIGN KEY (institution) REFERENCES institutions(id) ON DELETE CASCADE
      )
    ''');

    await db.execute('''
      CREATE TABLE transactions(
        id TEXT PRIMARY KEY,
        accountId TEXT,
        description TEXT,
        amount REAL,
        categoryId TEXT,
        direction TEXT,
        date TEXT,
        FOREIGN KEY (accountId) REFERENCES accounts(id) ON DELETE CASCADE,
        FOREIGN KEY (categoryId) REFERENCES categories(id) ON DELETE CASCADE
      )
    ''');

    await db.execute('''
      CREATE TABLE categories(
        id TEXT PRIMARY KEY,
        name TEXT
      )
    ''');

    await db.execute('''
      CREATE TABLE institutions(
        id TEXT PRIMARY KEY,
        name TEXT,
        type TEXT
      )
    ''');
    await _insertInitialData(db);
  }

  Future<void> _insertInitialData(Database db) async {
    // Define initial institutions
    final List<Institution> institutions = [
      Institution(id: '1', name: 'National Bank', type: 'Bank'),
      Institution(id: '2', name: 'Standard Bank', type: 'Bank'),
      Institution(id: '3', name: 'FDH Bank', type: 'Bank'),
      Institution(id: '4', name: 'Airtel', type: 'Mobile Money'),
      Institution(id: '5', name: 'TNM', type: 'Mobile Money'),
    ];

    // Define initial categories
    final List<Category> categories = [
      Category(id: '1', name: 'Food'),
      Category(id: '2', name: 'Entertainment'),
      Category(id: '3', name: 'Utilities'),
    ];

    // Insert institutions
    for (var institution in institutions) {
      await db.insert('institutions', institution.toJson());
    }

    // Insert categories
    for (var category in categories) {
      await db.insert('categories', category.toJson());
    }
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

  // Insert Category
  Future<void> insertCategory(Category category) async {
    final db = await instance.database;
    await db.insert('categories', category.toJson(),
        conflictAlgorithm: ConflictAlgorithm.replace);
  }

  // Insert Institution
  Future<void> insertInstitution(Institution institution) async {
    final db = await instance.database;
    await db.insert('institutions', institution.toJson(),
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

  // Fetch all categories
  Future<List<Category>> fetchCategories() async {
    final db = await instance.database;
    final result = await db.query('categories');

    return result.map((json) => Category.fromJson(json)).toList();
  }

  // Fetch all institutions
  Future<List<Institution>> fetchInstitutions() async {
    final db = await instance.database;
    final result = await db.query('institutions');

    return result.map((json) => Institution.fromJson(json)).toList();
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

  // Update Category
  Future<void> updateCategory(Category category) async {
    final db = await instance.database;
    await db.update('categories', category.toJson(),
        where: 'id = ?', whereArgs: [category.id]);
  }

  // Update Institution
  Future<void> updateInstitution(Institution institution) async {
    final db = await instance.database;
    await db.update('institutions', institution.toJson(),
        where: 'id = ?', whereArgs: [institution.id]);
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

  // Delete Category
  Future<void> deleteCategory(String id) async {
    final db = await instance.database;
    await db.delete('categories', where: 'id = ?', whereArgs: [id]);
  }

  // Delete Institution
  Future<void> deleteInstitution(String id) async {
    final db = await instance.database;
    await db.delete('institutions', where: 'id = ?', whereArgs: [id]);
  }

  Future close() async {
    final db = await instance.database;
    db.close();
  }
}
