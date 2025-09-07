import 'package:expense_tracker/expenses.dart';
import 'package:flutter/material.dart';

var darkScheme = ColorScheme.fromSeed(
  seedColor: Color.fromARGB(255, 5, 99, 125),
  brightness: Brightness.dark,
);

void main() {
  runApp(
    MaterialApp(
      theme: ThemeData(),
      darkTheme: ThemeData.dark().copyWith(
        colorScheme: darkScheme,
        scaffoldBackgroundColor: darkScheme.background,
        cardTheme: CardThemeData(
          color: darkScheme.onPrimary,
          margin: EdgeInsets.all(8),
          elevation: 4,
          shadowColor: darkScheme.shadow,
        ),
        textTheme: TextTheme(
          titleLarge: TextStyle(
            color: darkScheme.onSurface,
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
          bodyMedium: TextStyle(
            color: darkScheme.onSurface,
            fontSize: 16,
          ),
          bodySmall: TextStyle(
            color: darkScheme.onSurface.withOpacity(0.7),
            fontSize: 14,
          ),
        ),
        iconTheme: IconThemeData(
          color: darkScheme.primary,
        ),
        appBarTheme: AppBarTheme(
          backgroundColor: darkScheme.primary,
          foregroundColor: darkScheme.onPrimary,
        ),
      ),
      home: Expenses(),
      themeMode: ThemeMode.system,
    ),
  );
}
