// lib/models/user/reviewer.dart
import 'user.dart';
import '../../utils/enums.dart';

class Reviewer extends User {
  const Reviewer({
    required String id,
    required String name,
    required String email,
  }) : super(id: id, name: name, email: email, role: UserRole.reviewer);

  @override
  Map<String, dynamic> toMap() => {
    'id': id,
    'name': name,
    'email': email,
    'role': role.name,
  };
}
