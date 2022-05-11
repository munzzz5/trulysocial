import 'package:trulysocial/services/auth/auth_user.dart';
import 'package:trulysocial/services/auth/firebase_auth_provider.dart';

import 'auth_provider.dart';

class AuthService implements AuthProvider {
  final FirebaseAuthProvider provider;
  const AuthService(this.provider);
  factory AuthService.firebase() => AuthService(FirebaseAuthProvider());
  @override
  AuthUser? get currentUser => provider.currentUser;

  @override
  Future<void> initialize() async {
    await provider.initialize();
  }

  @override
  Future<AuthUser> logIn(
      {required String email, required String password}) async {
    return await provider.logIn(email: email, password: password);
  }

  @override
  Future<void> logOut() async {
    await provider.logOut();
  }

  @override
  Future<void> sendEmailVerification() async {
    await provider.sendEmailVerification();
  }

  @override
  Future<AuthUser> signUp(
      {required String email,
      required String password,
      required String name}) async {
    return await provider.signUp(email: email, password: password, name: name);
  }
}
