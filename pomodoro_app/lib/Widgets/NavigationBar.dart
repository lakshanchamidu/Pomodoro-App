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
          selectedIcon: Icon(Icons.recent_actors, color: Colors.blue),
          icon: Icon(Icons.recent_actors_outlined),
          label: 'Recent',
        ),
        NavigationDestination(
          selectedIcon: Icon(Icons.favorite, color: Colors.amber),
          icon: Icon(Icons.favorite_border_outlined),
          label: 'Favourite',
        ),
        NavigationDestination(
          selectedIcon: Icon(Icons.notifications, color: Colors.purpleAccent),
          icon: Icon(Icons.notifications_outlined),
          label: 'Notifications',
        ),
        NavigationDestination(
          selectedIcon: Icon(Icons.settings, color: Color.fromARGB(255, 86, 157, 5)),
          icon: Icon(Icons.settings_outlined),
          label: 'Settings',
        ),
      ],
    );
  }
}
