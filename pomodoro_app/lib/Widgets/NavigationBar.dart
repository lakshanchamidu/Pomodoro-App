import 'package:flutter/material.dart';

class NavigationBarWidget extends StatelessWidget {
  final int currentIndex;
  final Function(int) onTabChange;

  const NavigationBarWidget({
    super.key,
    required this.currentIndex,
    required this.onTabChange,
  });

  @override
  Widget build(BuildContext context) {
    return NavigationBar(
      backgroundColor: Theme.of(context).colorScheme.background,
      selectedIndex: currentIndex,
      indicatorColor: Colors.transparent,
      labelBehavior: NavigationDestinationLabelBehavior.onlyShowSelected,
      onDestinationSelected: (int index) {
        onTabChange(index);
      },

      destinations: const <NavigationDestination>[
        NavigationDestination(
          selectedIcon: Icon(Icons.home, color: Colors.pink),
          icon: Icon(Icons.home_outlined),
          label: 'Home',
        ),
        NavigationDestination(
          selectedIcon: Icon(Icons.task_alt, color: Colors.blue),
          icon: Icon(Icons.task_outlined),
          label: 'Tasks',
        ),
        NavigationDestination(
          selectedIcon: Icon(Icons.bar_chart, color: Colors.amber),
          icon: Icon(Icons.bar_chart_outlined),
          label: 'Stats',
        ),
        NavigationDestination(
          selectedIcon: Icon(Icons.person, color: Colors.purple),
          icon: Icon(Icons.person_outlined),
          label: 'Profile',
        ),
        NavigationDestination(
          selectedIcon: Icon(Icons.settings, color: Colors.green),
          icon: Icon(Icons.settings_outlined),
          label: 'Settings',
        ),
      ],
    );
  }
}
