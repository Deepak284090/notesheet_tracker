// lib/models/user/user.dart
import '../../utils/enums.dart';

abstract class User {
  final String id;
  final String name;
  final String email;
  final UserRole role;

  const User({
    required this.id,
    required this.name,
    required this.email,
    required this.role,
  });

  Map<String, dynamic> toMap();
}
