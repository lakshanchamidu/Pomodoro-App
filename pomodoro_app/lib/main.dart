import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'Models/Task.dart';
import 'Models/UserProfile.dart';
import 'Screens/LoginScreen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  // Initialize Hive
  await Hive.initFlutter();
  
  // Register adapters
  Hive.registerAdapter(TaskAdapter());
  Hive.registerAdapter(UserProfileAdapter());
  
  // Open boxes
  await Hive.openBox<Task>('tasks');
  await Hive.openBox<UserProfile>('userProfile');
  
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
          background: Color(0xFFF8F9FE),
          onBackground: Color(0xFF1E293B),
          primary: Color(0xFF6366F1),
          onPrimary: Colors.white,
        ),
      ),

      darkTheme: ThemeData(
        brightness: Brightness.dark,
        useMaterial3: true,
        colorScheme: const ColorScheme.dark(
          background: Color(0xFF0F172A),
          onBackground: Color(0xFFF1F5F9),
          primary: Color(0xFF818CF8),
          onPrimary: Color(0xFF1E1B4B),
        ),
      ),

      home: LoginScreen(
        onThemeChange: toggleTheme, 
      ),
    );
  }
}
