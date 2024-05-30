import 'package:flutter/material.dart';
import 'package:makobili/screens/accounts_screen.dart';
import 'package:makobili/screens/home_screen.dart';
import 'package:makobili/screens/reports_screen.dart';
import 'package:makobili/screens/transactions_screen.dart';
import 'package:makobili/themes/theme_provider.dart';
import 'package:makobili/utils/database_helper.dart';
import 'package:path/path.dart';
import 'package:provider/provider.dart';
import 'package:sqflite/sqflite.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Check if the database exists
  final dbPath = await getDatabasesPath();
  final path = join(dbPath, 'transactions.db');
  final database_exists = await databaseExists(path);

  if (!database_exists) {
    print('Creating new database at $path');
    // Initialize the database
    await DatabaseHelper.instance.database;
  } else {
    print('Database already exists at $path');
  }
  runApp(ChangeNotifierProvider(
      create: (context) => ThemeProvider(), child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Finance Tracker',
      theme: Provider.of<ThemeProvider>(context).themeData,
      themeMode: ThemeMode.system,
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _selectedIndex = 0;

  // List of widgets to show in the body based on selected tab
  static List<Widget> _widgetOptions = <Widget>[
    HomeScreen(),
    AccountsScreen(),
    TransactionsScreen(),
    ReportsScreen(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Finance Tracker'),
      ),
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.money),
            label: 'Accounts',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_bag_sharp),
            label: 'Transactions',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.bar_chart),
            label: 'Reports',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.blue[800],
        onTap: _onItemTapped,
        type: BottomNavigationBarType.fixed,
      ),
    );
  }
}
