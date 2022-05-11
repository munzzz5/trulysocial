import 'package:firebase_auth/firebase_auth.dart';

class AuthUser {
  final String id;
  final String email;
  final bool isEmailVerified;
  final String name;

  AuthUser(
      {required this.id,
      required this.email,
      required this.isEmailVerified,
      required this.name});

  factory AuthUser.fromFirebase(User user) {
    return AuthUser(
      id: user.uid,
      email: user.email!,
      isEmailVerified: user.emailVerified,
      name: user.displayName!,
    );
  }
}
