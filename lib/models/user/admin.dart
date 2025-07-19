// lib/models/user/admin.dart
import 'user.dart';
import '../../utils/enums.dart';

class Admin extends User {
  const Admin({required String id, required String name, required String email})
    : super(id: id, name: name, email: email, role: UserRole.admin);

  @override
  Map<String, dynamic> toMap() => {
    'id': id,
    'name': name,
    'email': email,
    'role': role.name,
  };
}
