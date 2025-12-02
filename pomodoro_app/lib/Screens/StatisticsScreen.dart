import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:hive_flutter/hive_flutter.dart';
import '../Models/Task.dart';

class StatisticsScreen extends StatefulWidget {
  const StatisticsScreen({super.key});

  @override
  State<StatisticsScreen> createState() => _StatisticsScreenState();
}

class _StatisticsScreenState extends State<StatisticsScreen> {
  String selectedPeriod = 'Week'; // Week, Month, Year
  late Box<Task> taskBox;

  @override
  void initState() {
    super.initState();
    taskBox = Hive.box<Task>('tasks');
  }

  // Calculate total pomodoros from all tasks
  int get totalPomodoros {
    return taskBox.values.fold(0, (sum, task) => sum + task.completedPomodoros);
  }

  // Calculate total minutes (25 min per pomodoro)
  int get totalMinutes {
    return totalPomodoros * 25;
  }

  // Count completed tasks
  int get completedTasks {
    return taskBox.values.where((task) => task.isCompleted).length;
  }

  // Calculate average pomodoros per day (simplified)
  double get averagePerDay {
    if (taskBox.isEmpty) return 0.0;
    final daysActive = 7; // Simplified - could calculate from task dates
    return totalPomodoros / daysActive;
  }

  // Get category breakdown from tasks
  Map<String, int> get categoryBreakdown {
    final Map<String, int> breakdown = {};
    for (var task in taskBox.values) {
      breakdown[task.category] = (breakdown[task.category] ?? 0) + task.completedPomodoros;
    }
    return breakdown;
  }

  // Generate weekly data (simplified mock for now - could be enhanced with real date tracking)
  List<Map<String, dynamic>> get weeklyData {
    return [
      {'day': 'Mon', 'count': totalPomodoros > 0 ? (totalPomodoros * 0.14).round() : 0},
      {'day': 'Tue', 'count': totalPomodoros > 0 ? (totalPomodoros * 0.18).round() : 0},
      {'day': 'Wed', 'count': totalPomodoros > 0 ? (totalPomodoros * 0.12).round() : 0},
      {'day': 'Thu', 'count': totalPomodoros > 0 ? (totalPomodoros * 0.16).round() : 0},
      {'day': 'Fri', 'count': totalPomodoros > 0 ? (totalPomodoros * 0.20).round() : 0},
      {'day': 'Sat', 'count': totalPomodoros > 0 ? (totalPomodoros * 0.10).round() : 0},
      {'day': 'Sun', 'count': totalPomodoros > 0 ? (totalPomodoros * 0.10).round() : 0},
    ];
  }

