import 'package:equatable/equatable.dart';

import 'package:real_time_chat/features/authentication/domain/entities/user.dart';

class AuthenticationResponse extends Equatable {
  final bool ok;
  final User user;
  final String token;

  const AuthenticationResponse({
    required this.ok,
    required this.user,
    required this.token,
  });

  @override
  List<Object?> get props => [
        ok,
        user,
        token,
      ];
}
