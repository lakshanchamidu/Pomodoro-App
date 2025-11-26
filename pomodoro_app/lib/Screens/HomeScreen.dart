import 'package:flutter/material.dart';
import 'package:pomodoro_app/Widgets/NavigationBar.dart';
import 'package:pomodoro_app/Widgets/HomeWidget.dart';
import 'package:pomodoro_app/Screens/TasksScreen.dart';
import 'package:pomodoro_app/Screens/StatisticsScreen.dart';
import 'package:pomodoro_app/Screens/ProfileScreen.dart';
import 'package:pomodoro_app/Screens/SettingsScreen.dart';

class HomeScreen extends StatefulWidget {
  final VoidCallback onThemeChange;
  const HomeScreen({super.key, required this.onThemeChange});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int selectedIndex = 0;

  Widget getPage(int index) {
    switch (index) {
      case 0:
        return const HomePageWidget();
      case 1:
        return const TasksScreen();
      case 2:
        return const StatisticsScreen();
      case 3:
        return const ProfileScreen();
      case 4:
        return SettingsScreen(onThemeChange: widget.onThemeChange);
      default:
        return const HomePageWidget();
    }
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      appBar: selectedIndex == 0 ? AppBar(
        backgroundColor: Theme.of(context).colorScheme.background,
        elevation: 0,
        title: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Theme.of(context).colorScheme.primary,
                    Theme.of(context).colorScheme.primary.withOpacity(0.7),
                  ],
                ),
                borderRadius: BorderRadius.circular(12),
              ),
              child: const Icon(Icons.timer, color: Colors.white, size: 20),
            ),
            const SizedBox(width: 12),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Hi, Chamidu 👋',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                ),
                Text(
                  'Let\'s be productive today!',
                  style: TextStyle(
                    fontSize: 11,
                    color: Theme.of(context).colorScheme.onBackground.withOpacity(0.6),
                    fontWeight: FontWeight.normal,
                  ),
                ),
              ],
            ),
          ],
        ),
        centerTitle: false,
        actions: <Widget>[
          IconButton(
            onPressed: widget.onThemeChange,
            icon: Icon(
              isDark ? Icons.light_mode : Icons.dark_mode,
              color: Theme.of(context).colorScheme.primary,
            ),
            tooltip: 'Toggle Theme',
          ),
          IconButton(
            onPressed: () {
              showDialog(
                context: context,
                builder: (context) => AlertDialog(
                  title: const Text('Logout'),
                  content: const Text('Are you sure you want to logout?'),
                  actions: [
                    TextButton(
                      onPressed: () => Navigator.pop(context),
                      child: const Text('Cancel'),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        Navigator.pop(context);
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('Logged out successfully')),
                        );
                      },
                      style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
                      child: const Text('Logout'),
                    ),
                  ],
                ),
              );
            },
            icon: const Icon(Icons.logout, color: Colors.red),
            tooltip: 'Logout',
          ),
        ],
      ) : null,

      body: getPage(selectedIndex),

      bottomNavigationBar: NavigationBarWidget(
        currentIndex: selectedIndex,
        onTabChange: (i) {
          setState(() {
            selectedIndex = i;
          });
        },
      ),
    );
  }
}
