import 'package:hive/hive.dart';

part 'UserProfile.g.dart';

@HiveType(typeId: 1)
class UserProfile {
  @HiveField(0)
  final String name;
  
  @HiveField(1)
  final String email;
  
  @HiveField(2)
  final String bio;
  
  @HiveField(3)
  final DateTime joinDate;

  UserProfile({
    required this.name,
    required this.email,
    this.bio = '',
    required this.joinDate,
  });

  UserProfile copyWith({
    String? name,
    String? email,
    String? bio,
    DateTime? joinDate,
  }) {
    return UserProfile(
      name: name ?? this.name,
      email: email ?? this.email,
      bio: bio ?? this.bio,
      joinDate: joinDate ?? this.joinDate,
    );
  }
}
