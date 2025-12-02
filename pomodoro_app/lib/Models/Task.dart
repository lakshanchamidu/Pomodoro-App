import 'package:hive/hive.dart';

part 'Task.g.dart';

@HiveType(typeId: 0)
class Task {
  @HiveField(0)
  final String id;
  
  @HiveField(1)
  final String title;
  
  @HiveField(2)
  final String description;
  
  @HiveField(3)
  final String category;
  
  @HiveField(4)
  final int estimatedPomodoros;
  
  @HiveField(5)
  final int completedPomodoros;
  
  @HiveField(6)
  final bool isCompleted;
  
  @HiveField(7)
  final DateTime createdAt;
  
  @HiveField(8)
  final String priority; // High, Medium, Low

  Task({
    required this.id,
    required this.title,
    this.description = '',
    this.category = 'General',
    this.estimatedPomodoros = 1,
    this.completedPomodoros = 0,
    this.isCompleted = false,
    required this.createdAt,
    this.priority = 'Medium',
  });

  Task copyWith({
    String? id,
    String? title,
    String? description,
    String? category,
    int? estimatedPomodoros,
    int? completedPomodoros,
    bool? isCompleted,
    DateTime? createdAt,
    String? priority,
  }) {
    return Task(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      category: category ?? this.category,
      estimatedPomodoros: estimatedPomodoros ?? this.estimatedPomodoros,
      completedPomodoros: completedPomodoros ?? this.completedPomodoros,
      isCompleted: isCompleted ?? this.isCompleted,
      createdAt: createdAt ?? this.createdAt,
      priority: priority ?? this.priority,
    );
  }
}
