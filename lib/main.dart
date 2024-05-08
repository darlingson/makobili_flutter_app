import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Finance Tracker',
      theme: ThemeData(
        // Light theme settings
        brightness: Brightness.light,
        primaryColor: Color(0xFF0D47A1),
        fontFamily: 'Roboto',
        textTheme: const TextTheme(
          displayLarge: TextStyle(
              fontSize: 72.0, fontWeight: FontWeight.bold, color: Colors.white),
          titleLarge: TextStyle(
              fontSize: 36.0, fontStyle: FontStyle.italic, color: Colors.white),
          bodyMedium: TextStyle(
              fontSize: 14.0, fontFamily: 'Hind', color: Colors.black87),
        ),
        buttonTheme: ButtonThemeData(
          buttonColor: Color(0xFF1976D2),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8.0),
          ),
          textTheme: ButtonTextTheme.primary,
        ),
        colorScheme:
            ColorScheme.fromSwatch().copyWith(secondary: Color(0xFF64FFDA)),
      ),
      darkTheme: ThemeData(
        // Define a color scheme for the dark theme with the appropriate brightness
        colorScheme: ColorScheme.dark(
          primary: Color(0xFF0D47A1),
          secondary: Color(0xFF64FFDA),
          onPrimary:
              Colors.white, // Ensuring text/icons on primary color are white
          onSecondary:
              Colors.black, // Ensuring text/icons on secondary color are black
        ),
        fontFamily: 'Roboto',
        buttonTheme: ButtonThemeData(
          buttonColor: Color(0xFF1976D2),
          textTheme: ButtonTextTheme.primary,
        ),
        textTheme: TextTheme(
          headline1: TextStyle(
              fontSize: 72.0, fontWeight: FontWeight.bold, color: Colors.white),
          headline6: TextStyle(
              fontSize: 36.0, fontStyle: FontStyle.italic, color: Colors.white),
          bodyText2: TextStyle(
              fontSize: 14.0, fontFamily: 'Hind', color: Colors.white70),
        ),
      ),
      themeMode: ThemeMode
          .system, // Decides which theme to show based on the system preference
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Finance Overview'),
      ),
      body: Center(
        child: Text('Welcome to Your Finance Tracker!'),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        tooltip: 'Add Transaction',
        child: Icon(Icons.add),
      ),
    );
  }
}
