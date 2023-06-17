import 'package:equatable/equatable.dart';
import 'package:uuid/uuid.dart';

class User extends Equatable {
  const User(this.id);

  final String id;

  @override
  List<Object> get props => [id];

  static const empty = User('-');
}

class UserRepository {
  User? _user;

  Future<User?> getUser() async {
    if (_user != null) return _user;
    return Future.delayed(
      const Duration(milliseconds: 300),
      () => _user = User(const Uuid().v4()),
    );
  }
}