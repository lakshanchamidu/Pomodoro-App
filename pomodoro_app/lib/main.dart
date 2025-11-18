import 'package:flutter/material.dart';
import 'Screens/HomeScreen.dart';

void main() {
  runApp(const SmartPomodoroApp());
}

class SmartPomodoroApp extends StatefulWidget {
  const SmartPomodoroApp({super.key});

  @override
  State<SmartPomodoroApp> createState() => _SmartPomodoroAppState();
}

class _SmartPomodoroAppState extends State<SmartPomodoroApp> {
  ThemeMode _themeMode = ThemeMode.light;

  void toggleTheme() {
    setState(() {
      _themeMode =
          _themeMode == ThemeMode.light ? ThemeMode.dark : ThemeMode.light;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Smart Pomodoro',
      themeMode: _themeMode,
      theme: ThemeData(
        brightness: Brightness.light,
        useMaterial3: true,
        colorScheme: const ColorScheme.light(
          background: Color(0xFFFFF5F0),
          onBackground: Color(0xFF2C3E50),
          primary: Color(0xFFE74C3C),
          onPrimary: Colors.white,
        ),
      ),

      darkTheme: ThemeData(
        brightness: Brightness.dark,
        useMaterial3: true,
        colorScheme: const ColorScheme.dark(
          background: Color(0xFF1A1A2E),
          onBackground: Color(0xFFEEEEEE),
          primary: Color(0xFFFF6B6B),
          onPrimary: Color(0xFF0F3460),
        ),
      ),

      home: HomeScreen(
        onThemeChange: toggleTheme, 
      ),
    );
  }
}
