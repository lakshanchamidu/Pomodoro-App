import 'package:flutter/material.dart';

class SettingsScreen extends StatefulWidget {
  final VoidCallback onThemeChange;
  
  const SettingsScreen({super.key, required this.onThemeChange});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  // Settings values
  bool notificationsEnabled = true;
  bool soundEnabled = true;
  bool vibrationEnabled = false;
  bool autoStartBreak = true;
  bool autoStartPomodoro = false;
  int pomodoroLength = 25;
  int shortBreakLength = 5;
  int longBreakLength = 15;
  int sessionsBeforeLongBreak = 4;

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.background,
        elevation: 0,
        title: const Text(
          '⚙️ Settings',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22),
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          // Timer Settings Section
          _buildSectionTitle('Timer Settings', Icons.timer),
          const SizedBox(height: 12),
          _buildTimerCard(
            'Pomodoro Length',
            pomodoroLength,
            (value) => setState(() => pomodoroLength = value.toInt()),
            1,
            60,
            isDark,
          ),
          const SizedBox(height: 12),
          _buildTimerCard(
            'Short Break',
            shortBreakLength,
            (value) => setState(() => shortBreakLength = value.toInt()),
            1,
            30,
            isDark,
          ),
          const SizedBox(height: 12),
          _buildTimerCard(
            'Long Break',
            longBreakLength,
            (value) => setState(() => longBreakLength = value.toInt()),
            5,
            60,
            isDark,
          ),
          const SizedBox(height: 12),
          _buildSettingCard(
            'Sessions Before Long Break',
            '$sessionsBeforeLongBreak sessions',
            Icons.repeat,
            isDark,
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                IconButton(
                  icon: const Icon(Icons.remove_circle_outline),
                  onPressed: () {
                    if (sessionsBeforeLongBreak > 2) {
                      setState(() => sessionsBeforeLongBreak--);
                    }
                  },
                ),
                Text(
                  sessionsBeforeLongBreak.toString(),
                  style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                IconButton(
                  icon: const Icon(Icons.add_circle_outline),
                  onPressed: () {
                    if (sessionsBeforeLongBreak < 10) {
                      setState(() => sessionsBeforeLongBreak++);
                    }
                  },
                ),
              ],
            ),
          ),

          const SizedBox(height: 24),

          // Automation Settings
          _buildSectionTitle('Automation', Icons.play_circle),
          const SizedBox(height: 12),
          _buildSwitchCard(
            'Auto-start Breaks',
            'Automatically start break timer',
            autoStartBreak,
            (value) => setState(() => autoStartBreak = value),
            Icons.free_breakfast,
            isDark,
          ),
          const SizedBox(height: 12),
          _buildSwitchCard(
            'Auto-start Pomodoros',
            'Automatically start next pomodoro',
            autoStartPomodoro,
            (value) => setState(() => autoStartPomodoro = value),
            Icons.play_arrow,
            isDark,
          ),

          const SizedBox(height: 24),

          // Notifications Settings
          _buildSectionTitle('Notifications', Icons.notifications),
          const SizedBox(height: 12),
          _buildSwitchCard(
            'Notifications',
            'Enable push notifications',
            notificationsEnabled,
            (value) => setState(() => notificationsEnabled = value),
            Icons.notifications_active,
            isDark,
          ),
          const SizedBox(height: 12),
          _buildSwitchCard(
            'Sound',
            'Play sound on timer completion',
            soundEnabled,
            (value) => setState(() => soundEnabled = value),
            Icons.volume_up,
            isDark,
          ),
          const SizedBox(height: 12),
          _buildSwitchCard(
            'Vibration',
            'Vibrate on timer completion',
            vibrationEnabled,
            (value) => setState(() => vibrationEnabled = value),
            Icons.vibration,
            isDark,
          ),

          const SizedBox(height: 24),

          // Appearance Settings
          _buildSectionTitle('Appearance', Icons.palette),
          const SizedBox(height: 12),
          _buildSettingCard(
            'Theme',
            isDark ? 'Dark Mode' : 'Light Mode',
            Icons.dark_mode,
            isDark,
            trailing: Switch(
              value: isDark,
              onChanged: (value) => widget.onThemeChange(),
              activeColor: Theme.of(context).colorScheme.primary,
            ),
          ),

          const SizedBox(height: 24),

          // Account Settings
          _buildSectionTitle('Account', Icons.person),
          const SizedBox(height: 12),
          _buildSettingCard(
            'Profile',
            'Edit your profile information',
            Icons.person_outline,
            isDark,
            onTap: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Navigate to Profile')),
              );
            },
          ),
          const SizedBox(height: 12),
          _buildSettingCard(
            'Change Password',
            'Update your password',
            Icons.lock_outline,
            isDark,
            onTap: () {
              _showChangePasswordDialog();
            },
          ),

          const SizedBox(height: 24),

          // Data & Privacy
          _buildSectionTitle('Data & Privacy', Icons.security),
          const SizedBox(height: 12),
          _buildSettingCard(
            'Export Data',
            'Download your data',
            Icons.download,
            isDark,
            onTap: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Exporting data...')),
              );
            },
          ),
          const SizedBox(height: 12),
          _buildSettingCard(
            'Clear Data',
            'Delete all local data',
            Icons.delete_outline,
            isDark,
            onTap: () {
              _showClearDataDialog();
            },
          ),

          const SizedBox(height: 24),

          // About Section
          _buildSectionTitle('About', Icons.info),
          const SizedBox(height: 12),
          _buildSettingCard(
            'Version',
            '1.0.0',
            Icons.info_outline,
            isDark,
          ),
          const SizedBox(height: 12),
          _buildSettingCard(
            'Privacy Policy',
            'Read our privacy policy',
            Icons.privacy_tip,
            isDark,
            onTap: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Opening Privacy Policy...')),
              );
            },
          ),
          const SizedBox(height: 12),
          _buildSettingCard(
            'Terms of Service',
            'Read our terms',
            Icons.description,
            isDark,
            onTap: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Opening Terms...')),
              );
            },
          ),

          const SizedBox(height: 24),

          // Logout Button
          Container(
            decoration: BoxDecoration(
              color: Colors.red.withOpacity(0.1),
              borderRadius: BorderRadius.circular(15),
              border: Border.all(color: Colors.red.withOpacity(0.3), width: 2),
            ),
            child: ListTile(
              leading: const Icon(Icons.logout, color: Colors.red),
              title: const Text(
                'Logout',
                style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold),
              ),
              onTap: () {
                _showLogoutDialog();
              },
            ),
          ),

          const SizedBox(height: 32),
        ],
      ),
    );
  }

  Widget _buildSectionTitle(String title, IconData icon) {
    return Row(
      children: [
        Icon(icon, color: Theme.of(context).colorScheme.primary, size: 24),
        const SizedBox(width: 8),
        Text(
          title,
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Theme.of(context).colorScheme.onBackground,
          ),
        ),
      ],
    );
  }

  Widget _buildSettingCard(
    String title,
    String subtitle,
    IconData icon,
    bool isDark, {
    Widget? trailing,
    VoidCallback? onTap,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: isDark ? const Color(0xFF1E293B) : Colors.white,
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: Theme.of(context).colorScheme.primary.withOpacity(0.1),
          child: Icon(icon, color: Theme.of(context).colorScheme.primary),
        ),
        title: Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
        subtitle: Text(subtitle, style: TextStyle(fontSize: 12, color: Colors.grey[600])),
        trailing: trailing ?? (onTap != null ? const Icon(Icons.chevron_right) : null),
        onTap: onTap,
      ),
    );
  }

  Widget _buildSwitchCard(
    String title,
    String subtitle,
    bool value,
    Function(bool) onChanged,
    IconData icon,
    bool isDark,
  ) {
    return Container(
      decoration: BoxDecoration(
        color: isDark ? const Color(0xFF1E293B) : Colors.white,
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: SwitchListTile(
        secondary: CircleAvatar(
          backgroundColor: Theme.of(context).colorScheme.primary.withOpacity(0.1),
          child: Icon(icon, color: Theme.of(context).colorScheme.primary),
        ),
        title: Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
        subtitle: Text(subtitle, style: TextStyle(fontSize: 12, color: Colors.grey[600])),
        value: value,
        onChanged: onChanged,
        activeColor: Theme.of(context).colorScheme.primary,
      ),
    );
  }

  Widget _buildTimerCard(
    String title,
    int value,
    Function(double) onChanged,
    double min,
    double max,
    bool isDark,
  ) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: isDark ? const Color(0xFF1E293B) : Colors.white,
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                title,
                style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              Text(
                '$value min',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).colorScheme.primary,
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Slider(
            value: value.toDouble(),
            min: min,
            max: max,
            divisions: (max - min).toInt(),
            label: '$value min',
            onChanged: onChanged,
            activeColor: Theme.of(context).colorScheme.primary,
          ),
        ],
      ),
    );
  }

  void _showChangePasswordDialog() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Change Password'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                decoration: const InputDecoration(
                  labelText: 'Current Password',
                  border: OutlineInputBorder(),
                ),
                obscureText: true,
              ),
              const SizedBox(height: 12),
              TextField(
                decoration: const InputDecoration(
                  labelText: 'New Password',
                  border: OutlineInputBorder(),
                ),
                obscureText: true,
              ),
              const SizedBox(height: 12),
              TextField(
                decoration: const InputDecoration(
                  labelText: 'Confirm Password',
                  border: OutlineInputBorder(),
                ),
                obscureText: true,
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Password changed successfully')),
                );
              },
              child: const Text('Change'),
            ),
          ],
        );
      },
    );
  }

  void _showClearDataDialog() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Clear All Data?'),
          content: const Text(
            'This will delete all your tasks, statistics, and settings. This action cannot be undone.',
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Cancel'),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
              onPressed: () {
                Navigator.pop(context);
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('All data cleared')),
                );
              },
              child: const Text('Clear Data'),
            ),
          ],
        );
      },
    );
  }

  void _showLogoutDialog() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Logout'),
          content: const Text('Are you sure you want to logout?'),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Cancel'),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
              onPressed: () {
                Navigator.pop(context);
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Logged out successfully')),
                );
              },
              child: const Text('Logout'),
            ),
          ],
        );
      },
    );
  }
}