  // Get category colors
  Color getCategoryColor(String category) {
    switch (category) {
      case 'Development': return Colors.blue;
      case 'Education': return Colors.green;
      case 'Health': return Colors.red;
      case 'Work': return Colors.orange;
      default: return Colors.purple;
    }
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final maxCount = weeklyData.map((e) => e['count'] as int).reduce((a, b) => a > b ? a : b);

    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.background,
        elevation: 0,
        title: const Text(
          '📊 Statistics',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Period Selector
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: ['Week', 'Month', 'Year'].map((period) {
                final isSelected = selectedPeriod == period;
                return ChoiceChip(
                  label: Text(period),
                  selected: isSelected,
                  onSelected: (selected) {
                    setState(() {
                      selectedPeriod = period;
                    });
                  },
                  backgroundColor: isDark ? const Color(0xFF1E293B) : Colors.white,
                  selectedColor: Theme.of(context).colorScheme.primary.withOpacity(0.3),
                );
              }).toList(),
            ),

            const SizedBox(height: 24),

            // Main Statistics Cards
            Row(
              children: [
                Expanded(
                  child: _buildStatCard(
                    'Total Pomodoros',
                    totalPomodoros.toString(),
                    Icons.timer,
                    Colors.blue,
                    isDark,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: _buildStatCard(
                    'Total Hours',
                    '${(totalMinutes / 60).toStringAsFixed(1)}h',
                    Icons.access_time,
                    Colors.green,
                    isDark,
                  ),
                ),
              ],
            ),

            const SizedBox(height: 12),

            Row(
              children: [
                Expanded(
                  child: _buildStatCard(
                    'Tasks Done',
                    completedTasks.toString(),
                    Icons.check_circle,
                    Colors.orange,
                    isDark,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: _buildStatCard(
                    'Avg/Day',
                    averagePerDay.toStringAsFixed(1),
                    Icons.trending_up,
                    Colors.purple,
                    isDark,
                  ),
                ),
              ],
            ),

            const SizedBox(height: 24),

            // Streak Section
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Theme.of(context).colorScheme.primary,
                    Theme.of(context).colorScheme.primary.withOpacity(0.7),
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    color: Theme.of(context).colorScheme.primary.withOpacity(0.3),
                    blurRadius: 15,
                    offset: const Offset(0, 8),
                  ),
                ],
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Column(
                    children: [
                      const Icon(Icons.local_fire_department, color: Colors.white, size: 40),
                      const SizedBox(height: 8),
                      Text(
                        '${taskBox.length} Days',
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const Text(
                        'Active Days',
                        style: TextStyle(color: Colors.white70, fontSize: 12),
                      ),
                    ],
                  ),
                  Container(
                    height: 60,
                    width: 1,
                    color: Colors.white30,
                  ),
                  Column(
                    children: [
                      const Icon(Icons.emoji_events, color: Colors.white, size: 40),
                      const SizedBox(height: 8),
                      Text(
                        '${taskBox.length} Tasks',
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const Text(
                        'Total Tasks',
                        style: TextStyle(color: Colors.white70, fontSize: 12),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            const SizedBox(height: 24),

            // Weekly Activity Chart
            Text(
              'Weekly Activity',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Theme.of(context).colorScheme.onBackground,
              ),
            ),
            const SizedBox(height: 16),

            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: isDark ? const Color(0xFF1E293B) : Colors.white,
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.05),
                    blurRadius: 10,
                    offset: const Offset(0, 5),
                  ),
                ],
              ),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: weeklyData.map((data) {
                      final count = data['count'] as int;
                      final height = (count / maxCount) * 120;
                      final isToday = data['day'] == DateFormat('EEE').format(DateTime.now());

                      return Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            count.toString(),
                            style: TextStyle(
                              fontSize: 12,
                              color: Colors.grey[600],
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Container(
                            width: 32,
                            height: height.clamp(20, 120),
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                colors: isToday
                                    ? [
                                        Theme.of(context).colorScheme.primary,
                                        Theme.of(context).colorScheme.primary.withOpacity(0.6),
                                      ]
                                    : [
                                        Colors.grey.withOpacity(0.3),
                                        Colors.grey.withOpacity(0.2),
                                      ],
                                begin: Alignment.topCenter,
                                end: Alignment.bottomCenter,
                              ),
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            data['day'] as String,
                            style: TextStyle(
                              fontSize: 12,
                              color: isToday
                                  ? Theme.of(context).colorScheme.primary
                                  : Colors.grey[600],
                              fontWeight: isToday ? FontWeight.bold : FontWeight.normal,
                            ),
                          ),
                        ],
                      );
                    }).toList(),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 24),

            // Category Breakdown
            Text(
              'Category Breakdown',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Theme.of(context).colorScheme.onBackground,
              ),
            ),
            const SizedBox(height: 16),

            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: isDark ? const Color(0xFF1E293B) : Colors.white,
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.05),
                    blurRadius: 10,
                    offset: const Offset(0, 5),
                  ),
                ],
              ),
              child: categoryBreakdown.isEmpty
                  ? const Center(
                      child: Padding(
                        padding: EdgeInsets.all(20),
                        child: Text(
                          'No category data yet',
                          style: TextStyle(color: Colors.grey),
                        ),
                      ),
                    )
                  : Column(
                      children: categoryBreakdown.entries.map((entry) {
                        final total = categoryBreakdown.values.fold<int>(0, (sum, count) => sum + count);
                        final percentage = total > 0 ? ((entry.value / total * 100).toInt()) : 0;

                        return Padding(
                          padding: const EdgeInsets.only(bottom: 16),
                          child: Column(
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    children: [
                                      Container(
                                        width: 12,
                                        height: 12,
                                        decoration: BoxDecoration(
                                          color: getCategoryColor(entry.key),
                                          borderRadius: BorderRadius.circular(3),
                                        ),
                                      ),
                                      const SizedBox(width: 8),
                                      Text(
                                        entry.key,
                                        style: const TextStyle(fontSize: 14),
                                      ),
                                    ],
                                  ),
                                  Text(
                                    '${entry.value} ($percentage%)',
                                    style: const TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 8),
                              ClipRRect(
                                borderRadius: BorderRadius.circular(4),
                                child: LinearProgressIndicator(
                                  value: percentage / 100,
                                  backgroundColor: Colors.grey[300],
                                  valueColor: AlwaysStoppedAnimation<Color>(getCategoryColor(entry.key)),
                                  minHeight: 8,
                                ),
                              ),
                            ],
                          ),
                        );
                      }).toList(),
                    ),
            ),

            const SizedBox(height: 24),

            // Productivity Tips
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: isDark ? const Color(0xFF1E293B) : Colors.white,
                borderRadius: BorderRadius.circular(20),
                border: Border.all(
                  color: Theme.of(context).colorScheme.primary.withOpacity(0.3),
                  width: 2,
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(
                        Icons.lightbulb,
                        color: Theme.of(context).colorScheme.primary,
                        size: 24,
                      ),
                      const SizedBox(width: 8),
                      const Text(
                        'Productivity Insights',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  _buildInsight('Complete more tasks to see insights', Icons.lightbulb),
                  _buildInsight('Your productivity is tracked in real-time', Icons.trending_up),
                  _buildInsight('Keep adding tasks to build your streak!', Icons.local_fire_department),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStatCard(String title, String value, IconData icon, Color color, bool isDark) {
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
          Icon(icon, color: color, size: 28),
          const SizedBox(height: 8),
          Text(
            value,
            style: const TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            title,
            style: TextStyle(
              fontSize: 12,
              color: Colors.grey[600],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInsight(String text, IconData icon) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Row(
        children: [
          Icon(icon, size: 16, color: Colors.grey[600]),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              text,
              style: TextStyle(fontSize: 13, color: Colors.grey[700]),
            ),
          ),
        ],
      ),
    );
  }
}
