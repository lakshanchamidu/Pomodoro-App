import 'package:flutter/material.dart';
import 'package:pomodoro_app/Widgets/NavigationBar.dart';
import 'package:pomodoro_app/Widgets/HomeWidget.dart';

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
        return Center(child: HomePageWidget());
      case 1:
        return const Center(
          child: Text('Recent Page', style: TextStyle(fontSize: 24)),
        );
      case 2:
        return const Center(
          child: Text('Favourite Page', style: TextStyle(fontSize: 24)),
        );
      case 3:
        return const Center(
          child: Text('Notifications Page', style: TextStyle(fontSize: 24)),
        );
      case 4:
        return const Center(
          child: Text('Settings Page', style: TextStyle(fontSize: 24)),
        );
      default:
        return const Center(
          child: Text('Home Page', style: TextStyle(fontSize: 24)),
        );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.background,
        title: Text(
          'Hi, Chamidu',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Theme.of(context).colorScheme.onBackground,
            fontSize: 22,
            letterSpacing: 1,
          ),
        ),
        centerTitle: false,
        actions: <Widget>[
          IconButton(
            onPressed: widget.onThemeChange,
            icon: Icon(Icons.wb_sunny_outlined),
          ),
          IconButton(
            onPressed: () {
              ScaffoldMessenger.of(
                context,
              ).showSnackBar(SnackBar(content: Text('Redirect to Login Page')));
            },
            icon: Icon(Icons.logout),
          ),
        ],
      ),

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
