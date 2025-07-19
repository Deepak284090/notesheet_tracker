// lib/models/user/proposer.dart
import 'user.dart';
import '../../utils/enums.dart';

class Proposer extends User {
  const Proposer({
    required String id,
    required String name,
    required String email,
  }) : super(id: id, name: name, email: email, role: UserRole.proposer);

  @override
  Map<String, dynamic> toMap() => {
    'id': id,
    'name': name,
    'email': email,
    'role': role.name,
  };
}
