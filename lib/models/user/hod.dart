// lib/models/user/hod.dart
import 'user.dart';
import '../../utils/enums.dart';

class HOD extends User {
  const HOD({required String id, required String name, required String email})
    : super(id: id, name: name, email: email, role: UserRole.hod);

  @override
  Map<String, dynamic> toMap() => {
    'id': id,
    'name': name,
    'email': email,
    'role': role.name,
  };
}
