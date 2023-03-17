import 'package:equatable/equatable.dart';

import 'package:real_time_chat/features/authentication/domain/entities/user.dart';

class UsersResponse extends Equatable {
  final bool ok;
  final List<User> users;
  final int startFrom;

  const UsersResponse({
    required this.ok,
    required this.users,
    required this.startFrom,
  });

  @override
  List<Object?> get props => [
        ok,
        users,
        startFrom,
      ];
}
